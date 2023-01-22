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

-- local function eslint_config_exists()
--   local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)
--
--   if not vim.tbl_isempty(eslintrc) then
--     return true
--   end
--
--   if vim.fn.filereadable("package.json") then
--     if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
--       return true
--     end
--   end
-- end

-- PLUGINS.lspconfig.tsserver.setup {
--   root_dir = function()
--     if not eslint_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   filetypes = {
--     "javascript",
--     "typescript"
--   }
-- }

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

function registerKeysIntoVimHelp()
  PLUGINS.which_key.register({
    ["<leader>"] = {
      d = {
        name = "[D]efinition",
        g = { function() vim.lsp.buf.definition() end, "[G]o to in current window" },
        s = { function() split_definition() end, "Open in a [S]plit window" },
        v = { function() split_definition("v") end, "Open in a [V]ertical split window" },
        p = { function() peekDefinition() end, "[P]eek" }
      }
    }
  })
end

vim.cmd([[
autocmd FileType help lua registerKeysIntoVimHelp()
]])

PLUGINS.lsp_zero.on_attach(function(client, bufnr)
  -- -- { keys ="<leader>ld", cmd = function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end, opts = { buffer = bufnr, desc = "Open diagnostics"}),
  -- -- vim.lsp.buf_attach_client(vim.api.nvim_get_current_buf(), client.id)

  -- This won't exist after I find a way to configure all LSP servers.
  if (client.name == "tsserver") then
    client.server_capabilities.document_formatting = false
  end

  PLUGINS.which_key.register({
    ["<leader>"] = {
      d = {
        name = "[D]efinition",
        g = { function() vim.lsp.buf.definition() end, "[G]o to in current window" },
        s = { function() split_definition() end, "Open in a [S]plit window" },
        v = { function() split_definition("v") end, "Open in a [V]ertical split window" },
        p = { function() peekDefinition() end, "[P]eek" }
      },
      D = {
        name = "[D]iagnostics",
        h = { function() vim.diagnostic.show() end, "[H]ide" },
        s = { function() vim.diagnostic.hide() end, "[S]how" },
        D = { function() vim.diagnostic.goto_prev() end, "Previous diagnostic" },
        d = { function() vim.diagnostic.goto_next() end, "Next diagnostic" }
      },
    },
    K = { function() vim.lsp.buf.hover() end, "Hover" }
  }, { buffer = bufnr })
end)

PLUGINS.which_key.register({
  ["<c-h>"] = { function() vim.lsp.buf.signature_help() end, "Signature Help" }
}, { mode = "i" })

-- Maybe create a function or table that returns the keys to be mapped
-- return { lsp_keys = lsp_keys }