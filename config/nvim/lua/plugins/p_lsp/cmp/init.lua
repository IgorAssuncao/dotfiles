local cmp_mappings = require("plugins.p_lsp.cmp.keymaps").cmp_mappings

PLUGINS.lsp_zero.setup_nvim_cmp({
  mapping = cmp_mappings
})
