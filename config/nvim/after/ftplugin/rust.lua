local bufnr = vim.api.nvim_get_current_buf()
local rl = vim.cmd.RustLsp

require("which-key").add({
    { "<leader>Lr",  group = "[R]ust tools" },
    -- Hover Actions
    { "<leader>Lrh", function() rl({ "hover", "actions" }) end, desc = "[H]over actions" },
    -- Code action groups
    { "<leader>Lra", function() rl("codeAction") end,           desc = "Code [a]ction group" },
}, { buffer = bufnr })
