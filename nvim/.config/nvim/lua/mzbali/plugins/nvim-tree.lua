return {
    "nvim-tree/nvim-tree.lua",
    cmd = {
        "NvimTreeToggle",
        "NvimTreeFocus",
        "NvimTreeFindFile",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
        { "<leader>E", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal current file in tree" },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 32,
                side = "left",
            },
            filters = {
                dotfiles = false,
            },
            git = {
                ignore = false,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            renderer = {
                group_empty = true,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },
        })
    end,
}
