local M = {}

local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("error from p_lsp/keymaps: which-key not found.")
  return
end

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

local function split_definition(split_direction)
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

local function peekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, _preview_location_callback)
end

function RegisterKeysIntoVimHelp()
  which_key.register({
    ["<leader>"] = {
      l = {
        name = "[D]efinition",
        p = { function() peekDefinition() end, "[P]eek" },
        g = { function() vim.lsp.buf.definition() end, "[G]o to in current window" },
        s = { function() split_definition() end, "Open in a [S]plit window" },
        v = { function() split_definition("v") end, "Open in a [V]ertical split window" },
        i = { function() vim.lsp.buf.implementation() end, "[I]mplementation" },
        r = { function() vim.lsp.buf.references() end, "[R]eferences" },
        R = { function() vim.lsp.buf.rename() end, "[R]ename" },
      }
    }
  })
end

vim.cmd([[
autocmd FileType help lua RegisterKeysIntoVimHelp()
]])

function M.register_lsp_keymaps(bufnr)
  which_key.register({
    ["<c-h>"] = { function() vim.lsp.buf.signature_help() end, "Signature Help" }
  }, { mode = "i" })

  which_key.register({
    ["<leader>"] = {
      l = {
        name = "[L]sp",
        p = { function() peekDefinition() end, "[P]eek" },
        g = { function() vim.lsp.buf.definition() end, "[G]o to in current window" },
        s = { function() split_definition() end, "Open in a [S]plit window" },
        v = { function() split_definition("v") end, "Open in a [V]ertical split window" },
        i = { function() vim.lsp.buf.implementation() end, "[I]mplementation" },
        r = { function() vim.lsp.buf.references() end, "[R]eferences" },
        R = { function() vim.lsp.buf.rename() end, "[R]ename" },
      },
      D = {
        name = "[D]iagnostics",
        h = { function() vim.diagnostic.show() end, "[H]ide" },
        s = { function() vim.diagnostic.hide() end, "[S]how" },
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

return M
