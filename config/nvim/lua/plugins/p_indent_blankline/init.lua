local status_indent_blankline, indent_blankline = pcall(require, "indent_blankline")
if not status_indent_blankline then
  vim.notify("Error from plugins.p_indent_blankline: indent_blankline not found.")
  return
end

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

indent_blankline.setup {
  show_current_context = true,
  show_current_context_start = false, -- If set to true sets an underlin in context start
  show_end_of_line = true,
  space_char_blankline = " "
}
