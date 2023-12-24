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
        require("which-key").register({
            g = {
                name = "[G]it",
                s = { vim.cmd.Git, "[S]tatus" },
                l = { vim.cmd.GcLog, "[L]og" },
                f = { function() vim.cmd.Git { args = { "fetch" } } end, "[F]etch" },
                b = { function() vim.cmd.Git { args = { "branch" } } end, "[B]ranch" },
                c = {
                    name = "[C]heckout",
                    b = { function() vim.cmd.Git { args = { "switch " .. vim.fn.input("Target branch: ") } } end,
                        "[S]witch to existing branch" },
                    c = { function() vim.cmd.Git { args = { "switch -c " .. vim.fn.input("Create branch: ") } } end,
                        "[C]reate branch" },
                },
                d = {
                    name = "[D]iff",
                    h = { function() vim.cmd { cmd = "diffget", args = { "//2" } } end, "Choose diff content on left window" },
                    l = { function() vim.cmd { cmd = "diffget", args = { "//3" } } end, "Choose diff content on right window" }
                },
                p = { function() vim.cmd.Git { args = { "push" } } end, "[P]ush" },
                P = {
                    name = "Pull Options",
                    P = { function() vim.cmd { cmd = "Git", args = { "pull" } } end, "Default" },
                    B = {
                        function() vim.cmd { cmd = "Git", args = { "pull origin " .. vim.fn.input("Branch to pull from: ") } } end,
                        "Default from branch" },
                    M = { function() vim.cmd { cmd = "Git", args = { "pull --no-rebase" } } end, "[M]erge" },
                    R = { function() vim.cmd { cmd = "Git", args = { "pull --rebase" } } end, "[R]ebase" },
                    C = { function()
                        vim.cmd { cmd = "Git",
                            args = { "pull --rebase origin " .. vim.fn.input("Branch to rebase from: ") } }
                    end,
                        "[R]ebase from branch" }
                },
            }
        }, { prefix = "<leader>" })
    end
}
