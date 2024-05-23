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
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN]  = '',
            [vim.diagnostic.severity.HINT]  = '⚑',
            [vim.diagnostic.severity.INFO]  = '',
        },
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

    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)

    if client and client.supports_method('textDocument/inlayHint') then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

local lsp = require("lspconfig")
local lsp_flags = {}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.workspace = {
    didChangeWatchedFiles = {
        dynamicRegistration = false
    }
}


-------------------------------------------------------------------------------
-- PYTHON
-- ----------------------------------------------------------------------------
lsp.ruff_lsp.setup {
    on_attach = function(client, bufnr)
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
    end,
}

lsp.pyright.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
            },
        },
    },
}

-------------------------------------------------------------------------------
-- C / C++
-------------------------------------------------------------------------------
lsp.clangd.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-------------------------------------------------------------------------------
-- TYPESCRIPT
-------------------------------------------------------------------------------
lsp.tsserver.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-------------------------------------------------------------------------------
-- BASH
-------------------------------------------------------------------------------
lsp.bashls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-------------------------------------------------------------------------------
-- LUA
-------------------------------------------------------------------------------
lsp.lua_ls.setup {
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

-------------------------------------------------------------------------------
-- JSON
-------------------------------------------------------------------------------
lsp.jsonls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-------------------------------------------------------------------------------
-- RUST
-------------------------------------------------------------------------------
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
                files = {
                    excludeDirs = {
                        "/Users/vicent.selfa/.rustup",
                        ".cargo",
                        ".config",
                        ".git",
                        ".gitlab",
                        ".sqlx",
                        "chart-values",
                        "target",
                    }
                },
                cargo = { targetDir = true },
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}

-------------------------------------------------------------------------------
-- YAML
-------------------------------------------------------------------------------
local cfg = require("yaml-companion").setup({
    lspconfig = {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                customTags = { "!e", "!f", "!env", "!req" },
            },
        },
    },
})
lsp["yamlls"].setup(cfg)


-------------------------------------------------------------------------------
-- ZETTELKASTEN
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- NONE LS
-------------------------------------------------------------------------------
local none_ls = require("null-ls")
none_ls.setup({
    sources = {
        none_ls.builtins.code_actions.refactoring,
        -- shell
        none_ls.builtins.formatting.shellharden,
        -- protobuf
        none_ls.builtins.diagnostics.buf,
        none_ls.builtins.diagnostics.protolint,
        -- python
        -- none_ls.builtins.diagnostics.ruff,
        none_ls.builtins.diagnostics.pylint,
        none_ls.builtins.formatting.black,
        -- spell
        none_ls.builtins.completion.spell,
    },
    on_attach = on_attach,
})
