return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    if vim.fn.getcwd() == "/Users/ethan/dotfiles" then
      opts.filesystem.filtered_items.hide_dotfiles = false
    end
    return opts
  end,
}
