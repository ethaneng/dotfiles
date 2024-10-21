local module = {}
local wezterm = require("wezterm")

function module.apply_to_config(config)
	config.color_scheme = "Tokyo Night"

	config.color_schemes = {
		["Bearded Arc"] = require("themes/bearded-arc"),
	}

	config.initial_cols = 120
	config.initial_rows = 30
	config.font = wezterm.font("JetBrains Mono")
	config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
	config.window_padding = {
		left = "5pt",
		right = "5pt",
		top = "30pt",
		bottom = "5pt",
	}
	config.window_frame = {
		border_left_width = "2pt",
		border_right_width = "2pt",
		border_top_height = "2pt",
		border_bottom_height = "2pt",

		border_left_color = "#3c4473",
		border_right_color = "#3c4473",
		border_bottom_color = "#3c4473",
		border_top_color = "#3c4473",
	}
	config.tab_bar_at_bottom = true
	-- config.colors = {
	-- 	background = "#101010",
	-- 	tab_bar = {
	-- 		background = "#1c2433",
	-- 	},
	-- }

	config.window_background_opacity = 1
	config.macos_window_background_blur = 10
	-- config.background = {
	-- 	{
	-- 		source = { File = "/users/ethan/.config/wezterm/vibrant-swirls.jpg" },
	-- 		attachment = "Fixed",
	-- 		opacity = 1,
	-- 		hsb = { brightness = 0.1 },
	-- 	},
	-- }
end

return module
