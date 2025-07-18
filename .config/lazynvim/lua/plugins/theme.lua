return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Default colorscheme
      colorscheme = "everforest",
    },
  },
  -- Import any theme modules to make theme available as a selectable colorscheme
  require("plugins.themes.catppuccin"),
  require("plugins.themes.tokyonight"),
  require("plugins.themes.everforest"),
}
