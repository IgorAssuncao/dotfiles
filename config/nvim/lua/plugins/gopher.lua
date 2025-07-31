return {
    "olexsmir/gopher.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    event = "VeryLazy",
    ft = "go",
    build = function()
        vim.cmd.GoInstallDeps()
    end,
    config = function()
        require("gopher").setup {
            commands = {
                go = "go",
                gomodifytags = "gomodifytags",
                gotests = "gotests",
                impl = "impl",
                iferr = "iferr",
                dlv = "dlv"
            },
            iferr = {
                -- choose a custom error message
                message = "fmt.Errorf(\"Error: %v\", err)",
            },
        }
    end
}
