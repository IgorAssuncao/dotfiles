local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

return function(opts)
  -- opts.settings = {
  --   format = not eslint_config_exists(),
  -- }
  -- opts.on_attach = function(client, bufnr)
  --   client.capabilities.client.server_capabilities.document_formatting = not eslint_config_exists()
  --   lsp_keymaps(bufnr)
  -- end
  return opts
end
