local bufnr = vim.api.nvim_get_current_buf()

require("which-key").add({
    { "<leader>Lr",  group = "[R]ust tools" },
    -- Hover Actions
    { "<leader>Lrh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, desc = "[H]over actions" },
    -- Code action groups
    { "<leader>Lra", function() vim.cmd.RustLsp("codeAction") end,           desc = "Code [a]ction group" },
}, { buffer = bufnr })
