local M = {}

local status, cmp = pcall(require, "cmp")
if not status then
    vim.notify("cmp not found.")
    return
end

local status, luasnip = pcall(require, "luasnip")
if not status then
    vim.notify("luasnip not found.")
    return
end

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

-- PLUGINS.which_key.register({
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

M.mappings = cmp_mappings

return M
