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

    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
    picker = {
      name = "snacks.pick",
    },

    -- Daily notes configuration
    daily_notes = {
      folder = "01-daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily-template.md",
    },

    -- Note completion and creation
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    new_notes_location = "00-inbox",

    -- Note ID generation (timestamp-based for Zettelkasten)
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        suffix = "untitled"
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Note frontmatter
    note_frontmatter_func = function(note)
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

    -- Templates
    templates = {
      subdir = "templates",
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

    -- Attachments
    attachments = {
      img_folder = "attachments",
    },

    -- Wiki links and markdown links
    preferred_link_style = "wiki",

    -- UI customization - disable to prevent conflicts with render-markdown.nvim
    ui = {
      enable = false,
    },
    -- ui = {
    --   enable = true, -- set to false to disable all additional syntax features
    --   ignore_conceal_warn = false, -- set to true to disable conceallevel specific warning
    --   update_debounce = 200, -- update delay after a text change (in milliseconds)
    --   max_file_length = 5000, -- disable UI features for files with more than this many lines
    --   -- Define how various check-boxes are displayed
    --
    --   checkboxes = {
    --     -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
    --     [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
    --     ["x"] = { char = "", hl_group = "ObsidianDone" },
    --     [">"] = { char = "", hl_group = "ObsidianRightArrow" },
    --     ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
    --     ["!"] = { char = "", hl_group = "ObsidianImportant" },
    --   },
    --   -- Use bullet marks for non-checkbox lists.
    --   bullets = { char = "•", hl_group = "ObsidianBullet" },
    --   external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    --   -- Replace the above with this if you don't have a patched font:
    --   -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    --   reference_text = { hl_group = "ObsidianRefText" },
    --   highlight_text = { hl_group = "ObsidianHighlightText" },
    --   tags = { hl_group = "ObsidianTag" },
    --   block_ids = { hl_group = "ObsidianBlockID" },
    --   hl_groups = {
    --     -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
    --     ObsidianTodo = { bold = true, fg = "#f78c6c" },
    --     ObsidianDone = { bold = true, fg = "#89ddff" },
    --     ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
    --     ObsidianTilde = { bold = true, fg = "#ff5370" },
    --     ObsidianImportant = { bold = true, fg = "#d73128" },
    --     ObsidianBullet = { bold = true, fg = "#89ddff" },
    --     ObsidianRefText = { underline = true, fg = "#c792ea" },
    --     ObsidianExtLinkIcon = { fg = "#c792ea" },
    --     ObsidianTag = { italic = true, fg = "#89ddff" },
    --     ObsidianBlockID = { italic = true, fg = "#89ddff" },
    --     ObsidianHighlightText = { bg = "#75662e" },
    --   },
    -- },
  },

  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note" },
    { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes" },
    { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch notes" },
    { "<leader>od", "<cmd>ObsidianDailies<cr>", desc = "Daily notes" },
    { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Show links" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
    { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
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
