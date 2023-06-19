local status_transparent, transparent = pcall(require, "transparent")
if not status_transparent then
  vim.notify("Error from plugins.p_transparent.init: transparent not found.")
  return
end

transparent.setup({
  extra_groups = {
    "NormalFloat",
    "NvimTreeNormal",
    "NotifyBackground"
  }
})

vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(value)
    return value.hl_group
  end, vim.tbl_values(require("bufferline.config").highlights))
)
