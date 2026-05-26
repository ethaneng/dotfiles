-- Load individual LSP server configurations
local function load_lsp_config(server_name)
  local ok, config = pcall(require, "plugins.lspconfigs." .. server_name)
  if not ok then
    vim.notify("Failed to load LSP config for " .. server_name .. ": " .. config, vim.log.levels.WARN)
    return {}
  end
  return config
end

-- Build servers table by loading individual configs
local servers = {}
local setup_functions = {}

-- Load yamlls config
local yamlls_config = load_lsp_config("yamlls")
if yamlls_config then
  servers.yamlls = yamlls_config
end

-- Load tailwindcss config
local tailwindcss_config = load_lsp_config("tailwindcss")
if tailwindcss_config then
  servers.tailwindcss = tailwindcss_config.server_config or {}
  if tailwindcss_config.setup_function then
    setup_functions.tailwindcss = tailwindcss_config.setup_function
  end
end

-- Load marksman config
local marksman_config = load_lsp_config("marksman")
if marksman_config then
  servers.marksman = marksman_config
end

return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = servers,
      setup = setup_functions,
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "cfn_lint" },
        json = { "cfn_lint" },
      },
    },
  },
}
