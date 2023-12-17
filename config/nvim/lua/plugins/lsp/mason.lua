-- Auto install LSP servers
return {
  "williamboman/mason.nvim",
  dependencies = {
    {
      "lvimuser/lsp-inlayhints.nvim",
      -- ONLY NECESSARY TO HAVE VIRTUAL TEXT
      -- ONLY WORKS WITH NEOVIM NIGHTLY (v0.10)
      branch = "anticonceal"
    }
  },
  config = function()
    require("mason").setup({
      log_level = vim.log.levels.INFO
    })

    local status_lsp_inlay_hints, lsp_inlay_hints = pcall(require, "lsp-inlayhints")
    if not status_lsp_inlay_hints then
      vim.notify("Error form plugins.lsp.mason: lsp-inlayhints not found.")
    else
      lsp_inlay_hints.setup {
        inlay_hints = {
          labels_separator = " - ",
          parameter_hints = {
            show = true,
            prefix = "PT: <- ",
            separator = ", ",
            remove_colon_start = false,
            remove_colon_end = true,
          },
          type_hints = {
            -- type and other hints
            show = true,
            prefix = "RT: ",
            separator = ", ",
            remove_colon_start = false,
            remove_colon_end = false,
          },
        }
      }
    end
  end
}
