PLUGINS.which_key.register({
  ["<leader>W"] = {
    W = { function() vim.cmd { cmd = "WhichKey" } end, "[W]hich [K]ey Toggle" },
    N = { "<cmd>WhichKey '' n<cr>", "[W]hich [K]ey [N]ormal mode Toggle" },
    I = { "<cmd>WhichKey '' i<cr>", "[W]hich [K]ey [I]nsert mode Toggle" },
    V = { "<cmd>WhichKey '' v<cr>", "[W]hich [K]ey [V]isual mode Toggle" },
  }
})
