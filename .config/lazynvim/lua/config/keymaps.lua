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

map("n", "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "Code Companion Actions" })
map("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Code Companion Chat" })
map("n", "<leader>ag", "<cmd>CodeCompanionCmd<CR>", { desc = "Code Companion Command" })
map("n", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "Code Companion Inline" })
map("v", "<leader>av", "<cmd>CodeCompanionChat Add<CR>", { desc = "Code Companion Add Visually Selected Text To Chat" })
map("v", "<leader>ai", "<cmd>'<,'>CodeCompanion<CR>", { desc = "Code Companion Inline with Visual Selection" })
