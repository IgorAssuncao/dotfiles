-- Plugin that allows Nvim to have a transparent background.

return {
    "xiyaowong/transparent.nvim",
    opts = {
        extra_groups = {
            "NormalFloat",
            "NvimTreeNormal",
            "NotifyBackground"
        }
    },
    config = function(_, opts)
        -- require("transparent").setup()
        vim.opt.pumblend = 30
        vim.opt.winblend = 30
        -- vim.opt.hightlight-blend = 30

        -- vim.g.transparent_groups = vim.list_extend(
        --   vim.g.transparent_groups or {},
        --   vim.tbl_map(function(value)
        --     return value.hl_group
        --   end, vim.tbl_values(require("bufferline.config").highlights or {}))
        -- )

        vim.cmd { cmd = "TransparentEnable" }
    end
}
