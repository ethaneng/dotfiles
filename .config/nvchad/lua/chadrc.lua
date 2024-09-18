-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "bearded-arc",
  transparency = true,
  telescope = {
    style = "bordered",
  },

  hl_override = {
    Comment = {
      italic = true,
      fg = { "green", 8 },
      bg = { "white", -50 },
    },
    ["@comment"] = {
      italic = true,
      fg = { "green", 8 },
      bg = { "white", -50 },
    },
    NvDashAscii = {
      fg = { "green", 0 },
      bg = { "black", 0 },
    },
    NvDashButtons = {
      fg = { "green", 0 },
      bg = { "black", 0 },
    },
    WinSeparator = {
      fg = { "blue", 0 },
      bg = { "black", 0 },
    },
    CursorLine = {
      bg = { "yellow", -50 },
    },
    Cursor = {
      fg = { "white", 20 },
      bg = { "yellow", -30 },
    },
  },
  nvdash = {
    load_on_startup = true,
    header = require "misc/headers/hydra",
    buttons = {
      { "  Find File", "Spc f f", "Telescope find files" },
      { "󰈚  Recent Files", "Spc f r", "Telescope find recent files" },
      { "󰈭  Find Word", "Spc f w", "Telescope find words" },
      { "  File Explorer", "Spc e  ", "NvimTree Toggle" },
      { "  Bookmarks", "Spc m a", "Telescope find marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
}

return M
