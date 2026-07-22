-- Auto install LSP servers
return {
    "mason-org/mason.nvim",
    opts = {},
    config = function()
    --     require("mason").setup({
    --         log_level = vim.log.levels.INFO
    --     })
        require("mason").setup()
        local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb"
        local cmd = "[ -d " .. codelldb_path .. " ]"
        if not os.execute(cmd) then
           vim.cmd.MasonInstall("codelldb")
        end

    end
}
