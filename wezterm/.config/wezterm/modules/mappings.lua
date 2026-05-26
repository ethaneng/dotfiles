local module = {}
local wezterm = require("wezterm")

function module.apply_to_config(config)
	-- Disable all default keybindings
	config.disable_default_key_bindings = true

	-- Explicit enabled bindings [DISABLED]: using tmux to manage terminals. Shouldnt need any wezterm bindings
	-- config.leader = {
	-- 	key = "w",
	-- 	mods = "ALT",
	-- }
	--
	-- table.insert(config.keys, {
	-- 	key = "-",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	-- })
	-- table.insert(config.keys, {
	-- 	key = "|",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- })
	-- table.insert(config.keys, {
	-- 	key = "x",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.CloseCurrentPane({ confirm = true }),
	-- })
end

return module
