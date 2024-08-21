local module = {}
local wezterm = require("wezterm")

function module.apply_to_config(config)
  config.leader = {
    key = 'f',
    mods = 'CTRL'
  }
	config.keys = {
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
    {
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
	}
end

return module
