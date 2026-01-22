-- neo tree
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
        keywords = {
            TODO = { color = "#f5706d" },
            BLOC = { color = "#4cd887" },
            SLIDE = { color = "#928e8e" },
        },    
    })
  end,
}

