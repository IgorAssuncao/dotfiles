-- Custom global plugins table
PLUGINS.packer = require("plugins.packer")

PLUGINS.autopairs = require("nvim-autopairs")
PLUGINS.bufferline = require("bufferline")
PLUGINS.gitsigns = require("gitsigns")
PLUGINS.lsp_zero = require("lsp-zero")
PLUGINS.cmp = require("cmp")
PLUGINS.lspconfig = require("lspconfig")
PLUGINS.lualine = require("lualine")
PLUGINS.nvim_tree = require("nvim-tree")
PLUGINS.telescope = require("telescope")
PLUGINS.toggleterm = require("toggleterm")
PLUGINS.treesitter = require("nvim-treesitter")

require("plugins.p_autopairs")
require("plugins.p_bufferline")
require("plugins.p_fugitive")
require("plugins.p_gitsigns")
-- require("plugins.p_harpoon")
require("plugins.p_lsp")
require("plugins.p_lualine")
require("plugins.p_nvim-tree")
require("plugins.p_telescope")
require("plugins.p_toggleterm")
require("plugins.p_treesitter")
require("plugins.p_undotree")
require("plugins.p_which-key")
