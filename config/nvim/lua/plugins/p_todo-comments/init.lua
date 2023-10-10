local status_todo_comments, todo_comments = pcall(require, "todo-comments")
if not status_todo_comments then
    vim.notify("Error from plugins.p_todo-comments: todo-comments not found.")
    return
end

local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
    vim.notify("Error from plugins.p_todo-comments: which-key not found.")
    return
end

todo_comments.setup()

which_key.register({
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
