local menu = {
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  luasnip = "[LuaSnip]",
  buffer = "[Buffer]",
  path = "[Path]",
  latex_symbols = "[Latex]"
}

local function create_sources_table()
  local sources = {}

  table.insert(sources, { name = "nvim_lsp" })
  table.insert(sources, { name = "nvim_lsp_signature_help" })
  if vim.api.nvim_buf_get_option(0, "filetype") == "lua" then
    table.insert(sources, { name = "nvim_lua" })
  end
  table.insert(sources, { name = "luasnip" })
  -- table.insert(sources, { name = "buffer" })
  table.insert(sources, { name = "path" })
  table.insert(sources, { name = "git" })
  table.insert(sources, { name = "nerdfont" })

  return sources
end

-- cmp.setup({
--   formatting = {
--     format = function(_, vim_item)
--       vim_item.kind = (icons[vim_item.kind] or "[LSP]") .. " " .. vim_item.kind
--       return vim_item
--     end
--   }
-- })


-- cmp.setup({
--   formatting = {
--     format = lspkind.cmp_format({
--       mode = "symbol_text",
--       menu = (menu)
--     })
--   },
--   mapping = cmp_mappings
-- })

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


-- Autocompletion
return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  dependencies = {
    { "L3MON4D3/LuaSnip" },                     -- Snippets engine

    { "hrsh7th/cmp-nvim-lsp" },                 -- nvim-cmp source for nvim builtin language server client
    { "hrsh7th/cmp-nvim-lsp-signature-help" },  -- nvim-cmp source for nvim builtin language server client for signature helping
    { "hrsh7th/cmp-nvim-lua" },                 -- nvim-cmp source for nvim lua api
    { "saadparwaiz1/cmp_luasnip" },             -- completion source for nvim-cmp
    { "hrsh7th/cmp-buffer" },                   -- nvim-cmp source for buffer
    { "hrsh7th/cmp-path" },                     -- nvim-cmp source for buffer words
    { "hrsh7th/cmp-nvim-lsp-document-symbol" }, -- nvim-cmp source for lsp symbols
    { "petertriho/cmp-git" },                   -- cmp-git source for git related stuff.

    { "chrisgrieser/cmp-nerdfont" },            -- nvim-cmp source for buffer words

    { "onsails/lspkind.nvim" },                 -- Autocompletion Icons
  },
  config = function()
    vim.opt.completeopt:append("menu")
    vim.opt.completeopt:append("menuone")
    vim.opt.completeopt:append("noselect")

    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    -- local function check_empty_or_dot()
    --   local previous_char_col = vim.fn.col(".") - 1
    --   local line_char = vim.fn.getline("."):sub(previous_char_col, previous_char_col)
    --   if previous_char_col == 0 or line_char:match("%s") or line_char:match(".") then
    --     return true
    --   end
    --   return false
    -- end

    local cmp_mappings = {
      ["<C-Space>"] = cmp.mapping(function(_)
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      -- Just an attempt to complete word if already has something previously written
      -- ["<C-CR>"] = cmp.mapping(function(_)
      --   if check_empty_or_dot() then
      --     cmp.confirm({ select = false })
      --   else
      --     cmp.complete_common_string()
      --   end
      -- end, { "i", "c" }),
      ["<C-Esc>"] = cmp.mapping.abort(),
      ["<C-e>"] = cmp.mapping.close(),
      -- Mapping below is not working.
      -- ["<C-l>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     return cmp.complete_common_string()
      --   end
      --   fallback()
      -- end, { "i", "c" }),
      -- ["<C-b>"] = cmp.mapping(function(fallback) cmp.complete_common_string() end, { "i", "c" }),
      -- ["<C-m>"] = cmp.mapping.complete_common_string(),
      ["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_prev_item(select_opts)
        end
        fallback()
      end),
      ["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_next_item(select_opts)
        end
        fallback()
      end),
      ["<C-s>"] = cmp.mapping(cmp.mapping.scroll_docs(-5), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(5), { "i", "c" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
        else
          fallback()
        end
      end, { "i", "s" })
    }

    local cmp_config_mappings = cmp.get_config().mapping

    vim.tbl_deep_extend("force", cmp_config_mappings, cmp_mappings)

    -- cmp_config.mapping["<C-Tab>"] = cmp.mapping(
    --   function()
    --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    --   end,
    --   {"i"}
    -- )
    -- cmp_config.mapping["<C-S-Tab>"] = cmp.mapping(
    --   function()
    --     cmp.select_prev_item()
    --   end,
    --   {"i"}
    -- )
    -- cmp_config.mapping["<Tab>"] = nil
    -- cmp_config.mapping["<S-Tab>"] = nil
    -- cmp_config.mapping["<CR>"] = nil

    -- which_key.register({
    --   [""] = {
    --     name = "CMP Autocompletion",
    --     ["<C-Space>"] = { "Toggle Autocompletion" },
    --     ["<C-Esc>"] = { "Abort Autocompletion" },
    --     ["<C-e>"] = { "Close Autocompletion" },
    --     ["<C-m>"] = { "Complete current word" },
    --     ["<CR>"] = { "Confirm selected completion" },
    --     ["<C-s>"] = { "Scroll autocompletion docs upwards" },
    --     ["<C-f>"] = { "Scroll autocompletion docs downwards" },
    --     ["<Up>"] = { "Move to previous item in completion list" },
    --     ["<Down>"] = { "Move to next item in completion list" },
    --     ["<Tab>"] = { "Cycle forwards through options, snippets" },
    --     ["<S-Tab>"] = { "Cycle backwards through options, snippets" },
    --   }
    -- }, { mode = { "i", "c" } })

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

    cmp.setup.cmdline('/', {
      sources = cmp.config.sources(
        {
          { name = "nvim_lsp_document_symbol" }
        },
        {
          { name = "buffer" }
        }
      )
    })

    local cmp_git = require("cmp_git")

    cmp_git.setup()
  end
}
