return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "pyright", "bashls", "dockerls",
                    "docker_compose_language_service", "ts_ls",
                    "eslint", "jsonls", "rust_analyzer",
                },
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Lua specific config
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        telemetry = { enable = false },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- Roslyn specific config
            vim.lsp.config("roslyn", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                    },
                    ["csharp|completion"] = {
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                    },
                },
            })

            -- Standard servers loop
            local servers = {
                "pyright", "bashls", "dockerls", "docker_compose_language_service",
                "ts_ls", "eslint", "jsonls", "rust_analyzer",
            }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, { capabilities = capabilities })
            end
            vim.lsp.enable(servers)
        end
    },
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
            broad_search = true,
        },
        config = function(_, opts)
            require("roslyn").setup(opts)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "path" },
                    { name = "buffer",  keyword_length = 3 },
                }),
            })
        end
    },
}
