-- base options
vim.opt.termguicolors = true
vim.opt.number = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_scroll_animation_length = 0
vim.o.guifont = "FiraCode Nerd Font Mono:h12"
vim.o.showmode = false
vim.o.undofile = true
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- load modules
require("bootstrap") 
require("setup")
require("keymaps")
require("quarto_stp")

-- starting commands
vim.cmd("colorscheme atom-dark-syntax")
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#427490" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#95b5c7" })

