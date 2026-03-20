return {
  -- Have to add this for yamlls to understand that we support line folding
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  -- lazy-load schemastore when needed
  on_new_config = function(new_config)
    new_config.settings.yaml.schemas =
      vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      customTags = {
        -- CloudFormation tags
        "!Ref scalar",
        "!Ref mapping",
        "!Ref sequence",
        "!Sub scalar",
        "!Sub mapping",
        "!Sub sequence",
        "!GetAtt scalar",
        "!GetAtt mapping",
        "!GetAtt sequence",
        "!If scalar",
        "!If mapping",
        "!If sequence",
        "!Equals scalar",
        "!Equals mapping",
        "!Equals sequence",
        "!And scalar",
        "!And mapping",
        "!And sequence",
        "!Or scalar",
        "!Or mapping",
        "!Or sequence",
        "!Not scalar",
        "!Not mapping",
        "!Not sequence",
        "!FindInMap scalar",
        "!FindInMap mapping",
        "!FindInMap sequence",
        "!Base64 scalar",
        "!Base64 mapping",
        "!Base64 sequence",
        "!Cidr scalar",
        "!Cidr mapping",
        "!Cidr sequence",
        "!GetAZs scalar",
        "!GetAZs mapping",
        "!GetAZs sequence",
        "!ImportValue scalar",
        "!ImportValue mapping",
        "!ImportValue sequence",
        "!Select scalar",
        "!Select mapping",
        "!Select sequence",
        "!Split scalar",
        "!Split mapping",
        "!Split sequence",
        "!Join scalar",
        "!Join mapping",
        "!Join sequence",
        -- Kubernetes tags
        "!include scalar",
        "!include mapping",
        "!include sequence",
        -- Docker Compose tags
        "!override scalar",
        "!override mapping",
        "!override sequence",
        "!extend scalar",
        "!extend mapping",
        "!extend sequence",
        -- Ansible tags
        "!vault scalar",
        "!vault mapping",
        "!vault sequence",
        "!include_vars scalar",
        "!include_vars mapping",
        "!include_vars sequence",
        -- GitHub Actions tags
        "!fromJSON scalar",
        "!fromJSON mapping",
        "!fromJSON sequence",
        "!toJSON scalar",
        "!toJSON mapping",
        "!toJSON sequence",
        -- GitLab CI tags
        "!reference scalar",
        "!reference mapping",
        "!reference sequence",
      },
    },
  },
}