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

-- PLUGINS.cmp.setup({
--   formatting = {
--     format = lspkind.cmp_format({
--       mode = "symbol_text",
--       menu = (menu)
--     })
--   },
--   mapping = cmp_mappings
-- })

PLUGINS.cmp.setup({
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      local f = lspkind.cmp_format({ mode = "symbol_text" })(entry, vim_item)
      local strings = vim.split(f.kind, "%s", { trimempty = true })
      f.kind = " " .. (strings[1] or "") .. " "
      f.menu = "(" .. (strings[2] or "") .. ")"

      return f
    end
  },
  mapping = cmp_mappings,
  -- sources = PLUGINS.cmp.config.sources(
  --   {
  --     { name = "LuaSnip" },
  --     {
  --       name = "nvim_lua",
  --       entry_filter = function(entry, ctx)
  --         print(entry)
  --         return true
  --       end
  --     }
  --   },
  --   {
  --     { name = "friendly-snippets" }
  --   }
  -- )
})
