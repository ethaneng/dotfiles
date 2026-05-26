export const GrepAlternativesPlugin = async () => {
  const shellQuote = (value) => `'${value.replace(/'/g, `'"'"'`)}'`

  const isRawGrepCommand = (command) => {
    return /(^|[\s|&;()])(?:\/usr\/bin\/)?grep(?=[\s-]|$)/.test(command)
  }

  const notice = [
    "OpenCode note: raw grep detected.",
    "- Prefer ripgrep (`rg`) for general text search.",
    "- Consider ast-grep for AST-aware queries.",
    "- Consider semgrep for semantic or rule-based matching.",
  ].join("\n")

  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash") return

      const command = output.args?.command
      if (typeof command !== "string" || !isRawGrepCommand(command)) return

      output.args.command = `printf '%s\n' ${shellQuote(notice)} >&2; ${command}`
    },
  }
}
