return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
        { "gR", "<cmd>Trouble lsp_references toggle focus=false<cr>", desc = "LSP references" },
    },
}
