vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup('delete_trailing_spaces_on_save', { clear = true }),
    pattern = { 'c', 'cpp', 'python', 'tex', 'vim', 'lua' },
    command = [[autocmd BufWritePre <buffer> :%s/\s\+$//e]]
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = vim.api.nvim_create_augroup('start_insert_on_entering_terminal', { clear = true }),
    pattern = { 'term://*' },
    command = 'startinsert'
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = vim.api.nvim_create_augroup('stop_insert_on_leaving_terminal', { clear = true }),
    pattern = { 'term://*' },
    command = 'stopinsert'
})
