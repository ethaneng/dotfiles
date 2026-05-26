local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local root = sbar.add("item", { drawing = false })

sbar.add("event", "omniwm_workspace_change")
sbar.add("event", "omniwm_display_change")

local displays = {}
local workspace_items = {}
local workspace_state = {}
local last_order_key = ""

local function payload_of(response, expected_kind)
	if type(response) ~= "table" then
		return nil
	end

	local result = response.result
	if type(result) ~= "table" then
		return nil
	end

	if expected_kind and result.kind ~= expected_kind then
		return nil
	end

	return result.payload
end

local function shquote(value)
	return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function sanitize_name(value)
	return tostring(value):gsub("[^%w_%-]", "_")
end

local function workspace_item_name(display_id, workspace_name)
	return "omniwm." .. sanitize_name(display_id) .. "." .. sanitize_name(workspace_name)
end

local function workspace_display_string(workspace)
	local raw_name = workspace.rawName or ""
	local display_name = workspace.displayName or raw_name
	local number = workspace.number

	if display_name ~= "" and display_name ~= raw_name then
		if number then
			return tostring(number) .. " " .. display_name
		end
		return display_name
	end

	if number then
		return tostring(number)
	end

	local project_number = raw_name:match("^p(%d+)$")
	if project_number then
		return project_number
	end

	if raw_name:match("^[a-z]$") then
		return raw_name:upper()
	end

	return raw_name
end

local function workspace_windows_string(workspace)
	local windows = workspace.windows or {}
	if #windows == 0 then
		return " -"
	end

	local parts = {}
	for _, window in ipairs(windows) do
		local icon = app_icons[window.appName] or app_icons["Default"]
		table.insert(parts, icon)
	end

	return " " .. table.concat(parts, " ")
end

local function sync_displays(display_payload)
	displays = {}
	for index, display in ipairs(display_payload.displays or {}) do
		if display.id then
			displays[display.id] = {
				index = index,
			}
		end
	end
end

local function remove_workspace_item(display_id, workspace_name)
	local items = workspace_items[display_id]
	if not items or not items[workspace_name] then
		return
	end

	sbar.remove(items[workspace_name])
	items[workspace_name] = nil
	workspace_state[display_id] = workspace_state[display_id] or {}
	workspace_state[display_id][workspace_name] = nil

	if next(items) == nil then
		workspace_items[display_id] = nil
	end

	if workspace_state[display_id] and next(workspace_state[display_id]) == nil then
		workspace_state[display_id] = nil
	end
end

local function ensure_workspace_item(display_id, workspace, display_index)
	local workspace_name = workspace.rawName or ""
	if workspace_name == "" then
		return nil
	end

	workspace_items[display_id] = workspace_items[display_id] or {}
	local item = workspace_items[display_id][workspace_name]
	if item then
		return item
	end

	item = sbar.add("item", workspace_item_name(display_id, workspace_name), {
		position = "left",
		display = display_index,
		background = {
			color = colors.bg1,
			drawing = true,
		},
		click_script = "omniwmctl workspace focus-name " .. shquote(workspace_name),
		icon = {
			color = colors.with_alpha(colors.white, 0.3),
			drawing = true,
			font = { family = settings.font.numbers },
			highlight_color = colors.white,
			padding_left = 8,
			padding_right = 4,
		},
		label = {
			color = colors.with_alpha(colors.white, 0.3),
			drawing = true,
			font = "sketchybar-app-font:Regular:16.0",
			highlight_color = colors.white,
			padding_left = 2,
			padding_right = 10,
			y_offset = -1,
		},
	})

	workspace_items[display_id][workspace_name] = item
	return item
end

local function reorder_workspace_items(names)
	if #names == 0 then
		last_order_key = ""
		return
	end

	local order_key = table.concat(names, "|")
	if order_key == last_order_key then
		return
	end
	last_order_key = order_key

	local commands = {
		"sketchybar --move " .. shquote(names[1]) .. " before front_app",
	}

	for index = 2, #names do
		table.insert(commands, "sketchybar --move " .. shquote(names[index]) .. " after " .. shquote(names[index - 1]))
	end

	table.insert(commands, "sketchybar --move front_app after " .. shquote(names[#names]))
	sbar.exec(table.concat(commands, " && ") .. " 2>/dev/null")
end

local function set_workspace_item_if_changed(display_id, workspace_name, item, next_state)
	workspace_state[display_id] = workspace_state[display_id] or {}
	local current_state = workspace_state[display_id][workspace_name]

	if current_state
		and current_state.display == next_state.display
		and current_state.icon_string == next_state.icon_string
		and current_state.icon_highlight == next_state.icon_highlight
		and current_state.label_string == next_state.label_string
		and current_state.label_highlight == next_state.label_highlight
	then
		return
	end

	workspace_state[display_id][workspace_name] = next_state
	item:set({
		display = next_state.display,
		icon = {
			string = next_state.icon_string,
			highlight = next_state.icon_highlight,
		},
		label = {
			string = next_state.label_string,
			highlight = next_state.label_highlight,
		},
	})
end

local function update_workspace_bar(bar_payload)
	local ordered_names = {}
	local seen_displays = {}

	for fallback_index, monitor in ipairs(bar_payload.monitors or {}) do
		local display_id = monitor.id
		if display_id then
			seen_displays[display_id] = true
			local display_index = (displays[display_id] and displays[display_id].index) or fallback_index
			local seen_workspaces = {}

			for _, workspace in ipairs(monitor.workspaces or {}) do
				local workspace_name = workspace.rawName or ""
				if workspace_name ~= "" then
					seen_workspaces[workspace_name] = true
					local item = ensure_workspace_item(display_id, workspace, display_index)
					if item then
						set_workspace_item_if_changed(display_id, workspace_name, item, {
							display = display_index,
							icon_string = workspace_display_string(workspace),
							icon_highlight = workspace.isFocused,
							label_string = workspace_windows_string(workspace),
							label_highlight = workspace.isFocused,
						})
						table.insert(ordered_names, item.name)
					end
				end
			end

			for workspace_name, _ in pairs(workspace_items[display_id] or {}) do
				if not seen_workspaces[workspace_name] then
					remove_workspace_item(display_id, workspace_name)
				end
			end
		end
	end

	for display_id, items in pairs(workspace_items) do
		if not seen_displays[display_id] then
			for workspace_name, _ in pairs(items) do
				remove_workspace_item(display_id, workspace_name)
			end
		end
	end

	reorder_workspace_items(ordered_names)
end

local function refresh_workspace_bar()
	sbar.exec("omniwmctl query workspace-bar --format json 2>/dev/null", function(bar_result)
		local bar_payload = payload_of(bar_result, "workspace-bar")
		if type(bar_payload) ~= "table" then
			return
		end

		update_workspace_bar(bar_payload)
	end)
end

local function refresh_displays_and_workspace_bar()
	sbar.exec("omniwmctl query displays --format json 2>/dev/null", function(display_result)
		local display_payload = payload_of(display_result, "displays")
		if type(display_payload) ~= "table" then
			return
		end

		sync_displays(display_payload)
		refresh_workspace_bar()
	end)
end

os.execute(shquote(os.getenv("HOME") .. "/.config/sketchybar/helpers/omniwm_watch.sh") .. " >/dev/null 2>&1 &")

refresh_displays_and_workspace_bar()

root:subscribe("omniwm_workspace_change", refresh_workspace_bar)
root:subscribe("omniwm_display_change", refresh_displays_and_workspace_bar)
root:subscribe("display_change", refresh_displays_and_workspace_bar)
