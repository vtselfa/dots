local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- As you press keys, it tells you which commands are available
    "folke/which-key.nvim",

    -- Package manager for easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters
    "williamboman/mason.nvim",

    'tpope/vim-unimpaired',

    -- Lets you highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters.
    { 'andymass/vim-matchup',            event = 'VimEnter' },

    -- Provides a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it:
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },

    -- Colorscheme
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd('colorscheme gruvbox')
        end
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- Git changes shown in the gutter
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end
    },

    -- Highly extendable fuzzy finder over lists
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },                                                  -- Faster sorter with fzf syntax
            { "nvim-telescope/telescope-live-grep-args.nvim" }, -- Pass custom arguments to rg during live grep
            'nvim-telescope/telescope-ui-select.nvim'           -- Use telescope for vim.ui.select
        }
    },

    -- File browser based on telescope
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { 'nvim-telescope/telescope.nvim' },
    },

    -- Select tab using telescope
    {
        'LukasPietzschmann/telescope-tabs',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require 'telescope-tabs'.setup {
            }
        end
    },

    -- Powerful diffs on the whole workspace
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    },

    -- Diffs arbitrary selections inside vim
    {
        'rickhowe/spotdiff.vim',
        dependencies = 'rickhowe/diffchar.vim',
    },

    -- Easily comment out lines
    { 'tomtom/tcomment_vim' },

    -- Configurations for Nvim LSP
    { 'neovim/nvim-lspconfig' },

    -- Rust support
    {
        'rust-lang/rust.vim',
        config = function()
            vim.g.rustfmt_autosave = 1 -- Run rustfmt on save
        end
    },

    -- A suite of goodies for Rust
    { 'simrat39/rust-tools.nvim' },

    -- Non-liniear undo history
    { 'mbbill/undotree' },

    -- Temporary fix until inlay hints are implemented by neovim itself
    { 'lvimuser/lsp-inlayhints.nvim' },

    --  A simple, easy-to-use Vim alignment plugin.
    {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set('v', '<Enter>', [[<Plug>(EasyAlign)]])
            vim.keymap.set('n', 'ga', [[<Plug>(EasyAlign)]])
        end
    },

    -- Git integration
    { 'tpope/vim-fugitive' },

    -- Automatically follow the symlinks in Vim.
    -- This means that when you edit a pathname that is a symlink, vim will instead open the file using the resolved target path
    { 'aymericbeaumet/vim-symlink', dependencies = 'moll/vim-bbye' },

    -- Vim plugin to provide text objects to select a portion of the current line
    { 'kana/vim-textobj-line',      dependencies = 'kana/vim-textobj-user' },

    -- Sudo
    { 'chrisbra/SudoEdit.vim' },

    -- CSV
    -- { 'chrisbra/csv.vim' },
    { 'mechatroner/rainbow_csv' },

    -- Mark multiple words and all their occurences with different colors
    -- Defines <leader> m,n,r,*,/
    { 'inkarkat/vim-mark',          dependencies = { 'inkarkat/vim-ingo-library' } },

    -- Enable repeating supported plugin maps
    { 'tpope/vim-repeat' },

    -- Add/modify surroundings " ' [] etc
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- Vim sugar for the UNIX shell commands that need it the most.
    { 'tpope/vim-eunuch' },

    -- Easily search for, substitute, and abbreviate multiple variants of a word
    {
        "tpope/vim-abolish",
        config = function()
            -- Disable coercion mappings. I use coerce.nvim for that.
            vim.g.abolish_no_mappings = true
        end,
    },

    -- Quickly change a keyword’s case
    {
        "gregorias/coerce.nvim",
        tag = 'v1.0',
        config = true,
    },

    -- Updated cmake syntax
    { 'pboettch/vim-cmake-syntax' },

    -- Vertical lines that indicate indentation level
    { "lukas-reineke/indent-blankline.nvim", },

    -- Side panel with the document symbols
    { 'stevearc/aerial.nvim' },

    -- A fancy, configurable, notification manager for NeoVim
    {
        "rcarriga/nvim-notify",
        event = "UIEnter",
        config = function()
            local notify = require("notify")
            notify.setup {}
            vim.notify = notify

            local vim_notify = vim.notify
            vim.notify = function(msg, ...)
                if msg:match("warning: multiple different client offset_encodings") then
                    return
                end

                vim_notify(msg, ...)
            end

            vim.keymap.set("n", "<esc>", function()
                notify.dismiss()
                vim.cmd.noh()
            end)
            vim.lsp.handlers["window/showMessage"] = function(_, method, params, _)
                vim.notify(method.message, params.type)
            end
        end,
    },

    -- YAML lsp config and schema autodetection and download
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
    },

    -- Simple tools to help developers working with YAML
    {
        "cuducos/yaml.nvim",
        ft = { "yaml" }, -- optional
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim" -- optional
        },
    },

    { "mickael-menu/zk-nvim" },

    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "RRethy/vim-illuminate",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },

    -- Refactoring library based off the Refactoring book by Martin Fowler
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },

    { 'terrastruct/d2-vim' },

    { 'toppair/peek.nvim',   build = 'deno task --quiet build:fast' },

    -- focus on a selected region while making the rest inaccessible
    {
        'chrisbra/NrrwRgn',
        config = function()
            vim.cmd [[
              command! -nargs=* -bang -range -complete=filetype NN
                  \ :<line1>,<line2> call nrrwrgn#NrrwRgn('',<q-bang>)
                  \ | set filetype=<args>
            ]]
        end,
    },

    -- Clipboard management
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { 'kkharji/sqlite.lua', module = 'sqlite' },
        },
        config = function()
            require('neoclip').setup {
                history = 5000,
                enable_persistent_history = true,
                continuous_sync = true,
                on_paste = {
                    close_telescope = false,
                },
            }
            require("telescope").load_extension("neoclip")
            require("telescope").load_extension("macroscope")
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            { 'L3MON4D3/LuaSnip', dependencies = { "rafamadriz/friendly-snippets" } },
            'saadparwaiz1/cmp_luasnip',
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "andersevenrud/cmp-tmux",
        }
    },

    {
        "onsails/lspkind-nvim",
        config = function()
            require("lspkind").init({
                mode = "symbol_text",
                preset = "codicons",
                symbol_map = {
                    Copilot = "",
                },
            })
        end,
    },

    -- To measure Neovim's startup times
    { 'dstein64/vim-startuptime' },

    {
        'tzachar/cmp-tabnine',
        build = './install.sh',
        config = function()
            local tabnine = require('cmp_tabnine.config')
            tabnine:setup({
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = '..',
                ignored_file_types = {
                    -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                },
                show_prediction_strength = false
            })
        end,

    },

    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
})
