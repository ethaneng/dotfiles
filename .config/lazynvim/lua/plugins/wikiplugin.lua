return {
  {
    "ethaneng/wikimode.nvim",
    config = function()
      require("wikiplugin").setup()
    end,
    dir = "~/.config/lazynvim/lua/wikiplugin",
  },
}
