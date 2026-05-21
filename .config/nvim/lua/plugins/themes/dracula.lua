-- adds overrisdes
return {
  {
    "Mofiqul/dracula.nvim",
    opts = {
      colors = {
        bg = "#282a36",
        fg = "#f8f8f2",
        selection = "#44475a",
        comment = "#6272a4",
        red = "#ff5555",
        orange = "#ffb86c",
        yellow = "#f1fa8c",
        green = "#50fa7b",
        purple = "#bd93f9",
        cyan = "#8be9fd",
        pink = "#ff79c6",
        bright_red = "#ff6e6e",
        bright_green = "#69ff94",
        bright_yellow = "#ffffa5",
        bright_blue = "#d6acff",
        bright_magenta = "#ff92df",
        bright_cyan = "#a4ffff",
        bright_white = "#ffffff",
        menu = "#21222c",
        visual = "#3e4452",
        gutter_fg = "#4b5263",
        nontext = "#3b4048",
      },
      overrides = {
        -- Improve search highlighting
        Search = { bg = "#ffb86c", fg = "#282a36" },
        IncSearch = { bg = "#ff79c6", fg = "#282a36" },
        CurSearch = { bg = "#50fa7b", fg = "#282a36" },

        -- Better visual selection
        Visual = { bg = "#44475a" },
        VisualNOS = { bg = "#44475a" },
        -- Improve line numbers and cursor line
        LineNr = { fg = "#6272a4" },
        CursorLineNr = { fg = "#f1fa8c", bold = true },
        CursorLine = { bg = "#2a2c3a" },
        -- Better comment visibility
        Comment = { fg = "#7c8db8", italic = true },
        -- Snacks picker improvements
        SnacksPickerDir = { fg = "#bd93f9" },
        SnacksPickerFile = { fg = "#f8f8f2" },
        SnacksPickerMatch = { fg = "#f1fa8c", bold = true },
        SnacksPickerIcon = { fg = "#8be9fd" },
        SnacksPickerTitle = { fg = "#ff79c6", bold = true },
        SnacksPickerBorder = { fg = "#6272a4" },
        SnacksPickerPreview = { fg = "#f8f8f2" },
        SnacksPickerSelect = { bg = "#44475a", fg = "#f1fa8c" },
        -- Improve muted text contrast
        NonText = { fg = "#6272a4" },
        SpecialKey = { fg = "#6272a4" },
        Whitespace = { fg = "#4b5263" },
        -- Better popup and floating window contrast
        NormalFloat = { bg = "#21222c", fg = "#f8f8f2" },
        FloatBorder = { bg = "#21222c", fg = "#6272a4" },
        Pmenu = { bg = "#21222c", fg = "#f8f8f2" },
        PmenuSel = { bg = "#44475a", fg = "#f1fa8c" },
        PmenuSbar = { bg = "#44475a" },
        PmenuThumb = { bg = "#6272a4" },
      },
    },
  },
}
