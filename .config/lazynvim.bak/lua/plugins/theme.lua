return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = false,
      dim_inactive = true,
      style = "moon",
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "tummetott/reticle.nvim",
    event = "VeryLazy", -- optionally lazy load the plugin
    opts = {
      on_startup = {
        cursorline = true,
        cursorcolumn = false,
      },
    },
  },
}
