vim.cmd.mapclear()

vim.g.mapleader = " "

local function set_keymap(params)
    local mode = params.mode or "n"
    local keys
    local cmd

    if params.keys then
        keys = params.keys
    end

    if params.cmd then
        cmd = params.cmd
    end

    local _opts = {
        remap = false
    }

    if params.opts then
        for k, v in pairs(params.opts) do
            _opts[k] = v
        end
    end

    -- if keys == "<leader>gPR" or keys == "<leader>gPP" then
    --   print(mode, keys, cmd)
    --   for k, v in pairs(_opts) do
    --     print(k, v)
    --   end
    -- end

    return vim.keymap.set(mode, keys, cmd, _opts)
end

function BASE.set_keymaps(keymaps_list)
    for _, v in pairs(keymaps_list) do
        set_keymap(v)
    end
end

local keymaps = {
    -- Navigation
    -- -- Panels
    -- -- -- These are the only ones that aren't overriding when using which_key.
    -- -- -- So I decided to leave them here for now.
    { keys = "<C-H>", cmd = "<C-W><C-H>", opts = { desc = "Move to left window" } },
    { keys = "<C-J>", cmd = "<C-W><C-J>", opts = { desc = "Move to down window" } },
    { keys = "<C-K>", cmd = "<C-W><C-K>", opts = { desc = "Move to up window" } },
    { keys = "<C-L>", cmd = "<C-W><C-L>", opts = { desc = "Move to right window" } },
}

-- for i = 1, 9 do
--   local key = "<leader>b" .. i
--   local cmd = "buffer " .. i
--   table.insert(keymaps, { keys = key, cmd = cmd, opts = { desc = "Move to buffer " .. i } })
-- end
--
-- print(vim.cmd.buffers())

BASE.set_keymaps(keymaps)

local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
    vim.notify("Error from base.keymaps: which_key not found.")
    -- return {}
end

which_key.add({
    { "<leader>",   group = "Custom" },
    { "<leader>C",  function() vim.cmd("nohls") end,             desc = "[C]lear Search Highlighting" },
    { "<leader>E",  vim.cmd.Ex,                                  desc = "[E]xplorer" },
    { "<leader>b",  group = "[B]uffer" },
    { "<leader>bd", vim.cmd.bd,                                  desc = "[D]elete" },
    { "<leader>bn", vim.cmd.bn,                                  desc = "[N]ext" },
    { "<leader>bp", vim.cmd.bp,                                  desc = "[P]revious" },
    { "<leader>q",  function() vim.cmd.quit {} end,              desc = "[Q]uit" },
    { "<leader>Q",  function() vim.cmd.quit { bang = true } end, desc = "Force [Q]uit" },
    { "<leader>w",  function() vim.cmd.write {} end,             desc = "[W]rite" },
    { "<leader>x",  function() vim.cmd.exit {} end,              desc = "E[x]it" },
    { "<Left>",     vim.cmd.bp,                                  desc = "Previous buffer" },
    { "<Right>",    vim.cmd.bn,                                  desc = "Next buffer" },
    { "<M-,>",      "<C-w>5<",                                   desc = "Decrease window width by 5" },
    { "<M-.>",      "<C-w>5>",                                   desc = "Increase window width by 5" },
    { "<M-t>",      "<C-w>+",                                    desc = "Decrease window height by 5" },
    { "<M-s>",      "<C-w>-",                                    desc = "Decrease window height by 5" }
})

for i = 1, 9, 1 do
    local key = "<leader>" .. i
    local cmd = i .. "<C-W>w"
    which_key.add({
        { key, cmd, desc = "move to window " .. i }
    })
end

which_key.add({
    mode = { "v" },
    { "",          group = "Visual Character Mode" },
    { "J",         ":m '>+1<CR>gv=gv",             desc = "Move current selection downwards" },
    { "K",         ":m '<-2<CR>gv=gv",             desc = "Move current selection upwards" },
    { "<leader>y", "\"+y",                         desc = "Yank into system clipboard while in visual mode" }
})

which_key.add({
    mode = { "x" },
    { "<leader>",  group = "[X] mode" },
    { "<leader>P", "\"_dP",           desc = "Keep old past in paste buffer" }
})

-- local function old_split_definition(split_direction)
--   split_direction = split_direction or "s"
--
--   local split_direction_command = "split"
--
--   if split_direction == "v" then
--     split_direction_command = "vsplit"
--   end
--
--   vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(),
--     function(err, result, ctx, config)
--       if err then
--         print(err)
--         return
--       end
--
--       local command = split_direction_command .. vim.uri_to_fname(result[1].uri)
--       local line = "call cursor(" ..
--           (result[1].range.start.line + 1) .. "," .. (result[1].range.start.character + 1) .. ")"
--       vim.cmd(command)
--       vim.cmd(line)
--     end)
-- end

local status_telescope_builtin, telescope_builtin = pcall(require, "telescope.builtin")
if not status_telescope_builtin then
    vim.notify("Error from base.keymaps: telescope.builtin not found.")
end

function BASE.split_definition(split_direction)
    split_direction = split_direction or "s"

    local split_direction_command = "split"

    if split_direction == "v" then
        split_direction_command = "vsplit"
    end

    vim.cmd(split_direction_command)
    vim.lsp.buf.definition()
end

local function _preview_location_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

function BASE.peekDefinition()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, _preview_location_callback)
end

function BASE.set_lsp_keymaps(bufnr, wk)
    which_key.add({
        { mode = "i" },
        { "<c-h>",   function() vim.lsp.buf.signature_help() end, desc = "Signature Help" }
    })

    wk.add({
        { buffer = bufnr },
        { "<leader>l",   group = "[L]sp" },
        { "<leader>lp",  function() BASE.peekDefinition() end,        desc = "[P]eek" },
        { "<leader>lg",  function() vim.lsp.buf.definition() end,     desc = "[G]o to in current window" },
        { "<leader>ls",  function() BASE.split_definition() end,      desc = "Open in a [S]plit window" },
        { "<leader>lv",  function() BASE.split_definition("v") end,   desc = "Open in a [V]ertical split window" },
        { "<leader>li",  function() vim.lsp.buf.implementation() end, desc = "[I]mplementation" },
        { "<leader>lr",  function() vim.lsp.buf.references() end,     desc = "[R]eferences" },
        { "<leader>lR",  function() vim.lsp.buf.rename() end,         desc = "[R]ename" },
        { "<leader>D",   group = "[D]iagnostics" },
        { "<leader>Dh",  function() vim.diagnostic.hide() end,        desc = "[H]ide" },
        { "<leader>Ds",  function() vim.diagnostic.show() end,        desc = "[S]how" },
        { "<leader>Dp",  function() vim.diagnostic.goto_prev() end,   desc = "Previous diagnostic" },
        { "<leader>Dn",  function() vim.diagnostic.goto_next() end,   desc = "Next diagnostic" },
        -- "<leader>a", function() require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor()) end, desc = "Code [A]ctions" }
        { "<leader>a",   function() vim.lsp.buf.code_action() end,    desc = "Code [A]ctions" },
        { "<leader>K",   function() vim.lsp.buf.hover() end,          desc = "Hover" }
    })
end
