local map = vim.keymap.set

-- Shortcuts
map({'n', 'v'}, ";", ":", { desc = "QoL enter command mode", silent = false })
map("i", "kj", "<ESC>", { desc = "QoL quick escape", silent = true })
map({ "n", "i" }, "<HOME>", "<ESC>^", { desc = "QoL start of line" })

-- Splits
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "split vertical" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "split horizontal" })

-- Vim Tmux Navigator
-- map("n", "<c-h>", ":TmuxNavigateLeft<cr>", { desc = "Term/Nvim navigate left a window", silent = true })
-- map("n", "<c-j>", ":TmuxNavigateDown<cr>", { desc = "Term/Nvim navigate down a window", silent = true })
-- map("n", "<c-k>", ":TmuxNavigateUp<cr>", { desc = "Term/Nvim navigate up a window", silent = true })
-- map("n", "<c-l>", ":TmuxNavigateRight<cr>", { desc = "Term/Nvim navigate right a window", silent = true })

-- Smart Splits
map("n", "<A-h>", require("smart-splits").resize_left)
map("n", "<A-j>", require("smart-splits").resize_down)
map("n", "<A-k>", require("smart-splits").resize_up)
map("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)
map("n", "<C-_>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

-- Locations
map("n", "<leader>ld", ":cd ~/dotfiles <cr>", { desc = "Locations: ~/dotfiles" })
map("n", "<leader>lh", ":cd ~ <cr>", { desc = "Locations: home" })
map("n", "<leader>lr", ":cd ~/repos <cr>", { desc = "Locations: ~/repos" })

map('n', '<C-w>z', '<cmd>ZenMode<CR>', {desc = "Zen Mode"})

-- The mappings below are modified mappings of the default nvchad mappings

-- Clear Highlights
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- Save
map({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "file save" })

-- Copy Whole File
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole file" })

-- Line Numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "line relative number" })

-- Cheatsheet
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "cheatsheet" })

-- Appearance
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "appearance toggle transparency" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "appearance themes" })

-- Format
map("n", "<leader>df", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "file document format" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

-- Buffer Navigations
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- nvimtree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope find word (live grep)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope find help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find recent files" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", { desc = "telescope find commits" })
map("n", "<leader>fg", "<cmd>Telescope git_status<CR>", { desc = "telescope find git status" })
map("n", "<leader>ft", "<cmd>Telescope terms<CR>", { desc = "telescope find (hidden) terminal" })
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", { desc = "telescope find files" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR", { desc = "telescope find keymaps" })
map("n", "<leader>fs", "<cmd>Telescope session-lens<CR>", { desc = "telescope find sessions" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
map(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  { desc = "telescope find fu[z]zy in current buffer" }
)

-- terminal
map("t", "<ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- toggleable
map({ "n", "t" }, "<A-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggleable floating term" })

map({ "n", "t" }, "<A-|>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-->", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })
