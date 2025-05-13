return {
    "olexsmir/gopher.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    event = "VeryLazy",
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
            which_key.add({
                { "<leader>L",    group = "[G]olang Gopher" },
                { "<leader>Le",   function() vim.cmd { cmd = "GoIfErr" } end,                                                                          desc = "If [E]rr" },
                { "<leader>Li",   function() vim.cmd { cmd = "GoImpl", args = { vim.fn.input("<receiver_name> <receiver_type> <interface>: ") } } end, desc = "[I]mplement Interface" },
                { "<leader>Lt",   group = "Manage [T]ags" },
                { "<leader>Lta",  group = "Add [T]ags" },
                { "<leader>Ltaj", function() vim.cmd { cmd = "GoTagAdd json" } end,                                                                    desc = "[J]son tags" },
                { "<leader>Ltay", function() vim.cmd { cmd = "GoTagAdd yaml" } end,                                                                    desc = "[Y]aml tags" },
                { "<leader>Ltr",  group = "Remove [T]ags" },
                { "<leader>Ltaj", function() vim.cmd { cmd = "GoTagRm json" } end,                                                                     desc = "[J]son tags" },
                { "<leader>Ltay", function() vim.cmd { cmd = "GoTagRm yaml" } end,                                                                     desc = "[Y]aml tags" },
            })
        end
    end
}
