return {
    "olexsmir/gopher.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    event = "VeryLazy",
    ft = "go",
    init = function()
      -- Inject Go path specifically when this plugin initializes
      local go_bin = os.getenv("GOBIN") or vim.fn.expand("$HOME/go/bin")
      if vim.fn.isdirectory(go_bin) == 1 then
        vim.env.PATH = go_bin .. ":" .. vim.env.PATH
      end
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

        -- vim.cmd.GoInstallDeps()
    end
}
