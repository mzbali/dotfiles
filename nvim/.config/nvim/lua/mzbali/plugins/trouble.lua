return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
        vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle({ mode = "diagnostics" }) end)
        vim.keymap.set("n", "<leader>xd",
            function() require("trouble").toggle({ mode = "diagnostics", filter = { buf = 0 } }) end)
        vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle({ mode = "quickfix" }) end)
        vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle({ mode = "loclist" }) end)
        vim.keymap.set("n", "gR", function() require("trouble").toggle({ mode = "lsp_references" }) end)
    end,
}
