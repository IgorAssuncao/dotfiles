return function(opts)
  opts.filetypes = {
    "terraform",
    "terraform-vars",
    "tf",
    ".tf",
    "tfvars",
    ".tfvars",
    "*.tfvars*",
    "terraformrc",
    ".terraformrc",
    "*.terraformrc",
    "tfrc",
    ".tfrc",
    "*.tfrc"
  }

  return opts
end
-- lspconfig[lsp_servers.terraform].setup {
--   filetypes = {
--     "terraform",
--     "terraform-vars",
--     ".tf",
--     ".tfvars",
--     "*.tfvars*"
--   }
-- }
