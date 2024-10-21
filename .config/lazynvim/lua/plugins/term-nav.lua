return {
  -- Smart splits for use with WezTerm splits
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup({
      ignored_filetypes = { "neo-tree" },
    })
  end,
  -- Vim Tmux navigator for use with tmux
  --   'christoomey/vim-tmux-navigator',
  --   cmd = {
  --     'TmuxNavigateLeft',
  --     'TmuxNavigateDown',
  --     'TmuxNavigateUp',
  --     'TmuxNavigateRight',
  --     'TmuxNavigatePrevious',
  --   },
  --   keys = {
  --     { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
  --     { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
  --     { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
  --     { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
  --     -- { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  --   },
}
