return {
  "uga-rosa/ccc.nvim",
  config = function()
    vim.opt.termguicolors = true

    require("ccc").setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })

    vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<CR>", { desc = "Pick color" })
    vim.keymap.set("n", "<leader>cc", "<cmd>CccConvert<CR>", { desc = "Convert color" })
  end,
}

