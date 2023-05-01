local diagnosticsGroup = vim.api.nvim_create_augroup(
  "DiagnosticsGroup",
  {
    clear = true
  }
)

vim.api.nvim_create_autocmd(
  {
    "CursorHold",
    "CursorHoldI"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.open_float(nil, { focus = false, scope = \"cursor\" })",
    group = diagnosticsGroup
  }
)

vim.api.nvim_create_autocmd(
  {
    "InsertEnter"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.hide(nil, 0)",
    group = diagnosticsGroup
  }
)

vim.api.nvim_create_autocmd(
  {
    "InsertLeave"
  },
  {
    pattern = { "*" },
    command = "lua vim.diagnostic.show(nil, 0)",
    group = diagnosticsGroup
  }
)

-- LSP auto format
vim.api.nvim_create_autocmd(
  {
    "BufWritePre"
  },
  {
    pattern = { "*" },
    command = "lua vim.lsp.buf.format({ bufnr = nil, timeout_ms = 5000 })"
    -- The format() can also receive an argument
    -- to make formatting async, like:
    -- format({ async = true })
    -- I'm not currently using it because it makes
    -- changes to the buffer after its saved, therefore
    -- entering a loop.
  }
)
