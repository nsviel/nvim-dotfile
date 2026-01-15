return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- évite de config trop tôt
  config = function()
    local ok, ts = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return
    end

    ensure_installed = {
      "markdown",
      "markdown_inline",
      "python",
      "r",
      "bash",
      "yaml",
    }

    ts.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}

