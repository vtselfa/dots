require("ibl").setup {
    exclude = {
        buftypes = { "terminal", "prompt", "nofile" },
        filetypes = {
            'help',
            'dashboard',
            'Trouble',
            'dap.*',
            'NvimTree',
            "packer"
        }
    },
    scope = {
        show_start = false,
        show_end = false,
        char = "┊",
    },
    indent = { char = "┊" },
}
