local status_illuminate, illuminate = pcall(require, "illuminate")
if not status_illuminate then
  vim.notify("Error from plugins.p_illuminate: illuminate not found.")
  return
end

illuminate.configure()

local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("error from p_illuminate: which-key not found.")
  return
end

which_key.register({
  ["<leader>"] = {
    i = {
      name = "[I]lluminate",
      n = { function() illuminate.goto_next_reference() end, "[N]ext reference" },
      p = { function() illuminate.goto_prev_reference() end, "[P]revious reference" }
    }
  }
})
