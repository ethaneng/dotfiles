local util = require("lspconfig.util")
return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      vtsls = {
        settings = {
          inlayHints = {
            parameterTypes = { enabled = false },
            propertyDeclarationTypes = { enabled = false },
            variableTypes = { enabled = false },
          },
        },
      },
    },
    volar = {
      filetypes = {
        "typescript",
        "vue",
      },
      root_dir = util.root_pattern("src/App.vue"),
    },
  },
}
