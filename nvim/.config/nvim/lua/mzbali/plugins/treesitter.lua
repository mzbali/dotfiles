return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "c_sharp", "lua", "python", "bash", "dockerfile",
            "javascript", "typescript", "tsx",
            "markdown", "markdown_inline",
            "json", "html", "css", "yaml", "razor",
            "vimdoc",
        }

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("MzbaliTreesitterStart", { clear = true }),
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end
}
