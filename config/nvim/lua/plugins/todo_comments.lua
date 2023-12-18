return {
    "folke/todo-comments.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" }
    },
    event = "VeryLazy",
    config = function()
        require("todo-comments").setup()

        require("which-key").register({
            ["<leader>"] = {
                f = {
                    c = {
                        name = "Todo [c]omments",
                        a = { function() vim.cmd { cmd = "TodoTelescope" } end, "[A]ll" },
                        t = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=TODO" } } end, "[T]odo" },
                        n = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=NOTE" } } end, "[N]ote" },
                        f = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=FIX" } } end, "[F]ix" },
                        h = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=HACK" } } end, "[H]ack" },
                        w = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=WARN" } } end, "[W]arning" },
                        p = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=PERF" } } end, "[P]erf" },
                        T = { function() vim.cmd { cmd = "TodoTelescope", args = { "keywords=TEST" } } end, "[T]est" }
                    }
                },
                t = {
                    name = "[T]odo comments",
                    q = { function() vim.cmd { cmd = "TodoQuickFix" } end, "Todo [Q]uickFix" },
                    t = { function() vim.cmd { cmd = "TodoTrouble" } end, "Todo [T]rouble" }
                }
            }
        })
    end
}
