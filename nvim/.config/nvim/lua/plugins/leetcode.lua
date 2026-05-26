return {
  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
    },
    ---@type lc.UserConfig
    opts = {
      lang = "typescript",
      picker = { provider = "snacks-picker" },
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      injector = {
        ["typescript"] = {
          before = { "// @ts-nocheck" },
        },
      },
    },
    keys = {
      { "<leader>L", "<cmd>Leet<cr>", desc = "Leetcode menu" },
      { "<leader>Lr", "<cmd>Leet run<cr>", desc = "Leet: run tests" },
      { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "Leet: submit" },
      { "<leader>Ld", "<cmd>Leet daily<cr>", desc = "Leet: daily problem" },
      { "<leader>Ll", "<cmd>Leet list<cr>", desc = "Leet: problem list" },
      { "<leader>Lc", "<cmd>Leet console<cr>", desc = "Leet: toggle console" },
      { "<leader>Li", "<cmd>Leet info<cr>", desc = "Leet: info" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "html" } },
  },
}
