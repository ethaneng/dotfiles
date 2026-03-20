local m = {
  plugin = {
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
          adapter = "gemini",
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
  },
  add_keymaps = function()
    local map = vim.keymap.set
    map("n", "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "Code Companion Actions" })
    map("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Code Companion Chat" })
    map("n", "<leader>ag", "<cmd>CodeCompanionCmd<CR>", { desc = "Code Companion Command" })
    map("n", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "Code Companion Inline" })
    map(
      "v",
      "<leader>av",
      "<cmd>CodeCompanionChat Add<CR>",
      { desc = "Code Companion Add Visually Selected Text To Chat" }
    )
    map("v", "<leader>ai", ":'<,'>CodeCompanion<CR>", { desc = "Code Companion Inline with Visual Selection" })
  end,
}

return m
