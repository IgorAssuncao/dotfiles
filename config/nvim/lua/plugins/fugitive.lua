-- Plugin for Git management inside Nvim

-- function open_fugitive_in_floating_window()
--     local width = 100
--     local height = 25
--
--     local buffer = vim.api.nvim_create_buf(false, true)
--
--     local ui = vim.api.nvim_list_uis()[1]
--
--     local opts = {
--         relative = "editor",
--         width = width,
--         height = height,
--         col = (ui.width / 2) - (width / 2),
--         row = (ui.height / 2) - (height / 2),
--         anchor = "NW",
--         style = "minimal"
--     }
--
--     local win = vim.api.nvim_open_win(buffer, 1, opts)
-- end
--
-- local keymaps = {
--     {
--         keys = "<leader>za",
--         cmd = function()
--             open_fugitive_in_floating_window()
--         end
--     }
-- }
--
-- BASE.set_keymaps(keymaps)


return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
        local wk_git_prefix = "<leader>g"

        require("which-key").add({
            { wk_git_prefix,         group = "[G]it" },
            { wk_git_prefix .. "s",  vim.cmd.Git,                                                                                                           desc = "[S]tatus" },
            { wk_git_prefix .. "l",  vim.cmd.GcLog,                                                                                                         desc = "[L]og" },
            { wk_git_prefix .. "f",  function() vim.cmd.Git { args = { "fetch" } } end,                                                                     desc = "[F]etch" },
            { wk_git_prefix .. "b",  function() vim.cmd.Git { args = { "branch" } } end,                                                                    desc = "[B]ranch" },
            { wk_git_prefix .. "c",  group = "[C]heckout" },
            { wk_git_prefix .. "cb", function() vim.cmd.Git { args = { "switch " .. vim.fn.input("Target branch: ") } } end,                                desc = "[S]witch" },
            { wk_git_prefix .. "cc", function() vim.cmd.Git { args = { "switch -c " .. vim.fn.input("Create branch: ") } } end,                             desc = "[C]reate branch" },
            { wk_git_prefix .. "d",  group = "[D]iff" },
            { wk_git_prefix .. "dh", function() vim.cmd { cmd = "diffget", args = { "//2" } } end,                                                          desc = "Choose diff content on left window" },
            { wk_git_prefix .. "dl", function() vim.cmd { cmd = "diffget", args = { "//3" } } end,                                                          desc = "Choose diff content on right window" },
            { wk_git_prefix .. "p",  function() vim.cmd.Git { args = { "push" } } end,                                                                      desc = "[P]ush" },
            -- TODO: Somehow make this work, it can be useful in small and fast commits.
            -- {
            --     wk_git_prefix .. "p",
            --     function()
            --         vim.cmd.Git { args = { "push" } }
            --         vim.cmd.quit
            --     end,
            --     desc = "[P]ush"
            -- },
            { wk_git_prefix .. "P",  group = "[P]ull" },
            { wk_git_prefix .. "PP", function() vim.cmd { cmd = "Git", args = { "pull" } } end,                                                             desc = "Default" },
            { wk_git_prefix .. "PB", function() vim.cmd { cmd = "Git", args = { "pull origin " .. vim.fn.input("Branch to pull from: ") } } end,            desc = "Default from [b]ranch" },
            { wk_git_prefix .. "PM", function() vim.cmd { cmd = "Git", args = { "pull --no-rebase" } } end,                                                 desc = "[M]erge" },
            { wk_git_prefix .. "PR", function() vim.cmd { cmd = "Git", args = { "pull --rebase" } } end,                                                    desc = "[R]ebase" },
            { wk_git_prefix .. "PC", function() vim.cmd { cmd = "Git", args = { "pull --rebase origin " .. vim.fn.input("Branch to rebase from: ") } } end, desc = "Rebase from bran[c]h" },
        })
    end
}
