-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- Shorthand command
map("n", ";", ":", { desc = "Shorthand command", noremap = true })
-- Shorthand 'vv' for visual line mode
map("v", "v", "V", { desc = "Visual Line" })
-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Go to the beginning line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })
