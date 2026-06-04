return {
    "3rd/image.nvim",
    ft = { "markdown" },
    build = false,
    cond = function()
        return #vim.api.nvim_list_uis() > 0
    end,
    opts = {
        backend = "kitty",
        processor = "magick_cli",
    },
}
