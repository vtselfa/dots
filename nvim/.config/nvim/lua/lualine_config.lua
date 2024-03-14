require('lualine').setup {
    extensions = { 'quickfix', 'aerial', 'fugitive', 'man', 'nvim-tree' },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 3, color = { fg = '#fabd2f' } } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    tabline = {
        lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns } },
    }
}

vim.keymap.set("n", "<Leader>rt", ':LualineRenameTab ', {})
