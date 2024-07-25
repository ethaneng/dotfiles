-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.98
config.macos_window_background_blur = 40
-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font("JetBrains Mono")
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "5pt",
	right = "5pt",
	top = "5pt",
	bottom = "5pt",
}
-- config.hide_tab_bar_if_only_one_tab = true
-- config.show_tab_index_in_tab_bar = true
-- config.use_fancy_tab_bar = false
-- config.default_cursor_style = "BlinkingBlock"
config.enable_tab_bar = false

-- Smart splits, re-enable if not using tmux
-- local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- smart_splits.apply_to_config(config, {
-- 	-- the default config is here, if you'd like to use the default keys,
-- 	-- you can omit this configuration table parameter and just use
-- 	-- smart_splits.apply_to_config(config)
--
-- 	-- directional keys to use in order of: left, down, up, right
-- 	direction_keys = { "h", "j", "k", "l" },
-- 	-- modifier keys to combine with direction_keys
-- 	modifiers = {
-- 		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
-- 		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
-- 	},
-- })

-- Keymaps
config.keys = {
	-- Disable tab keybinds
	{ key = "t", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
	{ key = "w", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
}

-- and finally, return the configuration to wezterm
return config
