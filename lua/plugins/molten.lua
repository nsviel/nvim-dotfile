return {
  "benlubas/molten-nvim",
  build = ":UpdateRemotePlugins",
  init = function()
    -- qualité de vie
    vim.g.molten_auto_open_output = false
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true
  end,
}

