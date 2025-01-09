-- Plugin that helps finding TODO (and others) comments
-- in various parts of the code.

local function createTodoCommandTable(leader, command)
    return {
        { leader .. "a", function() vim.cmd { cmd = command } end,                             desc = "[A]ll" },
        { leader .. "t", function() vim.cmd { cmd = command, args = { "keywords=TODO" } } end, desc = "[T]odo" },
        { leader .. "n", function() vim.cmd { cmd = command, args = { "keywords=NOTE" } } end, desc = "[N]ote" },
        { leader .. "f", function() vim.cmd { cmd = command, args = { "keywords=FIX" } } end,  desc = "[F]ix" },
        { leader .. "h", function() vim.cmd { cmd = command, args = { "keywords=HACK" } } end, desc = "[H]ack" },
        { leader .. "w", function() vim.cmd { cmd = command, args = { "keywords=WARN" } } end, desc = "[W]arning" },
        { leader .. "p", function() vim.cmd { cmd = command, args = { "keywords=PERF" } } end, desc = "[P]erf" },
        { leader .. "T", function() vim.cmd { cmd = command, args = { "keywords=TEST" } } end, desc = "[T]est" }
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

        require("which-key").add({
            { "<leader>f",  group = "TodoTelescope" },
            { "<leader>fc", group = "Todo [c]omments" },
            createTodoCommandTable("<leader>fc", "TodoTelescope"),
            { "<leader>t",  group = "[T]odo comments" },
            { "<leader>tq", group = "Todo [Q]uickFix" },
            createTodoCommandTable("<leader>tq", "TodoQuickFix"),
            { "<leader>tt", group = "Todo [T]rouble" },
            createTodoCommandTable("<leader>tt", "TodoTrouble")
        })
    end
}
