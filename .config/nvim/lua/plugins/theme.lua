return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Default colorscheme
      colorscheme = "github_dark_default",
    },
  },
  -- Import any theme modules to make theme available as a selectable colorscheme
  require("plugins.themes.catppuccin"),
  require("plugins.themes.tokyonight"),
  require("plugins.themes.everforest"),
  require("plugins.themes.dracula"),
  require("plugins.themes.github"),
}
