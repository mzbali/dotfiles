return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "3rd/image.nvim",

        },
        opts = {
            completions = { lsp = { enabled = true } },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.markdownlint_cli2,
                    null_ls.builtins.formatting.prettier,
                },
            })
        end,
    },
}
