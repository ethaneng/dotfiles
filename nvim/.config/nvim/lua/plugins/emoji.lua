return {
  {
    "allaman/emoji.nvim",
    version = "1.0.0", -- optionally pin to a tag
    -- ft = "markdown", -- adjust to your needs
    dependencies = {
      -- util for handling paths
      "nvim-lua/plenary.nvim",
      -- optional for fzf-lua integration via vim.ui.select
      "ibhagwan/fzf-lua",
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      enable_cmp_integration = true,
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      vim.keymap.set("n", "<leader>se", function()
        require("emoji").insert()
      end, { desc = "Search Emoji", noremap = true, silent = true })
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "emoji" },
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            -- overwrite kind of suggestion
            transform_items = function(ctx, items)
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              for i = 1, #items do
                items[i].kind = kind
              end
              return items
            end,
          },
        },
      },
    },
  },
}
