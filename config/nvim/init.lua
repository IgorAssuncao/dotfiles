vim.g.mapleader = " "

-- Bootstrap package manager first
-- because I use whick key as the default keymapper
require("lazy_setup")

require("base")
require("plugins")
require("after")
