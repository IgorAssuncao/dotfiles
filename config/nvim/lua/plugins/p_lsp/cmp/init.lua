-- local icons = {
--   Class = "",
--   Color = "",
--   Constant = "",
--   Constructor = "",
--   Enum = "",
--   EnumMember = "",
--   Event = "",
--   Field = "",
--   File = "",
--   Folder = "",
--   Function = "",
--   Interface = "",
--   Key = "",
--   Keyword = "",
--   Method = "",
--   Module = "",
--   Operator = "",
--   Property = "",
--   Reference = "",
--   Snippet = "",
--   Struct = "",
--   Text = "",
--   Type = "",
--   TypeParameter = "",
--   Unit = "",
--   Value = "",
--   Variable = ""
-- }

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

local cmp_mappings = require("plugins.p_lsp.cmp.keymaps").cmp_mappings

PLUGINS.cmp.setup({
  formatting = {
    fields = { "kind", "abbr", "menu" },
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

for k, v in pairs(PLUGINS.cmp.config) do
  print(k, v)
end
