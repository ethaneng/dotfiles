-- Marksman (Markdown LSP) configuration
return {
  -- Disable diagnostics for common Obsidian/Zettelkasten patterns
  settings = {
    marksman = {
      -- Disable specific diagnostic rules that interfere with Obsidian
      diagnostics = {
        -- Disable "undefined reference" warnings for wiki links
        ["undefined-reference"] = "ignore",
        -- Disable "unused reference" warnings  
        ["unused-reference"] = "ignore",
        -- Allow missing link targets (for cross-vault links)
        ["missing-link-target"] = "ignore",
      },
    },
  },
  -- Additional file types to include
  filetypes = { "markdown", "markdown.mdx" },
  -- Root directory patterns (add .obsidian for Obsidian vaults)
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern(".obsidian", ".git", ".marksman.toml")(fname)
      or util.find_git_ancestor(fname)
      or util.path.dirname(fname)
  end,
}