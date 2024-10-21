local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local function updateWin()
    local winConf = vim.api.nvim_win_get_config(0)
    winConf.title = vim.fn.getcwd()
    vim.api.nvim_win_set_config(0, winConf)
  end

  local function cdDown()
    api.tree.change_root_to_node()
    updateWin()
  end

  local function cdUp()
    api.tree.change_root_to_parent()
    updateWin()
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", ".", cdDown, opts "Change Root")
  vim.keymap.set("n", "-", cdUp, opts "Change Root")
  vim.keymap.set("n", "s", api.node.open.vertical, opts "Open file in vertical split")
  vim.keymap.set("n", "S", api.node.open.horizontal, opts "Open file in horizontal split")
  vim.keymap.set("n", "/", api.tree.search_node, opts "Search nodes")
end

return {
  "nvim-tree/nvim-tree.lua",
  opts = function()
    local conf = require "nvchad.configs.nvimtree"
    conf.on_attach = my_on_attach
    conf.hijack_cursor = true
    conf.disable_netrw = true
    conf.hijack_unnamed_buffer_when_opening = true
    conf.sync_root_with_cwd = true
    conf.actions.change_dir = {
      enable = true,
      global = true,
      restrict_above_cwd = false
    }
    conf.view.relativenumber = true
    conf.view.float = {
      enable = true,
      open_win_config = function()
        local screen_width = vim.api.nvim_win_get_width(0)
        local screen_height = vim.api.nvim_win_get_height(0)
        local window_width = math.floor(screen_width * 0.8)
        local window_height = math.floor(screen_height * 0.8)
        local col = math.floor((screen_width - window_width) / 2)
        local row = math.floor((screen_height - window_height) / 2)
        return {
          relative = "win",
          width = window_width,
          height = window_height,
          col = col,
          row = row,
          border = "rounded",
          title = vim.fn.getcwd(),
          title_pos = "center",
        }
      end,
    }
    return conf
  end,
}
