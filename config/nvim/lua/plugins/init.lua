-- Custom global plugins table
PLUGINS.autopairs = BASE.protected_require("nvim-autopairs")
PLUGINS.bufferline = BASE.protected_require("bufferline")
PLUGINS.gitsigns = BASE.protected_require("gitsigns")
PLUGINS.lsp = {
  mason = BASE.protected_require("mason"),
  mason_lspconfig = BASE.protected_require("mason-lspconfig"),
  lspconfig = BASE.protected_require("lspconfig")
}
PLUGINS.cmp = BASE.protected_require("cmp")
PLUGINS.lualine = BASE.protected_require("lualine")
PLUGINS.nvim_tree = BASE.protected_require("nvim-tree")
PLUGINS.telescope = BASE.protected_require("telescope")
PLUGINS.toggleterm = BASE.protected_require("toggleterm")
PLUGINS.treesitter = BASE.protected_require("nvim-treesitter")

BASE.protected_require("plugins.p_autopairs")
BASE.protected_require("plugins.p_bufferline")
BASE.protected_require("plugins.p_fugitive")
BASE.protected_require("plugins.p_gitsigns")
-- BASE.protected_require("plugins.p_harpoon")
BASE.protected_require("plugins.p_lsp")
BASE.protected_require("plugins.p_cmp")
BASE.protected_require("plugins.p_lualine")
BASE.protected_require("plugins.p_nvim-tree")
BASE.protected_require("plugins.p_telescope")
BASE.protected_require("plugins.p_toggleterm")
BASE.protected_require("plugins.p_treesitter")
BASE.protected_require("plugins.p_undotree")
BASE.protected_require("plugins.p_which-key")
