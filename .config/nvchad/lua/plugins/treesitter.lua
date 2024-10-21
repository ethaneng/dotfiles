return {
  "nvim-treesitter/nvim-treesitter",
  opts = function()
    opts = require "nvchad.configs.treesitter"
    opts.ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
    }
    return opts
  end,
}
