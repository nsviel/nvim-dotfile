return {
  "uga-rosa/ccc.nvim",
  config = function()
    require("ccc").setup()
    vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<CR>", { desc = "Pick color" })
    vim.keymap.set("n", "<leader>cc", "<cmd>CccConvert<CR>", { desc = "Convert color" })
  end,
}

