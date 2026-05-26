return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(c)
        c.bg_statusline = c.none
      end,
      on_highlights = function(hl, c)
        hl.DiagnosticUnnecessary = {
          -- fg = "#444a73", <-- previously this, just want to increase visibility against the dark bg
          fg = "#575d86",
        }

        hl["@comment"] = {
          fg = c.comment,
          bg = c.bg_dark,
        }

        hl["BlinkCmpGhostText"] = hl["BlinkCmpMenuBorder"]

        hl.TabLineFill = {
          bg = c.none,
        }

        hl.WinSeparator.fg = c.red
      end,
    },
  },
}
