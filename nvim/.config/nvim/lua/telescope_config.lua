local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local actions_layout = require("telescope.actions.layout")
local transform_mod = require("telescope.actions.mt").transform_mod

-- From https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/telescope.lua
local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit",
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then
                    return
                end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
        multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
        multiopen(prompt_bufnr, "default")
    end,
})

local function stopinsert(callback)
    return function(prompt_bufnr)
        vim.cmd.stopinsert()
        vim.schedule(function()
            callback(prompt_bufnr)
        end)
    end
end

require('telescope').setup {
    defaults = {
        layout_config = { preview_width = 0.5 },
        mappings = {
            i = {
                ["<C-Down>"] = actions.preview_scrolling_down,
                ["<C-Up>"] = actions.preview_scrolling_up,
                ["<C-o>"] = actions_layout.toggle_preview,
                ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
                ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
                ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
                ["<CR>"] = stopinsert(custom_actions.multi_selection_open),
            },
            n = {
                ["<C-Down>"] = actions.preview_scrolling_down,
                ["<C-Up>"] = actions.preview_scrolling_up,
                ["<C-o>"] = actions_layout.toggle_preview,
                ["<C-v>"] = custom_actions.multi_selection_open_vertical,
                ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
                ["<C-t>"] = custom_actions.multi_selection_open_tab,
                ["<CR>"] = custom_actions.multi_selection_open,
            }
        }
    },
}
require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

-- Find Files (including hidden ones)
vim.keymap.set('n', '<leader>ff', function() builtin.find_files { hidden = true } end, {})

-- Find files in the directory of the Current buffer
vim.keymap.set('n', '<leader>fc', function()
    builtin.find_files { cwd = utils.buffer_dir() }
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

-- Diagnostics for Current buffer
vim.keymap.set('n', '<leader>dc', function() builtin.diagnostics { bufnr = 0 } end, {})

-- Telescope Resume previous session
vim.keymap.set('n', '<leader>tr', builtin.resume, {})

-- Buffers
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})

-- Tabs
vim.keymap.set('n', '<leader>tt', require('telescope-tabs').list_tabs, {})

-- Tab Return (to the previous one)
vim.keymap.set('n', '<space>t', require('telescope-tabs').go_to_previous, {})
