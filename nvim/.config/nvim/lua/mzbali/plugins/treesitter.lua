return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "c_sharp", "lua", "python", "bash", "dockerfile",
            "javascript", "typescript", "tsx",
            "markdown", "markdown_inline",
            "json", "html", "css", "yaml",
            "vimdoc",
        })
    end
}
