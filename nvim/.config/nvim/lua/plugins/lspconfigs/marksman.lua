return {
  settings = {
    marksman = {
      diagnostics = {
        ["undefined-reference"] = "ignore",
        ["unused-reference"] = "ignore",
        ["missing-link-target"] = "ignore",
      },
    },
  },
  filetypes = { "markdown", "markdown.mdx" },
  root_dir = function(fname)
    return vim.fs.root(fname, { ".obsidian", ".marksman.toml", ".git" }) or vim.fs.dirname(fname)
  end,
}
