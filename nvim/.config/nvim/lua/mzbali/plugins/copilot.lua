return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    accept = false,
                    auto_trigger = true,
                },
                filetypes = {
                    gitcommit = false,
                    gitrebase = false,
                },
            })
        end,
    },

    'AndreM222/copilot-lualine',
}
