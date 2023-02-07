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

local eslint_configs = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filenam ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
  format = true
}

return function(opts)
  -- opts.root_dir = function()
  --   if not eslint_config_exists() then
  --     return nil
  --   end
  --   return vim.fn.getcwd()
  -- end
  opts.settings = {
    -- format = eslint_config_exists(),
    languages = {
      javascript = { eslint_configs },
      typescript = { eslint_configs }
    }
  }
  -- opts.on_attach = function(client, bufnr)
  --   client.capabilities.client.server_capabilities.document_formatting = eslint_config_exists()
  --   lsp_keymaps(bufnr)
  -- end
  return opts
end
