-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- Shorthand command
map("n", ";", ":", { desc = "Shorthand command", noremap = true })
map("v", "v", "V", { desc = "Visual Line" })
map({ "n", "v" }, "gh", "^", { desc = "Go to the beginning line" })
map({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })

-- require("plugins.ai.codecompanion").add_keymaps()
