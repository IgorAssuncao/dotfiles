return {
    "leoluz/nvim-dap-go",
    event = "VeryLazy",
    config = function()
        require("dap-go").setup()
    end
}
