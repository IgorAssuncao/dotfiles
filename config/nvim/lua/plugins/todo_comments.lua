-- Plugin that helps finding TODO (and others) comments
-- in various parts of the code.

local function createTodoCommandTable(command)
    return {
        a = { function() vim.cmd { cmd = command } end, "[A]ll" },
        t = { function() vim.cmd { cmd = command, args = { "keywords=TODO" } } end, "[T]odo" },
        n = { function() vim.cmd { cmd = command, args = { "keywords=NOTE" } } end, "[N]ote" },
        f = { function() vim.cmd { cmd = command, args = { "keywords=FIX" } } end, "[F]ix" },
        h = { function() vim.cmd { cmd = command, args = { "keywords=HACK" } } end, "[H]ack" },
        w = { function() vim.cmd { cmd = command, args = { "keywords=WARN" } } end, "[W]arning" },
        p = { function() vim.cmd { cmd = command, args = { "keywords=PERF" } } end, "[P]erf" },
        T = { function() vim.cmd { cmd = command, args = { "keywords=TEST" } } end, "[T]est" }
    }
end

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
                    c = vim.tbl_extend("keep",
                        {
                            name = "Todo [c]omments",
                        },
                        createTodoCommandTable("TodoTelescope")
                    )
                },
                t = {
                    name = "[T]odo comments",
                    q = vim.tbl_extend("keep",
                        {
                            name = "Todo [Q]uickFix",
                        },
                        createTodoCommandTable("TodoQuickFix")
                    ),
                    t = vim.tbl_extend("keep",
                        {
                            name = "Todo [T]rouble",
                        },
                        createTodoCommandTable("TodoTrouble")
                    )
                }
            }
        })
    end
}
