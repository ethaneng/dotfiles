local bearded_arc = {}

bearded_arc = {
  foreground = "#ABB7C1",
  background = "#1c2433",
  cursor_bg = "#ABB7C1",
  cursor_border = "#ABB7C1",
  cursor_fg = "#1c2433",
  selection_bg = "#3a4251",
  selection_fg = "#c3cfd9",

  ansi = {
    "#1c2433", -- black
    "#FF738A", -- red
    "#3CEC85", -- green
    "#EACD61", -- yellow
    "#69C3FF", -- blue
    "#B78AFF", -- magenta
    "#22ECDB", -- cyan
    "#ABB7C1", -- white
  },
  brights = {
    "#4e5665", -- bright black (grey)
    "#FF738A", -- bright red
    "#9bdead", -- bright green
    "#f6d96d", -- bright yellow
    "#69C3FF", -- bright blue
    "#bd93ff", -- bright magenta
    "#12c7c4", -- bright cyan
    "#c3cfd9", -- bright white
  },
  indexed = {
    [16] = "#FF955C", -- orange
    [17] = "#F38CEC", -- baby pink
    [18] = "#ee9cdd", -- pink
    [19] = "#bd93ff", -- purple
    [20] = "#B78AFF", -- dark purple
    [21] = "#6da4cd", -- nord blue
  },
}

return bearded_arc
