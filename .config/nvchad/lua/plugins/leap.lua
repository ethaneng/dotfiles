return {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = { "tpope/vim-repeat" },
  config = function()
    local leap = require "leap"
    leap.create_default_mappings()
  end,
}
