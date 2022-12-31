vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ruler = true
vim.opt.cursorline = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.undodir = os.getenv("HOME").."/system-config/config/nvim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.incsearch = true

-- vim.opt.background = "dark"

-- vim.opt.guicursor = ""

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- TODO: Sets number and relativenumber only on current buffer

-- TODO: Disable auto commenting on new line
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = { "*" },
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
  }
)


-- Terraform auto format on save
vim.api.nvim_create_autocmd(
  { "BufWritePre" },
  {
    pattern = { ".tf" },
    command = "TerraformFmt"
  }
)
