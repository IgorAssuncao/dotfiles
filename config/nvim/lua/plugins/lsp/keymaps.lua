local lsp = require('lsp-zero')

local function split_definition(split_direction)
  split_direction = split_direction or "s"

  local split_direction_command = "split"

  if split_direction == "v" then
    split_direction_command = "vsplit"
  end

  vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(),
    function(err, result, ctx, config)
      if err then
        print(err)
        return
      end

      local command = split_direction_command .. vim.uri_to_fname(result[1].uri)
      local line = "call cursor(" ..
          (result[1].range.start.line + 1) .. "," .. (result[1].range.start.character + 1) .. ")"
      vim.cmd(command)
      vim.cmd(line)
    end)
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

lsp.on_attach(function(client, bufnr)
  local keybind = require("base.keymaps").Keybind

  keybind("n", "<leader>pd", function() peekDefinition() end,
    { buffer = bufnr, remap = false, desc = "[P]eek [D]efinition" })
  keybind("n", "gd", function() vim.lsp.buf.definition() end,
    { buffer = bufnr, remap = false, desc = "[G]o to [D]efinition" })
  keybind("n", "gsd", function() split_definition() end,
    { buffer = bufnr, remap = false, desc = "[G]o to [S]plit [D]efinition" })
  keybind("n", "gvd", function() split_definition("v") end,
    { buffer = bufnr, remap = false, desc = "[G]o to [V]ertical [D]efinition" })
  keybind("n", "K", function() vim.lsp.buf.hover() end, { buffer = bufnr, remap = false, desc = "Hover" })
  keybind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = bufnr, remap = false, desc = "[H]elp" })
  -- Keybind("n", "<leader>ld", function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end, { buffer = bufnr, remap = false, desc = "Open diagnostics"})
  keybind("n", "<leader>ds", function() vim.diagnostic.show() end,
    { buffer = bufnr, remap = false, desc = "[D]iagnostics [S]how" })
  keybind("n", "<leader>dh", function() vim.diagnostic.hide() end,
    { buffer = bufnr, remap = false, desc = "[D]iagnostics [H]ide" })
  keybind("n", "[d", function() vim.diagnostic.goto_prev() end,
    { buffer = bufnr, remap = false, desc = "Go to prev diagnostic" })
  keybind("n", "]d", function() vim.diagnostic.goto_next() end,
    { buffer = bufnr, remap = false, desc = "Go to next diagnostic" })

  -- vim.lsp.buf_attach_client(vim.api.nvim_get_current_buf(), client.id)
end)
