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
        require("which-key").add({
            { "<leader>g",   group = "[G]it" },
            { "<leader>gs",  vim.cmd.Git,                                                                                                           desc = "[S]tatus" },
            { "<leader>gl",  vim.cmd.GcLog,                                                                                                         desc = "[L]og" },
            { "<leader>gf",  function() vim.cmd.Git { args = { "fetch" } } end,                                                                     desc = "[F]etch" },
            { "<leader>gb",  function() vim.cmd.Git { args = { "branch" } } end,                                                                    desc = "[B]ranch" },
            { "<leader>gc",  group = "[C]heckout" },
            { "<leader>gcb", function() vim.cmd.Git { args = { "switch " .. vim.fn.input("Target branch: ") } } end,                                desc = "[S]witch" },
            { "<leader>gcc", function() vim.cmd.Git { args = { "switch -c " .. vim.fn.input("Create branch: ") } } end,                             desc = "[C]reate branch" },
            { "<leader>gd",  group = "[D]iff" },
            { "<leader>gdh", function() vim.cmd { cmd = "diffget", args = { "//2" } } end,                                                          desc = "Choose diff content on left window" },
            { "<leader>gdl", function() vim.cmd { cmd = "diffget", args = { "//3" } } end,                                                          desc = "Choose diff content on right window" },
            { "<leader>gp",  function() vim.cmd.Git { args = { "push" } } end,                                                                      desc = "[P]ush" },
            { "<leader>gP",  group = "[P]ull" },
            { "<leader>gPP", function() vim.cmd { cmd = "Git", args = { "pull" } } end,                                                             desc = "Default" },
            { "<leader>gPB", function() vim.cmd { cmd = "Git", args = { "pull origin " .. vim.fn.input("Branch to pull from: ") } } end,            desc = "Default from [b]ranch" },
            { "<leader>gPM", function() vim.cmd { cmd = "Git", args = { "pull --no-rebase" } } end,                                                 desc = "[M]erge" },
            { "<leader>gPR", function() vim.cmd { cmd = "Git", args = { "pull --rebase" } } end,                                                    desc = "[R]ebase" },
            { "<leader>gPC", function() vim.cmd { cmd = "Git", args = { "pull --rebase origin " .. vim.fn.input("Branch to rebase from: ") } } end, desc = "Rebase from bran[c]h" },
        })
    end
}
