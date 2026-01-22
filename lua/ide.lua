-- Copy past
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy (system clipboard)" })
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut (system clipboard)" })
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste (system clipboard)" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste (system clipboard)" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })

--save
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- text selection
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("s", "<Tab>", "<Esc>>gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.keymap.set("s", "<S-Tab>", "<Esc><gv", { noremap = true, silent = true })

vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })

-- Undo
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<Esc>u", { desc = "Undo" })

-- Redo
vim.keymap.set("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
vim.keymap.set("i", "<C-S-z>", function()
  vim.cmd("normal! <C-r>")
  vim.cmd("startinsert")
end, { desc = "Redo" })

-- Tabulation
vim.keymap.set("n", "<M-Right>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<M-Left>",  ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Unindent" })

-- Tab
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>")


