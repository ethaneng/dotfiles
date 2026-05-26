return {
  server_config = {
    filetypes_exclude = { "markdown" },
    filetypes_include = {},
    settings = {
      tailwindCSS = {
        includeLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          heex = "html-eex",
        },
        classFunctions = { "tw", "cva", "twMerge", "clsx", "cn", "tw\\.[a-z-]+" },
        experimental = {
          classRegex = {
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "([a-zA-Z0-9\\-:]+)" },
            { "\\b\\w+(?:ClassName|ClassNames)\\s*=\\s*", "[\"'`]([^\"'`]*).*?[\"'`]" },
          },
        },
        autocomplete = {
          className = true,
          classNames = true,
        },
      },
    },
  },
  setup_function = function(_, opts)
    local default_filetypes = {
      "astro",
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    }

    opts.filetypes = opts.filetypes or {}
    vim.list_extend(opts.filetypes, default_filetypes)

    opts.filetypes = vim.tbl_filter(function(ft)
      return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
    end, opts.filetypes)

    vim.list_extend(opts.filetypes, opts.filetypes_include or {})
  end,
}
