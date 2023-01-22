-- PLUGINS.cmp.setup({
--   formatting = {
--     format = function(_, vim_item)
--       vim_item.kind = (icons[vim_item.kind] or "[LSP]") .. " " .. vim_item.kind
--       return vim_item
--     end
--   }
-- })

local menu = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  latex_symbols = "[Latex]"
}

local lspkind = require("lspkind")

local cmp_mappings = require("plugins.p_cmp.keymaps").cmp_mappings

PLUGINS.cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = (menu)
    })
  },
  mapping = cmp_mappings
})
