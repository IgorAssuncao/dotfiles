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
      -- for k, v in pairs(entry.source) do
      --   if k == "name" then
      --     print(k, v)
      --   end
      -- end

      -- local type = ""
      -- local item = entry:get_completion_item()
      -- if item.detail then
      --   type = item.detail
      -- end

      local f = lspkind.cmp_format({ mode = "symbol_text" })(entry, vim_item)
      local strings = vim.split(f.kind, "%s", { trimempty = true })
      f.kind = " " .. (strings[1] or "") .. " "
      f.menu = "[" .. (strings[2] or "") .. "]"
      -- f.menu = type .. " - [" .. (strings[2] or "") .. "]"

      -- if entry.source.name == "luasnip" then
      --   for k, v in pairs(entry) do
      --     print(k, v)
      --   end
      --   print("from luasnip")
      -- end

      return f
    end
  },
  mapping = cmp_mappings,
  sources = PLUGINS.cmp.config.sources {
    { name = "nvim_lsp" }
    -- { name = "luasnip" }
  }
  -- sources = PLUGINS.cmp.config.sources(
  --   {
  --     { name = "luasnip" },
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
