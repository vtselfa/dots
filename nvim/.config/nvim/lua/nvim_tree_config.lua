require("nvim-tree").setup {
    renderer = {
        icons = {
          git_placement = "after",
          show = {
            file = false,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
        special_files = {},
    }
}

vim.keymap.set('n', '<space>e', '<cmd>NvimTreeFindFile<CR>')
