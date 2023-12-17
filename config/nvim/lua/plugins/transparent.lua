vim.opt.pumblend = 30
vim.opt.winblend = 30
-- vim.opt.hightlight-blend = 30

-- vim.g.transparent_groups = vim.list_extend(
--   vim.g.transparent_groups or {},
--   vim.tbl_map(function(value)
--     return value.hl_group
--   end, vim.tbl_values(require("bufferline.config").highlights or {}))
-- )

return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NotifyBackground"
      }
    })
  end
}
