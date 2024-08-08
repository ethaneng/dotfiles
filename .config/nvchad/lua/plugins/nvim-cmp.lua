return {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require "cmp"
    local opts = require "nvchad.configs.cmp"
    table.insert(opts.sources, { name = "supermaven" })
    table.insert(opts.sources, { name = "phpactor" })
    table.insert(opts.sources, {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    })

    custom_map = {
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<CR>"] = cmp.mapping.confirm(),
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping, custom_map)

    cmp.setup(opts)
  end,
}
