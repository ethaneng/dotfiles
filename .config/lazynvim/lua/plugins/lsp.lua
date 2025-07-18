return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      tailwindcss = {
        -- exclude a filetype from the default_config
        filetypes_exclude = { "markdown" },
        -- add additional filetypes to the default_config
        filetypes_include = {},
        -- to fully override the default_config, change the below
        -- filetypes = {}
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "([a-zA-Z0-9\\-:]+)" },
                { "\\b\\w+(?:ClassName|ClassNames)\\s*=\\s*", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      },
    },
    setup = {
      tailwindcss = function(_, opts)
        local tw = LazyVim.lsp.get_raw_config("tailwindcss")
        opts.filetypes = opts.filetypes or {}
        -- Add default filetypes
        vim.list_extend(opts.filetypes, tw.default_config.filetypes)
        -- Remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)
        -- Additional settings for Phoenix projects
        opts.settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
          },
        }
        -- Add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
    },
  },
}
