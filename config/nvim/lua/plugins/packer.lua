-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  -- -- TODO: Custom packer install_path.
  -- local config_dir = vim.api.nvim_list_runtime_paths()[1]
  -- local install_path = config_dir .. "/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- local packer = require("packer")
-- TODO: Change packer git default_url_format to use SSH
-- packer.init(
--   {
--     git = {
-- 	  default_url_format = "git@github.com:%s"
-- 	}
--   }
-- )

-- Use a protected call so packer don't error
-- out in first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Auto sorce this file and make PackerSync
vim.api.nvim_create_autocmd(
  {
    "BufWritePost"
  },
  {
    pattern = "plugins/packer.lua",
    command = "source <afile> | PackerSync",
    group = vim.api.nvim_create_augroup(
      "SourcePackerAndSync",
      {
        clear = true
      }
    )
  }
)

return packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    }
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  use "nvim-treesitter/playground"

  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- use "theprimeagen/harpoon"

  use "tpope/vim-fugitive"

  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function() require("gitsigns").setup() end
  }

  use {
    "windwp/nvim-autopairs",
    requires = {
      "hrsh7th/nvim-cmp"
    },
    config = function() require("nvim-autopairs").setup {} end,
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }

  use "mbbill/undotree"

  use "akinsho/toggleterm.nvim"

  use {
    "EdenEast/nightfox.nvim",
    as = "nightfox"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
