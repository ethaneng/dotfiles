-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/telescope.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/telescope.lua
--
-- https://github.com/nvim-telescope/telescope.nvim

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return {
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = true,
            },
          },
          mappings = {
            n = {
              ["d"] = require("telescope.actions").delete_buffer,
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      }
    end,
  },
}
