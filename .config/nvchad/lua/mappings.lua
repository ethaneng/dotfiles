require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode", silent=true})
map("i", "kj", "<ESC>", {silent=true})

-- Vim Tmux Navigator
map("n", "<c-h>", ":TmuxNavigateLeft<cr>", { silent = true })
map("n", "<c-j>", ":TmuxNavigateDown<cr>", { silent = true })
map("n", "<c-k>", ":TmuxNavigateUp<cr>", { silent = true })
map("n", "<c-l>", ":TmuxNavigateRight<cr>", { silent = true })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>fk", ":Telescope keymaps<cr>", { desc = "Find keymaps" })

map('n', '<leader>ld', ':cd ~/dotfiles <cr>')
map('n', '<leader>lh', ':cd ~ <cr>')
map('n', '<leader>lr', ':cd ~/repos <cr>')

