local status, cmp = pcall(require, "cmp")
if not status then
  vim.notify("Error from plugins.p_cmp: cmp not found.")
  return
end

-- PLUGINS.cmp.setup({
--   formatting = {
--     format = function(_, vim_item)
--       vim_item.kind = (icons[vim_item.kind] or "[LSP]") .. " " .. vim_item.kind
--       return vim_item
--     end
--   }
-- })

local menu = {
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  luasnip = "[LuaSnip]",
  buffer = "[Buffer]",
  path = "[Path]",
  latex_symbols = "[Latex]"
}

local lspkind = require("lspkind")

local cmp_mappings = require("plugins.p_cmp.keymaps").mappings

-- PLUGINS.cmp.setup({
--   formatting = {
--     format = lspkind.cmp_format({
--       mode = "symbol_text",
--       menu = (menu)
--     })
--   },
--   mapping = cmp_mappings
-- })

vim.opt.completeopt:append("menu")
vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("noselect")

-- vim.api.nvim_create_autocmd(
--   {
--     "TextChangedI",
--     "TextChangedP",
--   },
--   {
--     pattern = "*",
--     callback = function()
--       local line_content = vim.api.nvim_get_current_line()
--       local cursor_pos = vim.api.nvim_win_get_cursor(0)[2]
--
--       local current_char_and_after = string.sub(line_content, cursor_pos, cursor_pos + 1)
--       print("line_content", line_content)
--       print("cursor_pos", cursor_pos)
--       print("current_char_and_after", current_char_and_after)
--       if current_char_and_after == "." or current_char_and_after == "," or current_char_and_after == " " then
--         PLUGINS.cmp.close()
--       end
--
--       local before_in_line = string.sub(line_content, 1, cursor_pos + 1)
--       local after_in_line = string.sub(line_content, cursor_pos + 1, -1)
--
--       if not string.match(before_in_line, "^%s+$") then
--         if after_in_line == "" or string.match(before_in_line, " $") or string.match(before_in_line, "%.$") then
--           PLUGINS.cmp.complete()
--         end
--       end
--     end
--   }
-- )

local function create_sources_table()
  local sources = {}

  table.insert(sources, { name = "nvim_lsp" })
  table.insert(sources, { name = "nvim_lsp_signature_help" })
  if vim.api.nvim_buf_get_option(0, "filetype") == "lua" then
    table.insert(sources, { name = "nvim_lua" })
  end
  table.insert(sources, { name = "luasnip" })
  table.insert(sources, { name = "buffer" })
  table.insert(sources, { name = "path" })
  table.insert(sources, { name = "nerdfont" })

  return sources
end

cmp.setup({
  snippet = { -- THIS IS REQUIRED
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  sources = cmp.config.sources(create_sources_table()),
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
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false
  },
  mapping = cmp_mappings,
  views = {
    entries = "custom"
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  preselect = cmp.PreselectMode.None,
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
      -- f.kind = BASE.defaults.icons.kinds[string[1]]
      f.menu = "[" .. (strings[2] or "") .. "]" .. " - " .. (menu[entry.source.name] or "")
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
  experimental = {
    ghost_text = false
  }
})
