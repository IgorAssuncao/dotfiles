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

which_key.register({
    -- ["<C-H>"] = { function() vim.cmd.wincmd('h') end, "Move to window on the left" },
    -- ["<C-J>"] = { function() vim.cmd.wincmd('j') end, "Move to window below" },
    -- ["<C-K>"] = { function() vim.cmd.wincmd('k') end, "Move to window above" },
    -- ["<C-L>"] = { function() vim.cmd.wincmd('l') end, "Move to window on the right" },
    ["<leader>"] = {
        name = "Custom",
        C = {
            function() vim.cmd("nohls") end, "[C]lear Search Highlighting"
        },
        E = {
            vim.cmd.Ex, "[E]xplorer"
        },
        b = {
            name = "[B]uffer",
            d = { vim.cmd.bd, "[D]elete", },
            n = { vim.cmd.bn, "[N]ext" },
            p = { vim.cmd.bp, "[P]revious" },
        },
        q = { vim.cmd.quit, "[Q]uit" },
        w = { vim.cmd.write, "[W]rite" },
        x = { vim.cmd.exit, "E[x]it" },
    },
    H = { "^", "Go to start of line" },
    L = { "$", "Go to end of line" },
    ["<Left>"] = { vim.cmd.bp, "Previous buffer" },
    ["<Right>"] = { vim.cmd.bn, "Next buffer" }
})

for i = 1, 9, 1 do
    local key = "<leader>" .. i
    local cmd = i .. "<C-W>w"
    which_key.register({
        [key] = { cmd, "move to window " .. i }
    })
end

which_key.register({
    [""] = {
        name = "Visual Character Mode",
        J = { ":m '>+1<CR>gv=gv", "Move current selection downwards" },
        K = { ":m '<-2<CR>gv=gv", "Move current selection upwards" }
    },
    ["<leader>y"] = { "\"+y", "Yank into system clipboard while in visual mode" }
}, { mode = "v" })

which_key.register({
    ["<leader>"] = {
        name = "[X] mode",
        P = { "\"_dP", "Keep old past in paste buffer" }
    }
}, { mode = "x" })

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
    wk.register({
        ["<c-h>"] = { function() vim.lsp.buf.signature_help() end, "Signature Help" }
    }, { mode = "i" })

    wk.register({
        ["<leader>"] = {
            l = {
                name = "[L]sp",
                p = { function() BASE.peekDefinition() end, "[P]eek" },
                g = { function() vim.lsp.buf.definition() end, "[G]o to in current window" },
                s = { function() BASE.split_definition() end, "Open in a [S]plit window" },
                v = { function() BASE.split_definition("v") end, "Open in a [V]ertical split window" },
                i = { function() vim.lsp.buf.implementation() end, "[I]mplementation" },
                r = { function() vim.lsp.buf.references() end, "[R]eferences" },
                R = { function() vim.lsp.buf.rename() end, "[R]ename" }
            },
            D = {
                name = "[D]iagnostics",
                h = { function() vim.diagnostic.hide() end, "[H]ide" },
                s = { function() vim.diagnostic.show() end, "[S]how" },
                a = { telescope_builtin.diagnostics, "[A]ll" },
                p = { function() vim.diagnostic.goto_prev() end, "Previous diagnostic" },
                n = { function() vim.diagnostic.goto_next() end, "Next diagnostic" }
            },
            -- a = { function() require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor()) end,
            --   "Code [A]ctions" }
            a = { function() vim.lsp.buf.code_action() end,
                "Code [A]ctions" }
        },
        K = { function() vim.lsp.buf.hover() end, "Hover" }
    }, { buffer = bufnr })
end
