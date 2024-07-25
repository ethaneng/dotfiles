require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "kj", "<ESC>")

-- Vim Tmux Navigator    
map("n", "<c-h>", ":TmuxNavigateLeft<cr>", { silent = true })
map("n", "<c-j>", ":TmuxNavigateDown<cr>", { silent = true })
map("n", "<c-k>", ":TmuxNavigateUp<cr>", { silent = true })
map("n", "<c-l>", ":TmuxNavigateRight<cr>", { silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
