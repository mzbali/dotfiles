local active = "catppuccin" -- "catppuccin" | "tokyonight" | "rose-pine" | "github"

local themes = {
    catppuccin = {
        plugin = "catppuccin/nvim",
        name   = "catppuccin",
        setup  = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte | frappe | macchiato | mocha
                transparent_background = true,
                integrations = {
                    treesitter = true,
                    telescope  = { enabled = true },
                    native_lsp = {
                        enabled      = true,
                        virtual_text = {
                            errors      = { "italic" },
                            hints       = { "italic" },
                            warnings    = { "italic" },
                            information = { "italic" },
                        },
                        underlines   = {
                            errors      = { "underline" },
                            hints       = { "underline" },
                            warnings    = { "underline" },
                            information = { "underline" },
                        },
                    },
                    harpoon    = true,
                    gitsigns   = true,
                    mason      = true,
                    trouble    = true,
                },
            })
        end,
    },
    tokyonight = {
        plugin = "folke/tokyonight.nvim",
        setup  = function()
            require("tokyonight").setup({
                style = "night", -- storm | night | moon | day
                integrations = {
                    -- tokyonight auto-integrates most plugins
                    -- override highlights here if needed
                },
            })
        end,
    },
    ["rose-pine"] = {
        plugin = "rose-pine/neovim",
        name   = "rose-pine",
        setup  = function()
            require("rose-pine").setup({
                variant = "moon", -- auto | main | moon | dawn
                highlight_groups = {
                    -- override specific highlights here
                    -- e.g. CursorLine = { bg = "foam", blend = 10 }
                },
            })
        end,
    },
    github = {
        plugin      = "projekt0n/github-nvim-theme",
        colorscheme = "github_dark_dimmed",
        setup       = function()
            require("github-theme").setup({
                options = {
                    transparent = true,
                },
            })
        end,
    },
}

local t = themes[active]
return {
    t.plugin,
    name     = t.name,
    lazy     = false,
    priority = 1000,
    config   = function()
        t.setup()
        vim.cmd("colorscheme " .. (t.colorscheme or active))
    end,
}
