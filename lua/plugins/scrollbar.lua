return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup({
      handle = {
        color = "#5c6370", 
      },
      marks = {
        Search = { color = "#ff9e64" },
        Error  = { color = "#db4b4b" },
        Warn   = { color = "#e0af68" },
        Info   = { color = "#0db9d7" },
        Hint   = { color = "#10b981" },
        Misc   = { color = "#6366f1" },
      },
    })
  end,
}

