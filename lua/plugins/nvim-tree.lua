return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "     _   __            _           ",
      "    / | / /__  ____ _  (_)___ ___   ",
      "   /  |/ / _ \\/ __ `/ / / __ `__ \\  ",
      "  / /|  /  __/ /_/ / / / / / / / /  ",
      " /_/ |_|\\___/\\__,_/_/ /_/ /_/ /_/   ",
      "               /___/                 ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  Nouveau fichier", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "  Rechercher fichier", ":Telescope find_files<CR>"),
      dashboard.button("g", "󰈭  Grep projet", ":Telescope live_grep<CR>"),
      dashboard.button("r", "  Récents", ":Telescope oldfiles<CR>"),
      dashboard.button("q", "󰅚  Quitter", ":qa<CR>"),
    }

    dashboard.section.footer.val = { "NeoVim ready." }

    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}

