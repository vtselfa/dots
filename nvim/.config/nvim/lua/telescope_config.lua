local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local actions_layout = require("telescope.actions.layout")
local transform_mod = require("telescope.actions.mt").transform_mod
local lga_actions = require("telescope-live-grep-args.actions")
local fb_actions = require "telescope".extensions.file_browser.actions
local builtin = require('telescope.builtin')

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

        for _, entry in ipairs(multi_selection) do
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
                local command = edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = edit_file_cmd_map[method]
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

-- Default value for the telescope find_files builtin picker
vim.g.telescope_find_files_show_hidden = true
require('telescope').setup {
    defaults = {
        layout_config = { preview_width = 0.5 },
        path_display = { "absolute" },
        mappings = {
            i = {
                ["<S-Down>"] = actions.preview_scrolling_down,
                ["<S-Up>"] = actions.preview_scrolling_up,
                ["<C-o>"] = actions_layout.toggle_preview,
                ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
                ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
                ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
                ["<CR>"] = stopinsert(custom_actions.multi_selection_open),
            },
            n = {
                ["<S-Down>"] = actions.preview_scrolling_down,
                ["<S-Up>"] = actions.preview_scrolling_up,
                ["<C-o>"] = actions_layout.toggle_preview,
                ["<C-v>"] = custom_actions.multi_selection_open_vertical,
                ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
                ["<C-t>"] = custom_actions.multi_selection_open_tab,
                ["<CR>"] = custom_actions.multi_selection_open,
            }
        },
    },
    pickers = {
        current_buffer_tags = { fname_width = 100, },
        jumplist = { fname_width = 100, },
        loclist = { fname_width = 100, },
        lsp_definitions = { fname_width = 100, },
        lsp_document_symbols = { fname_width = 100, },
        lsp_dynamic_workspace_symbols = { fname_width = 100, },
        lsp_implementations = { fname_width = 100, },
        lsp_incoming_calls = { fname_width = 100, },
        lsp_outgoing_calls = { fname_width = 100, },
        lsp_references = { fname_width = 1000, },
        lsp_type_definitions = { fname_width = 100, },
        lsp_workspace_symbols = { fname_width = 100, },
        quickfix = { fname_width = 100, },
        tags = { fname_width = 100, },
        find_files = {
            mappings = {
                i = {
                    -- Toggle showing hidden files
                    ["<C-e>"] = function(prompt_bufnr)
                        vim.g.telescope_find_files_show_hidden = not vim.g.telescope_find_files_show_hidden

                        local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                        local prompt_text = current_picker:_get_prompt()
                        actions.close(prompt_bufnr)
                        builtin.find_files({
                            cwd = current_picker.cwd,
                            hidden = vim.g.telescope_find_files_show_hidden
                        })

                        vim.schedule(function()
                            vim.fn.feedkeys(prompt_text, "n")
                        end)
                    end,
                },
            },
        },
    },
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = {
                -- extend mappings
                i = {
                    ['<C-">'] = lga_actions.quote_prompt(),
                    ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                    ["<C-e>"] = lga_actions.quote_prompt({ postfix = " -t " }),
                    ["<C-f>"] = actions.to_fuzzy_refine,
                },
            },
        },
        file_browser = {
            mappings = {
                -- extend mappings
                i = {
                    ["<C-e>"] = fb_actions.toggle_hidden,
                    ["<C-Space>"] = fb_actions.goto_parent_dir,
                },
                n = {
                    ["<C-e>"] = fb_actions.toggle_hidden,
                    ["<C-Space>"] = fb_actions.goto_parent_dir,
                },
            },
        },
    }
}
require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("live_grep_args")

local utils = require('telescope.utils')
local map = vim.keymap.set

map('n', '<leader>ff', function() builtin.find_files { hidden = vim.g.telescope_find_files_show_hidden } end,
    { desc = "Telescope: Find files" })

map('n', '<leader>fc',
    function() require('telescope').extensions.file_browser.file_browser { path = utils.buffer_dir() } end,
    { desc = "Telescope: Browse from the buffer's directory" })

map('n', '<leader>fg', builtin.git_files,
    { desc = "Telescope: Find files in git" })

map('n', '<leader>sl', require("telescope").extensions.live_grep_args.live_grep_args,
    { desc = "Telescope: Live grep" })

map('n', '<leader>sw', builtin.grep_string,
    { desc = "Telescope: Search for word" })

map('x', "<leader>sw", require("telescope.builtin").grep_string,
    { desc = "Telescope: Search for word" })

map('n', '<leader>sb', builtin.current_buffer_fuzzy_find,
    { desc = "Telescope: Search in current buffer" })

map('n', '<leader>sh', builtin.help_tags,
    { desc = "Telescope: Search help" })

map('n', '<leader>sc', builtin.command_history,
    { desc = "Telescope: Search command history" })

map('n', '<leader>ss', builtin.lsp_workspace_symbols,
    { desc = "Telescope: Search symbols in the workspace" })

map('n', '<leader>dd', builtin.diagnostics,
    { desc = "Telescope: Diagnostics" })

map("n", "<leader>sq", require("telescope.builtin").quickfix,
    { desc = "Telescope: Quickfix" })

map('n', '<leader>dc', function() builtin.diagnostics { bufnr = 0 } end,
    { desc = "Telescope: Diagnostics for current buffer" })

map('n', '<leader>tr', builtin.resume,
    { desc = "Telescope: Resume previous session" })

map('n', '<leader>bb', builtin.buffers,
    { desc = "Telescope: Buffers" })

map('n', '<leader>tt', require('telescope-tabs').list_tabs,
    { desc = "Telescope: Tabs" })

map('n', '<space>t', require('telescope-tabs').go_to_previous,
    { desc = "Return to the last visited tab" })

map('n', '<leader>fm', builtin.marks,
    { desc = "Telescope: Marks" })

map("n", "<leader>fj", require("telescope.builtin").jumplist,
    { desc = "Telescope: Jumplist" })

map("n", '<leader>s"', require("telescope.builtin").registers,
    { desc = "Telescope: Registers" })

map("n", "<leader>T", function() require("telescope.builtin").builtin({ include_extensions = true }) end,
    { desc = "Telescope: List pickers" })

map("n", "<leader>st", require("telescope.builtin").treesitter,
    { desc = "Telescope: Treesitter" })
