return {
  "olimorris/codecompanion.nvim",
  config = true,
  init = function()
    require("plugins.extensions.codecompanion-notifications").init()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "gemini",
      },
    },
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = os.getenv("ANTHROPIC_API_KEY"),
          },
        })
      end,
    },
  },
}
