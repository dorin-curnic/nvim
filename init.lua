vim.opt.number = true
vim.opt.clipboard = "unnamedplus"

require("config.vim-options")
require("config.lazy")
require("config.keymaps").setup()
