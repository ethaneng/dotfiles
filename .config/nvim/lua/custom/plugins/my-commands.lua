return {
  'my-commands',
  dev = true,
  config = function()
    vim.api.nvim_create_user_command('Filetree', function(opts)
      if opts.args ~= nil and opts.args ~= '' then
        vim.cmd('Neotree action=show source=filesystem position=float dir=' .. opts.args .. ' <CR>')
      else
        vim.cmd 'Neotree action=focus position=float toggle=true reveal=true <CR>'
      end
    end, { desc = 'Open NeoTree with preferred config.', nargs = '?' })
  end,
}
