local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

-- Change border of documentation hover window and signature help
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local telescope = require('telescope.builtin')
local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
    vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)
    vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
    vim.keymap.set('n', 'go', telescope.lsp_type_definitions, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>rs', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, bufopts)

    -- if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
    -- end
end

-- Temporary fix for inlay hints
require("lsp-inlayhints").setup()
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr, false)
    end,
})

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {}
    }
}

require 'lspconfig'.bashls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require 'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

require 'lspconfig'.jsonls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-- Rust LSP, via rust-tools
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    inlay_hints = {
        -- The plugin lsp-inlayhints is taking care of this
        auto = false,
    },
})

local cfg = require("yaml-companion").setup({
    lspconfig = {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
    },
})
require("lspconfig")["yamlls"].setup(cfg)

-- Zettelkasten
require("zk").setup({
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    picker = "telescope",
    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        },
        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.refactoring,
        -- shell
        null_ls.builtins.code_actions.shellcheck,
        -- protobuf
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.protolint,
        -- python
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.black,
        -- spell
        null_ls.builtins.completion.spell,
    },
    on_attach = on_attach,
})
