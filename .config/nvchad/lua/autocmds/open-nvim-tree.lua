vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local nvtree = require('nvim-tree.api')
    nvtree.tree.open()
  end
})
