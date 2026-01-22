return {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jmbuhr/otter.nvim",
    },
    config = function()
      require("quarto").setup({
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          languages = { "python", "r", "julia", "bash" },
          completion = { enabled = true },
          diagnostics = { enabled = true, triggers = { "BufWritePost" } },
        },
        codeRunner = {
          enabled = true,
          never_run = { 'yaml' },
        },
      })
    end,
}

