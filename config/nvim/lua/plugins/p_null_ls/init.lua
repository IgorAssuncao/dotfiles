local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  vim.notify("Error from p_null_ls: null-ls not found.")
  return
end

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.eslint,
    -- null_ls.builtins.formatting.eslint.with({ extra_args = { "--fix" } }),
    null_ls.builtins.diagnostics.eslint
  }
})
