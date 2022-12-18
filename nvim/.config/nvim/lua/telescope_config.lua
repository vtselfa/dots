require('telescope').setup{
    defaults = {
        layout_config = { preview_width = 0.5 }
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- ..
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}
require('telescope').load_extension('zf-native')
require("telescope").load_extension("ui-select")


local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

-- Find Files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- Find files in Working directory
vim.keymap.set('n', '<leader>fw', function()
    builtin.find_files {cwd = utils.buffer_dir()}
end, {})

-- Find Git files
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

-- Search for word Live
vim.keymap.set('n', '<leader>sl', builtin.live_grep, {})

-- Search for Word
vim.keymap.set('n', '<leader>sw', builtin.grep_string, {})

-- Search for word in current Buffer
vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, {})

-- Search Help
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})

-- Search Command history
vim.keymap.set('n', '<leader>sc', builtin.command_history, {})

-- Diagnostics
vim.keymap.set('n', '<leader>dd', builtin.diagnostics, {})

-- Diagnostics for current Buffer
vim.keymap.set('n', '<leader>db', function() builtin.diagnostics {bufnr = 0} end, {})

-- Telescope Resume previous session
vim.keymap.set('n', '<leader>tr', builtin.resume, {})

-- Buffers
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})

-- Tabs
vim.keymap.set('n', '<leader>tt', require('telescope-tabs').list_tabs, {})

-- Tab Return (to the previous one)
vim.keymap.set('n', '<space>t', require('telescope-tabs').go_to_previous, {})

