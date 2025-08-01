-- NeoVim LSP
return {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
        vim.lsp.inlay_hint.enable(true, { bufnr = nil })

        -- inlay_hints = {
        --     labels_separator = " - ",
        --     parameter_hints = {
        --         show = true,
        --         prefix = "PT: <- ",
        --         separator = ", ",
        --         remove_colon_start = false,
        --         remove_colon_end = true,
        --     },
        --     type_hints = {
        --         -- type and other hints
        --         show = true,
        --         prefix = "RT: ",
        --         separator = ", ",
        --         remove_colon_start = false,
        --         remove_colon_end = false,
        --     },
        -- }

        local lsp_servers = BASE.defaults.lsp_servers

        local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not status_cmp_nvim_lsp then
            vim.notify("Error from plugins.lsp.nvim_lspconfig: cmp_nvim_lsp not found")
        else
            local client_capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_capabilities = cmp_nvim_lsp.default_capabilities()
            local capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)

            local default_setup_opts = {
                capabilities = capabilities,
                single_file_support = true,
                on_attach = function(client, bufnr)
                    local status_which_key, which_key = pcall(require, "which-key")
                    if not status_which_key then
                        vim.notify("Error from plugins.lsp.nvim_lspconfig: which-key not found.")
                    else
                        BASE.set_lsp_diagnostics_keymaps(bufnr, which_key)

                        local status_telescope_builtin, telescope_builtin = pcall(require, "telescope.builtin")
                        if not status_telescope_builtin then
                            vim.notify("Error from plugins.lsp.nvim_lspconfig: telescope.builtin not found.")
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

            for k, v in pairs(lsp_servers) do
                local require_ok, server_setup = pcall(require, "plugins.lsp.servers." .. k)
                if require_ok then
                    local default_opts = vim.tbl_deep_extend("force", default_setup_opts, {})

                    local opts = vim.tbl_deep_extend("force", default_opts, server_setup)

                    -- else
                    --   vim.notify("Error from plugins.p_lsp.mason.handlers: requiring servers." .. k .. " not found.")

                    vim.lsp.config(v, opts)
                end

                if k == "rust" then -- Rustaceanvim needs to have rust lsp disabled
                    vim.lsp.enable(v, false)
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
    end
}
