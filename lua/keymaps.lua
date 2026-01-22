vim.keymap.set("n", "<leader>z", "<C-w>w")
vim.keymap.set("n", "<leader>q", "<cmd>QuartoPreview<CR>", {desc = "Quarto: Preview"})
vim.keymap.set("n", "<leader>a", function()
  require("neo-tree.command").execute({
    toggle = true,
    dir = vim.fn.expand("%:p:h"),
  })
end, { desc = "Neo-tree (current dir)" })
