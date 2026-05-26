return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    bullet = {
      left_pad = 1,
      right_pad = 1,
    },
    heading = {
      icons = { "❯ ", "❯❯ ", "❯❯❯ ", "❯❯❯❯ ", "❯❯❯❯❯ ", "❯❯❯❯❯❯ " },
    },
    completions = {
      blink = { enabled = true },
    },
    checkbox = {
      unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
      checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
      custom = {
        todo = { raw = "[~]", rendered = "󰰪 ", highlight = "RenderMarkdownTodo" },
        forward = { raw = "[>]", rendered = "󰜴 ", highlight = "RenderMarkdownForward" },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownImportant" },
      },
    },
    paragraph = {
      highlight = "RenderMarkdownParagraph",
    },
  },
  init = function()
    vim.api.nvim_set_hl(0, "RenderMarkdownParagraph", { fg = "#b1bac4" })
  end,
}
