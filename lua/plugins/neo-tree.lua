-- neo tree
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            visible = true,
        },
        follow_current_file = {
          enabled = true,
        },
        window = {
            mappings = {
              [".."] = "navigate_up", -- même idée que `..`
            },
        },
        use_libuv_file_watcher = true,
      },

      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none", -- évite conflit avec leader
        },
      },
    })
  end,
}

