local null_ls = require("null-ls")

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
    end
end
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
})
