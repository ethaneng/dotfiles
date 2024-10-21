return {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = { "tpope/vim-repeat" },
  config = function()
    local map = vim.keymap.set
    map('n', 's', '<Plug>(leap-forward)')
    map('n', 'S', '<Plug>(leap-backward)')
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    -- leap.create_default_mappings()
  end,
}
