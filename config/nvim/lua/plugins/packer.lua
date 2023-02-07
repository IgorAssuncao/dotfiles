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

-- Use a protected call so packer don't error
-- out in first use
local status_packer, packer = pcall(require, "packer")
if not status_packer then
  vim.notify("Error from plugins.packer: packer not found.")
  return
end

-- Auto sorce this file and make PackerSync
vim.api.nvim_create_autocmd(
  {
    "BufWritePost"
  },
  {
    pattern = "packer.lua",
    command = "source <afile> | PackerSync",
    group = vim.api.nvim_create_augroup(
      "SourcePackerAndSync",
      {
        clear = true
      }
    )
  }
)

packer.init {
  -- disable_commands = true,
  -- log = { level = "debug" },
  profile = {
    enable = true,
    threshold = 1
  },
  display = {
    open_fn = function()
      local result, win, buf = require("packer.util").float({ border = "rounded" })
      vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
      return result, win, buf
    end
  },
  -- TODO: Change packer git default_url_format to use SSH
  -- {
  --   git = {
  -- 	   default_url_format = "git@github.com:%s"
  -- 	 }
  -- }
}

packer.startup({
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use {
      "EdenEast/nightfox.nvim",
      as = "nightfox",
      config = function()
        vim.cmd("colorscheme duskfox")
      end
    }

    use "folke/which-key.nvim"

    use {
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" }
    }

    use {
      "nvim-lualine/lualine.nvim",
      requires = { "nvim-tree/nvim-web-devicons" }
    }

    use {
      "akinsho/bufferline.nvim",
      tag = 'v3.*',
      requires = { "nvim-tree/nvim-web-devicons" }
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        { "p00f/nvim-ts-rainbow" },
        { "nvim-treesitter/playground" }
      }
    }

    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      requires = { "nvim-lua/plenary.nvim" }
    }

    -- use "theprimeagen/harpoon"

    use "tpope/vim-fugitive"

    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" }
    }

    -- Autocompletion
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "L3MON4D3/LuaSnip" }, -- Snippets engine

        { "hrsh7th/cmp-nvim-lsp" }, -- nvim-cmp source for nvim builtin language server client
        { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- nvim-cmp source for nvim builtin language server client for signature helping
        { "hrsh7th/cmp-nvim-lua" }, -- nvim-cmp source for nvim lua api
        { "saadparwaiz1/cmp_luasnip" }, -- completion source for nvim-cmp
        { "hrsh7th/cmp-buffer" }, -- nvim-cmp source for buffer
        { "hrsh7th/cmp-path" }, -- nvim-cmp source for buffer words
        { "hrsh7th/cmp-nvim-lsp-document-symbol" }, -- nvim-cmp source for lsp symbols

        { "chrisgrieser/cmp-nerdfont" }, -- nvim-cmp source for buffer words

        { "onsails/lspkind.nvim" }, -- Autocompletion Icons
      }
    }

    use "williamboman/mason.nvim" -- Auto install LSP servers
    use "williamboman/mason-lspconfig.nvim" -- Bridges mason and nvim-lsp
    use "neovim/nvim-lspconfig" -- NeoVim LSP

    use {
      "windwp/nvim-autopairs",
      requires = {
        "hrsh7th/nvim-cmp"
      }
    }

    use "mbbill/undotree"

    use "akinsho/toggleterm.nvim"

    use "ahmedkhalf/project.nvim"

    use "lukas-reineke/indent-blankline.nvim"

    use "lvimuser/lsp-inlayhints.nvim"

    -- Still has to learn its purpose and how it can be useful to me.
    -- use {
    --   "dhruvasagar/vim-prosession",
    --   after = { "vim-obsession" },
    --   requires = { "tpope/vim-obsession", cmd = "Prosession" }
    -- }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      packer.sync()
    end
  end,
})

return packer
