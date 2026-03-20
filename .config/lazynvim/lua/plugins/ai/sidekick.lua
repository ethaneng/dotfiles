return {
  {
    "folke/sidekick.nvim",
    lazy = false,
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      -- Uncomment below
      -- Commented out ai commands to use opencode.lua instead
      -- {
      --   "<c-.>",
      --   function()
      --     require("sidekick.cli").focus()
      --   end,
      --   mode = { "n", "x", "i", "t" },
      --   desc = "Sidekick Switch Focus",
      -- },
      -- {
      --   "<leader>Aa",
      --   function()
      --     require("sidekick.cli").toggle({ focus = true })
      --   end,
      --   desc = "Sidekick Toggle CLI",
      --   mode = { "n", "v" },
      -- },
      -- {
      --   "<leader>Ac",
      --   function()
      --     require("sidekick.cli").toggle({ name = "claude", focus = true })
      --   end,
      --   desc = "Sidekick Claude Toggle",
      --   mode = { "n", "v" },
      -- },
      -- {
      --   "<leader>Ag",
      --   function()
      --     require("sidekick.cli").toggle({ name = "grok", focus = true })
      --   end,
      --   desc = "Sidekick Grok Toggle",
      --   mode = { "n", "v" },
      -- },
      -- {
      --   "<leader>Ap",
      --   function()
      --     require("sidekick.cli").select_prompt()
      --   end,
      --   desc = "Sidekick Ask Prompt",
      --   mode = { "n", "v" },
      -- },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        function()
          return " "
        end,
        color = function()
          local status = require("sidekick.status").get()
          if status then
            return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
          end
        end,
        cond = function()
          local status = require("sidekick.status")
          return status.get() ~= nil
        end,
      })
    end,
  },
}
