-- load modules
require("option")
require("bootstrap") 
require("setup")
require("keymaps")
require("ide")
require("quarto_stp")
require("tab")

-- starting commands
vim.cmd("colorscheme atom-dark-syntax")
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#427490" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#95b5c7" })

-- final options
vim.opt.mouse = "a"
vim.opt.iskeyword:remove(".")
vim.cmd([[set iskeyword-=.]])
vim.opt_local.iskeyword:remove(".")

