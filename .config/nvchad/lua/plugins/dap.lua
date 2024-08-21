return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          php = function(config)
            config.configurations = {
              {
                type = "php",
                request = "launch",
                name = "Listen for XDebug",
                port = 9003,
                log = true,
                pathMappings = {
                  ["/var/www/html/"] = vim.fn.getcwd() .. "/",
                },
                hostname = "0.0.0.0",
              },
            }

            require("mason-nvim-dap").default_setup(config) -- don't forget this!
          end,
        },

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "php",
          "delve"
        },
      }
    end,
  },
}
