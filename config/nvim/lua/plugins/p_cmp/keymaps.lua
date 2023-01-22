local cmp = PLUGINS.cmp

local cmp_mappings = PLUGINS.lsp_zero.defaults.cmp_mappings()

cmp_mappings["<C-Space>"] = cmp.mapping.complete()
cmp_mappings["<C-Esc>"] = cmp.mapping.abort()
cmp_mappings["<C-s>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' })
cmp_mappings["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' })

-- cmp_mappings["<C-Tab>"] = function() cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) end
-- cmp_mappings["<C-S-Tab>"] = function() cmp.select_prev_item() end
-- cmp_mappings["<C-CR>"] = cmp.mapping.confirm({ select = true })

-- local cmp_config = cmp.get_config()

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

PLUGINS.which_key.register({
  [""] = {
    name = "CMP Autocompletion",
    ["<C-Space>"] = { "Open Autocompletion" },
    ["<C-Esc>"] = { "Abort Autocompletion" },
    ["<C-s>"] = { "Scroll autocompletion docs upwards" },
    ["<C-f>"] = { "Scroll autocompletion docs downwards" },
  }
}, { mode = { "i", "c" } })

return { cmp_mappings = cmp_mappings }
