local colors = require("colors")
local settings = require("settings")

-- Events that get pushed by yabai
sbar.add("event", "window_focus")
sbar.add("event", "title_change")
sbar.add("event", "omniwm_workspace_change")

local front_app = sbar.add("item", "front_app", {
	position = "left",
	display = "active",
	padding_left = settings.group_paddings,
	scroll_texts = false,
	icon = {
		font = {
			style = settings.font.style_map["Black"],
			size = 13.0,
		},
	},
	label = {
		font = {
			style = settings.font.style_map["Black"],
			size = 13.0,
		},
		max_chars = 50,
	},
	updates = true,
})

local last_window_title = "-"

local function payload_of(result, expected_kind)
	if type(result) ~= "table" or type(result.result) ~= "table" then
		return nil
	end

	if expected_kind and result.result.kind ~= expected_kind then
		return nil
	end

	return result.result.payload
end

local function set_window_title()
	sbar.exec("omniwmctl query workspace-bar --format json 2>/dev/null", function(result)
		local payload = payload_of(result, "workspace-bar")
		if type(payload) ~= "table" then
			front_app:set({ icon = { string = "" }, label = { string = last_window_title } })
			return
		end

		for _, monitor in ipairs(payload.monitors or {}) do
			for _, workspace in ipairs(monitor.workspaces or {}) do
				for _, window in ipairs(workspace.windows or {}) do
					if window.isFocused then
						local title = window.title
						if (not title or title == "") and type(window.allWindows) == "table" then
							for _, entry in ipairs(window.allWindows) do
								if entry.isFocused and entry.title and entry.title ~= "" then
									title = entry.title
									break
								end
							end
						end

						if not title or title == "" then
							title = window.appName
						end

						if title and title ~= "" then
							last_window_title = title
						end

						front_app:set({
							icon = { string = "" },
							label = { string = last_window_title },
						})
						return
					end
				end
			end
		end

		front_app:set({ icon = { string = "" }, label = { string = last_window_title } })
	end)
end

front_app:subscribe("front_app_switched", function()
	set_window_title()
end)

front_app:subscribe("space_change", function()
	set_window_title()
end)

front_app:subscribe("window_focus", function()
	set_window_title()
end)

front_app:subscribe("title_change", function()
	set_window_title()
end)

front_app:subscribe("omniwm_workspace_change", function()
	set_window_title()
end)

set_window_title()
