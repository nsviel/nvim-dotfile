return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("ufo").setup()

    vim.o.foldlevel = 99    
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.opt.foldcolumn = "1"
  end,
}

