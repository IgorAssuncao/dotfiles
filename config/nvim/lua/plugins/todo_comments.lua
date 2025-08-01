-- Plugin that helps finding TODO (and others) comments
-- in various parts of the code.

function CreateTodoCommandTable(prefix, command)
    return {
        { prefix .. "a", function() vim.cmd { cmd = command } end,                             desc = "[A]ll" },
        { prefix .. "t", function() vim.cmd { cmd = command, args = { "keywords=TODO" } } end, desc = "[T]odo" },
        { prefix .. "n", function() vim.cmd { cmd = command, args = { "keywords=NOTE" } } end, desc = "[N]ote" },
        { prefix .. "f", function() vim.cmd { cmd = command, args = { "keywords=FIX" } } end,  desc = "[F]ix" },
        { prefix .. "h", function() vim.cmd { cmd = command, args = { "keywords=HACK" } } end, desc = "[H]ack" },
        { prefix .. "w", function() vim.cmd { cmd = command, args = { "keywords=WARN" } } end, desc = "[W]arning" },
        { prefix .. "p", function() vim.cmd { cmd = command, args = { "keywords=PERF" } } end, desc = "[P]erf" },
        { prefix .. "T", function() vim.cmd { cmd = command, args = { "keywords=TEST" } } end, desc = "[T]est" }
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

        local wkCommentPrefix = "<leader>c"

        require("which-key").add({
            { wkCommentPrefix, group = "Todo [c]omments in quickfix" },
            CreateTodoCommandTable(wkCommentPrefix, "TodoQuickFix"),
        })
    end
}
