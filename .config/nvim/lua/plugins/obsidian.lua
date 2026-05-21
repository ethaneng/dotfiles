return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  priority = 1000,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = "~/Obsidian/ethan-mac/",
      },
    },

    picker = {
      name = "snacks.pick",
    },

    completion = {
      blink = true,
      min_chars = 2,
    },

    daily_notes = {
      folder = "01-daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily-template.md",
    },

    new_notes_location = "00-inbox",
    legacy_commands = false,

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        suffix = "untitled"
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    frontmatter = {
      func = function(note)
        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          created = os.date("%Y-%m-%d %H:%M"),
          modified = os.date("%Y-%m-%d %H:%M"),
        }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
        tomorrow = function()
          return os.date("%Y-%m-%d", os.time() + 86400)
        end,
      },
    },

    attachments = {
      folder = "attachments",
    },

    link = {
      style = "wiki",
    },

    -- Disabled to defer rendering to render-markdown.nvim
    ui = { enable = false },
  },

  keys = {
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Obsidian note" },
    { "<leader>oo", "<cmd>Obsidian search<cr>", desc = "Search Obsidian notes" },
    { "<leader>os", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch notes" },
    { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Daily notes" },
    { "<leader>ot", "<cmd>Obsidian template<cr>", desc = "Insert template" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show backlinks" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Show links" },
    { "<leader>of", "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
    { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste image" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
    {
      "<leader>ch",
      function()
        return require("obsidian").util.toggle_checkbox()
      end,
      desc = "Toggle checkbox",
      buffer = true,
    },
    {
      "gf",
      function()
        return require("obsidian").util.gf_passthrough()
      end,
      desc = "Follow link",
      buffer = true,
      expr = true,
    },
  },
}
