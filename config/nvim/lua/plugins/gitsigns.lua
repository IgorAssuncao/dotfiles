-- Plugin for having Git related signs in Nvim.

return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup {
            numhl = true,
            linehl = false,
            current_line_blame = false,
        }

        local wk_git_prefix = "<leader>g"

        require("which-key").add({
            { wk_git_prefix .. "B", function() vim.cmd.Gitsigns { args = { "toggle_current_line_blame" } } end, desc = "Toggle line [b]lame" },
            { wk_git_prefix .. "h", function() vim.cmd.Gitsigns { args = { "preview_hunk_inline" } } end,       desc = "Preview [h]unk inline" },
            { wk_git_prefix .. "D", function() vim.cmd.Gitsigns { args = { "diffthis" } } end,                  desc = "[D]iff this file" },
            { wk_git_prefix .. "L", function() vim.cmd.Gitsigns { args = { "toggle_linehl" } } end,             desc = "Toggle [L]ine highlight" },
        })
    end
}
