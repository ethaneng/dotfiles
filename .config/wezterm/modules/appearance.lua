local module = {}
local wezterm = require("wezterm")

function module.apply_to_config(config)
	-- config.color_scheme = "Tokyo Night Moon"
	-- config.color_scheme = "Catppuccin Mocha"
	config.color_scheme = "Everforest Dark (Gogh)"

	config.color_schemes = {
		["Bearded Arc"] = require("themes/bearded-arc"),
	}

	-- config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "Noto Sans Symbols", "Hack Nerd Font" })
	config.adjust_window_size_when_changing_font_size = false
	config.font_size = 14.0
	config.window_decorations = "RESIZE"
	config.window_padding = {
		left = "10pt",
		right = "10pt",
		top = "10pt",
		bottom = "10pt",
	}
	config.tab_bar_at_bottom = true

	-- config.window_background_opacity = 0.9
	config.window_background_opacity = 1
	config.macos_window_background_blur = 30
end

return module
