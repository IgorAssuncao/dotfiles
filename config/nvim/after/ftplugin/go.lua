local bufnr = vim.api.nvim_get_current_buf()

require("which-key").add({
    { "<leader>Lg",    group = "[G]olang Gopher" },
    { "<leader>Lge",   function() vim.cmd { cmd = "GoIfErr" } end,                                                                          desc = "If [E]rr" },
    { "<leader>Lgi",   function() vim.cmd { cmd = "GoImpl", args = { vim.fn.input("<receiver_name> <receiver_type> <interface>: ") } } end, desc = "[I]mplement Interface" },
    { "<leader>Lgt",   group = "Manage [T]ags" },
    { "<leader>Lgta",  group = "Add [T]ags" },
    { "<leader>Lgtaj", function() vim.cmd { cmd = "GoTagAdd", args = { "json" } } end,                                                      desc = "[J]son tags" },
    { "<leader>Lgtay", function() vim.cmd { cmd = "GoTagAdd", args = { "yaml" } } end,                                                      desc = "[Y]aml tags" },
    { "<leader>Lgtr",  group = "Remove [T]ags" },
    { "<leader>Lgtrj", function() vim.cmd { cmd = "GoTagRm", args = { "json" } } end,                                                       desc = "[J]son tags" },
    { "<leader>Lgtry", function() vim.cmd { cmd = "GoTagRm", args = { "yaml" } } end,                                                       desc = "[Y]aml tags" },
}, { buffer = bufnr })
