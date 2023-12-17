return {
    "olexsmir/gopher.nvim",
    requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
        require("gopher").setup {
            commands = {
                go = "go",
                gomodifytags = "gomodifytags",
                gotests = "gotests",
                impl = "impl",
                iferr = "iferr",
                dlv = "dlv"
            }
        }

        local status_which_key, which_key = pcall(require, "which-key")
        if not status_which_key then
            vim.notify("Error from plugins.p_fugitive.keymaps: which-key not found.")
        else
            which_key.register({
                ["<leader>L"] = {
                    g = {
                        name = "[G]olang Gopher",
                        e = { function() vim.cmd { cmd = "GoIfErr" } end, "If [E]rr" },
                        i = {
                            function()
                                vim.cmd { cmd = "GoImpl", args = {
                                    vim.fn.input("<receiver_name> <receiver_type> <interface>: ") } }
                            end,
                            "[I]mplement Interface" },
                        t = {
                            name = "Manage [T]ags",
                            a = {
                                name = "[A]dd tags",
                                j = { function() vim.cmd { cmd = "GoTagAdd json" } end, "[J]son tags" },
                                y = { function() vim.cmd { cmd = "GoTagAdd yaml" } end, "[Y]aml tags" }
                            },
                            r = {
                                name = "[R]emove tags",
                                j = { function() vim.cmd { cmd = "GoTagRm json" } end, "[J]son tags" },
                                y = { function() vim.cmd { cmd = "GoTagRm yaml" } end, "[Y]aml tags" }
                            },
                        }
                    }
                }
            })
        end
    end
}
