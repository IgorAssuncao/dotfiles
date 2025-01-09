-- Bridges mason and nvim-lsp
return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        {
            "lvimuser/lsp-inlayhints.nvim",
            -- ONLY NECESSARY TO HAVE VIRTUAL TEXT
            -- ONLY WORKS WITH NEOVIM NIGHTLY (v0.10)
            branch = "anticonceal"
        }
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup {
            ensure_installed = BASE.get_all_lsp_servers_names(),
            automatic_installation = true
        }

        local default_setup_opts = {}

        local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not status_cmp_nvim_lsp then
            vim.notify("Error from plugins.lsp.mason_lspconfig: cmp_nvim_lsp not found")
        else
            local client_capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_capabilities = cmp_nvim_lsp.default_capabilities()
            local capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)

            default_setup_opts = {
                capabilities = capabilities,
                single_file_support = true,
                on_attach = function(client, bufnr)
                    local status_lsp_inlay_hints, lsp_inlay_hints = pcall(require, "lsp-inlayhints")
                    if not status_lsp_inlay_hints then
                        vim.notify("Error from plugins.lsp.mason_lspconfig: lsp-inlayhints not found")
                    else
                        lsp_inlay_hints.on_attach(client, bufnr, true)

                        -- vim.lsp.codelens.display(
                        --     vim.lsp.codelens.get(bufnr),
                        --     bufnr,
                        --     client.id
                        -- )
                    end

                    local status_which_key, which_key = pcall(require, "which-key")
                    if not status_which_key then
                        vim.notify("Error from plugins.lsp.mason_lspconfig: which-key not found.")
                    else
                        BASE.set_lsp_keymaps(bufnr, which_key)

                        local status_telescope_builtin, telescope_builtin = pcall(require, "telescope.builtin")
                        if not status_telescope_builtin then
                            vim.notify("Error from plugins.lsp.mason_lspconfig: telescope.builtin not found.")
                        else
                            which_key.add({
                                { "<leader>Da", telescope_builtin.diagnostics, desc = "[A]ll" },
                            })
                        end
                    end

                    if client.name == "tsserver" then
                        -- client.server_capabilities.codeActionProvider = false
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                    end
                end
            }
        end

        local status_lspconfig, lspconfig = pcall(require, "lspconfig")
        if not status_lspconfig then
            vim.notify("Error from plugins.lsp.mason_lspconfig: lspconfig not found.")
        else
            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup(default_setup_opts)
                end
            })
        end

        local lsp_servers = BASE.defaults.lsp_servers

        for k, v in pairs(lsp_servers) do
            local require_ok, server_setup = pcall(require, "plugins.lsp.servers." .. k)
            if require_ok then
                local default_opts = vim.tbl_deep_extend("force", default_setup_opts, {})

                local server_opts = server_setup(default_opts)
                local opts = vim.tbl_deep_extend("force", default_opts, server_opts)

                -- else
                --   vim.notify("Error from plugins.p_lsp.mason.handlers: requiring servers." .. k .. " not found.")

                lspconfig[v].setup(opts)
            end
        end

        --   lspconfig[lsp_servers.terraform_lint].setup {
        --     capabilities = capabilities,
        --     root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
        --     filetypes = {
        --       "terraform",
        --       "terraform-vars",
        --       ".tf",
        --       ".tfvars",
        --       "*.tfvars*"
        --     }
        --   }
        -- local configs = require("lspconfig.configs")
        -- if not configs["tflint"] then
        --   configs["tflint"] = {
        --     default_config = {
        --       cmd = { "tflint" },
        --       filetypes = { "terraform" },
        --       root_dir = lspconfig.util.root_pattern(".git")
        --     }
        --   }
        -- end,
        -- lspconfig.ruff_lsp.setup {
        --   on_attach = on_attach
        -- },
        -- lspconfig.server_configurations.setup {
        --   ["ruff"] = {
        --     on_attach = on_attach
        --   }
        -- }
    end
}
