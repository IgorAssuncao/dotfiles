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

PLUGINS.lsp_zero.on_attach(function(client, bufnr)
  local keymaps = {
    { keys = "<leader>pd", cmd = function() peekDefinition() end,
      opts = { buffer = bufnr, desc = "[P]eek [D]efinition" } },
    { keys = "gd", cmd = function() vim.lsp.buf.definition() end,
      opts = { buffer = bufnr, desc = "[G]o to [D]efinition" } },
    { keys = "gsd", cmd = function() split_definition() end,
      opts = { buffer = bufnr, desc = "[G]o to [S]plit [D]efinition" } },
    { keys = "gvd", cmd = function() split_definition("v") end,
      opts = { buffer = bufnr, desc = "[G]o to [V]ertical [D]efinition" } },
    { keys = "K", cmd = function() vim.lsp.buf.hover() end, opts = { buffer = bufnr, desc = "Hover" } },
    { mode = "i", keys = "<C-h>", cmd = function() vim.lsp.buf.signature_help() end,
      opts = { buffer = bufnr, desc = "[H]elp" } },
    -- { keys ="<leader>ld", cmd = function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end, opts = { buffer = bufnr, desc = "Open diagnostics"}),
    { keys = "<leader>ds", cmd = function() vim.diagnostic.show() end,
      opts = { buffer = bufnr, desc = "[D]iagnostics [S]how" } },
    { keys = "<leader>dh", cmd = function() vim.diagnostic.hide() end,
      opts = { buffer = bufnr, desc = "[D]iagnostics [H]ide" } },
    { keys = "[d", cmd = function() vim.diagnostic.goto_prev() end,
      opts = { buffer = bufnr, desc = "Go to prev diagnostic" } },
    { keys = "]d", cmd = function() vim.diagnostic.goto_next() end,
      opts = { buffer = bufnr, desc = "Go to next diagnostic" } },
  }
  -- vim.lsp.buf_attach_client(vim.api.nvim_get_current_buf(), client.id)

  BASE.set_keymaps(keymaps)
end)
