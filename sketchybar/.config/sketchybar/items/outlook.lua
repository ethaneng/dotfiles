local settings = require("settings")
local colors = require("colors")
local icons = require("icons")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local outlook = sbar.add("item", "outlook", {
	icon = {
		color = colors.with_alpha(colors.white, 0.8),
		padding_left = 8,
		font = {
			style = settings.font.style_map["Regular"],
			size = 12.0,
		},
		string = icons.calendar .. " ",
	},
	label = {
		color = colors.with_alpha(colors.white, 0.8),
		padding_right = 8,
		font = {
			style = settings.font.style_map["Regular"],
			size = 12.0,
		},
		string = "Loading...",
	},
	position = "right",
	update_freq = 300, -- Update every 5 minutes (300 seconds)
	padding_left = 1,
	padding_right = 1,
	click_script = "open -a 'Microsoft Outlook'",
})

-- Double border for outlook using a single item bracket
sbar.add("bracket", { outlook.name }, {
	background = {
		color = colors.bg2,
		border_width = 2,
		border_color = colors.bg1,
	},
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local function format_time(time_str)
	-- Convert "10:00:00 AM" to "10:00 AM"
	return time_str:gsub(":00 ", " ")
end

local function update_outlook_event()
	sbar.exec("~/.config/sketchybar/helpers/outlook_next_event.sh", function(result)
		if type(result) == "table" and result.title then
			local title = result.title
			local time_until = result["until"]  -- 'until' is a reserved keyword, must use bracket notation
			local start_time = result.start and format_time(result.start) or ""

			-- Truncate title if too long
			if #title > 30 then
				title = title:sub(1, 30) .. "…"
			end

			local display_text = ""
			if result.title == "No upcoming events" then
				display_text = "No events"
				outlook:set({
					icon = { string = icons.calendar .. " " },
					label = { string = display_text, color = colors.with_alpha(colors.grey, 0.6) },
				})
			else
				-- Format: "Event Title - in 2h" or "Event Title - 10:00 AM"
				if time_until and time_until ~= "" then
					display_text = title .. " - in " .. time_until
				else
					display_text = title .. " - " .. start_time
				end

				outlook:set({
					icon = { string = icons.calendar .. " " },
					label = { string = display_text, color = colors.with_alpha(colors.white, 0.8) },
				})
			end
		else
			outlook:set({
				icon = { string = icons.calendar .. " " },
				label = { string = "Error loading", color = colors.red },
			})
		end
	end)
end

-- Update on startup
update_outlook_event()

-- Subscribe to events
outlook:subscribe({ "forced", "routine", "system_woke" }, function(env)
	update_outlook_event()
end)

-- Also update when clicked
outlook:subscribe("mouse.clicked", function(env)
	update_outlook_event()
	sbar.exec("open -a 'Microsoft Outlook'")
end)
