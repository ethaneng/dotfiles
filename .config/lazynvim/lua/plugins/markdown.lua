-- return {}
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function()
    -- Clear obsidian.nvim UI namespace if it exists to prevent conflicts
    local obsidian_ok, obsidian = pcall(require, "obsidian")
    if obsidian_ok then
      local client = obsidian.get_client()
      if client and client.opts then
        client.opts.ui = client.opts.ui or {}
        client.opts.ui.enable = false
      end

      local namespaces = vim.api.nvim_get_namespaces()
      if namespaces["ObsidianUI"] then
        vim.api.nvim_buf_clear_namespace(0, namespaces["ObsidianUI"], 0, -1)
      end
    end

    -- Set up custom highlights for softer white text
    vim.api.nvim_set_hl(0, "RenderMarkdownParagraph", { fg = "#b1bac4" }) -- Softer white

    require("render-markdown").setup({
      bullet = {
        left_pad = 1,
        right_pad = 1,
      },
      heading = {
        -- icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
        icons = { "❯ ", "❯❯ ", "❯❯❯ ", "❯❯❯❯ ", "❯❯❯❯❯ ", "❯❯❯❯❯❯ " },
      },
      completions = {
        blink = {
          enabled = true,
        },
      },
      checkbox = {
        unchecked = {
          icon = "󰄱 ",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "󰱒 ",
          highlight = "RenderMarkdownChecked",
        },
        custom = {
          todo = {
            raw = "[~]",
            rendered = "󰰪 ",
            highlight = "RenderMarkdownTodo",
          },
          forward = {
            raw = "[>]",
            rendered = "󰜴 ",
            highlight = "RenderMarkdownForward",
          },
          important = {
            raw = "[!]",
            rendered = " ",
            highlight = "RenderMarkdownImportant",
          },
        },
      },
      -- Set up softer white for body text
      paragraph = {
        highlight = "RenderMarkdownParagraph",
      },
    })
  end,
}
