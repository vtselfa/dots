return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Package manager for easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters
    use { "williamboman/mason.nvim", config = function() require("mason").setup() end }

    -- Lazy loading:
    -- Load on specific commands
    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

    -- Load on an autocommand event
    use { 'andymass/vim-matchup', event = 'VimEnter' }

    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Colorscheme
    use { 'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd('colorscheme gruvbox')
        end
    }

    -- File explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        tag = 'nightly'
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Use dependency and run lua function after load
    use {
        'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end
    }

    -- Highly extendable fuzzy finder over lists
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- Faster sorter with fzf syntax
            { "nvim-telescope/telescope-live-grep-args.nvim" }, -- Pass custom arguments to rg during live grep
            'nvim-telescope/telescope-ui-select.nvim' -- Use telescope for vim.ui.select
        }
    }

    -- File browser based on telescope
    use { "nvim-telescope/telescope-file-browser.nvim",
        requires = { 'nvim-telescope/telescope.nvim' },
    }

    -- Select tab using telescope
    use {
        'LukasPietzschmann/telescope-tabs',
        requires = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require 'telescope-tabs'.setup {
                -- Your custom config :^)
            }
        end
    }

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    })

    -- Easily comment out lines
    use { 'tomtom/tcomment_vim' }

    -- Configurations for Nvim LSP
    use { 'neovim/nvim-lspconfig' }

    -- Autocompletion and snippets
    use { 'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            -- Snippets
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        }
    }

    -- Rust support
    use { 'rust-lang/rust.vim', config = function()
        vim.g.rustfmt_autosave = 1 -- Run rustfmt on save
    end
    }

    -- A suite of goodies for Rust
    use { 'simrat39/rust-tools.nvim' }

    -- Non-liniear undo history
    use { 'mbbill/undotree' }

    -- Temporary fix until inlay hints are implemented by neovim itself
    use { 'lvimuser/lsp-inlayhints.nvim' }

    --  A simple, easy-to-use Vim alignment plugin.
    use { 'junegunn/vim-easy-align', config = function()
        vim.keymap.set('v', '<Enter>', [[<Plug>(EasyAlign)]])
        vim.keymap.set('n', 'ga', [[<Plug>(EasyAlign)]])
    end
    }

    -- Git integration
    use { 'tpope/vim-fugitive' }

    -- Automatically follow the symlinks in Vim.
    -- This means that when you edit a pathname that is a symlink, vim will instead open the file using the resolved target path
    use { 'moll/vim-bbye' }
    use { 'aymericbeaumet/vim-symlink' }

    -- Toggle between header and source
    use { 'vim-scripts/a.vim' }

    -- Sudo
    use { 'chrisbra/SudoEdit.vim' }

    -- CSV
    use { 'chrisbra/csv.vim' }

    -- Mark multiple words and all their occurences with different colors
    -- Defines <leader> m,n,r,*,/
    use { 'inkarkat/vim-mark', requires = { 'inkarkat/vim-ingo-library' } }

    -- Enable repeating supported plugin maps
    use { 'tpope/vim-repeat' }

    -- Add/modify surroundings " ' [] etc
    use { 'tpope/vim-surround' }

    -- Vim sugar for the UNIX shell commands that need it the most.
    use { 'tpope/vim-eunuch' }

    -- Easily search for, substitute, and abbreviate multiple variants of a word
    use { 'tpope/vim-abolish' }

    -- Updated cmake syntax
    use { 'pboettch/vim-cmake-syntax' }

    -- Vertical lines that indicate indentation level
    use { 'Yggdroot/indentLine' }

    -- Side panel with the document symbols
    use { 'stevearc/aerial.nvim' }

    use { "rcarriga/nvim-notify",
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
    }

    -- YAML lsp config and schema autodetection and download
    use {
        "someone-stole-my-name/yaml-companion.nvim",
        requires = {
            { "neovim/nvim-lspconfig" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
    }

    -- Simple tools to help developers working with YAML
    use {
        "cuducos/yaml.nvim",
        ft = { "yaml" }, -- optional
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim" -- optional
        },
    }

    -- use { 'suan/vim-instant-markdown' }, {'for': 'markdown'}
end)
