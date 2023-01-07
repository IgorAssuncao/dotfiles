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

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

local function peekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  local keybind = vim.keymap.set

  keybind("n", "<leader>pd", function() peekDefinition() end, opts)
  keybind("n", "gd", function() vim.lsp.buf.definition() end, opts)
  keybind("n", "gsd", function() split_definition() end, opts)
  keybind("n", "gvd", function() split_definition("v") end, opts)
  keybind("n", "K", function() vim.lsp.buf.hover() end, opts)
  keybind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  -- keybind("n", "<leader>ld", function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end, opts)
  keybind("n", "<leader>ds", function() vim.diagnostic.show() end, opts)
  keybind("n", "<leader>dh", function() vim.diagnostic.hide() end, opts)
  keybind("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  keybind("n", "]d", function() vim.diagnostic.goto_next() end, opts)

  -- vim.lsp.buf_attach_client(vim.api.nvim_get_current_buf(), client.id)
end)
