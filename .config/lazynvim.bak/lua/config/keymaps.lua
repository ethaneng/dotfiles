-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- map({ "n", "v", "i" }, "kj", "<ESC>", { desc = "Shorthand esc", noremap = true })
map("n", ";", ":", { desc = "Shorthand command", noremap = true })

-- Shorthand 'vv' for visual line mode
map("v", "v", "V", { desc = "Visual Line" })

-- Find files
map("n", "<leader><leader>", function()
  require("telescope.builtin").find_files({ hidden = true })
end, { desc = "Find Files (including hidden)", noremap = true })

-- Buffer Exlorer
map("n", "<S-j>", function()
  require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
    sort_mru = true,
    sort_lastused = true,
    initial_mode = "normal",
    -- Pre-select the current buffer
    -- ignore_current_buffer = false,
    -- select_current = true,
    layout_config = {
      -- Set preview width, 0.7 sets it to 70% of the window width
      preview_width = 0.45,
    },
  }))
end, { desc = "Open telescope buffers" })

-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Go to the beginning line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })

-- Zen mode
map("n", "<leader>z", function()
  require("zen-mode").toggle()
end, { desc = "Toggle zen mode" })
