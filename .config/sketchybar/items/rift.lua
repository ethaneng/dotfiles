local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Root item for global event subscriptions
local root = sbar.add("item", { drawing = false })

-- Per-display workspace items: display_workspaces[screen_id][ws_name] = sbar_item
local display_workspaces = {}
-- Cached display info: displays[screen_id] = { space = ..., uuid = ..., name = ..., sbar_display = ... }
local displays = {}

-- Workspace definitions (matching rift config, 0-based indices)
local project_workspaces = { "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10" }
local fixed_workspaces = { "y", "u", "i", "o", "p" }

local workspace_to_index = {}
for i, ws in ipairs(project_workspaces) do
	workspace_to_index[ws] = i - 1
end
for i, ws in ipairs(fixed_workspaces) do
	workspace_to_index[ws] = 9 + i
end

local workspace_order = {}
for _, ws in ipairs(project_workspaces) do
	table.insert(workspace_order, ws)
end
for _, ws in ipairs(fixed_workspaces) do
	table.insert(workspace_order, ws)
end

local fullscreened_icon = "󰊓 "

local function is_project_workspace(label)
	return label:match("^p%d+$") ~= nil
end

local function is_fixed_workspace(label)
	for _, ws in ipairs(fixed_workspaces) do
		if ws == label then
			return true
		end
	end
	return false
end

local function get_project_number(label)
	return label:match("^p(%d+)$")
end

local function get_workspace_display(label)
	if is_project_workspace(label) then
		return get_project_number(label)
	else
		return label:upper()
	end
end

-- Create workspace items for a specific display
local function createDisplayWorkspaces(screen_id)
	if display_workspaces[screen_id] then
		return
	end
	display_workspaces[screen_id] = {}

	-- Use sketchybar display index (1-based position) instead of raw screen_id
	local sbar_display = displays[screen_id] and displays[screen_id].sbar_display or screen_id

	for _, ws_name in ipairs(workspace_order) do
		local rift_index = workspace_to_index[ws_name]

		local item = sbar.add("item", {
			display = sbar_display,
			drawing = is_fixed_workspace(ws_name),
			background = {
				color = colors.bg1,
				drawing = true,
			},
			click_script = "rift-cli execute workspace switch " .. rift_index,
			icon = {
				color = colors.with_alpha(colors.white, 0.3),
				drawing = true,
				font = { family = settings.font.numbers },
				highlight_color = colors.white,
				padding_left = 5,
				padding_right = 4,
				string = get_workspace_display(ws_name),
			},
			label = {
				color = colors.with_alpha(colors.white, 0.3),
				drawing = true,
				font = "sketchybar-app-font:Regular:16.0",
				highlight_color = colors.white,
				padding_left = 2,
				padding_right = 12,
				y_offset = -1,
			},
		})

		display_workspaces[screen_id][ws_name] = item
	end
end

-- Remove workspace items for a display that's no longer connected
local function removeDisplayWorkspaces(screen_id)
	if not display_workspaces[screen_id] then
		return
	end
	for _, item in pairs(display_workspaces[screen_id]) do
		sbar.remove(item)
	end
	display_workspaces[screen_id] = nil
end

-- Update workspace items for a single display using its space-specific data
local function updateDisplayFromWorkspaces(screen_id, ws_data)
	local items = display_workspaces[screen_id]
	if not items then
		return
	end

	-- Build per-workspace state from the query data
	local open_windows = {}
	local focused_workspace = ""

	for _, ws in ipairs(ws_data) do
		local ws_name = ws.name or ""
		if ws.is_active then
			focused_workspace = ws_name
		end
		if ws.windows and #ws.windows > 0 then
			open_windows[ws_name] = {}
			for _, window in ipairs(ws.windows) do
				table.insert(open_windows[ws_name], {
					name = window.app_name or "",
					fullscreen = window.is_fullscreen or false,
				})
			end
		end
	end

	-- Update each workspace item for this display
	for ws_name, item in pairs(items) do
		local windows = open_windows[ws_name] or {}
		local has_windows = #windows > 0
		local is_focused = ws_name == focused_workspace

		local icon_line = ""
		for _, win in ipairs(windows) do
			local lookup = app_icons[win.name]
			local icon = lookup or app_icons["Default"]
			local fs = win.fullscreen and fullscreened_icon or ""
			icon_line = icon_line .. " " .. icon .. fs
		end

		local should_draw
		if is_fixed_workspace(ws_name) then
			should_draw = true
		else
			should_draw = has_windows or is_focused
		end

		if not has_windows then
			icon_line = " —"
		end

		sbar.animate("tanh", 10, function()
			item:set({
				drawing = should_draw,
				icon = {
					string = get_workspace_display(ws_name),
					highlight = is_focused,
				},
				label = {
					string = icon_line,
					highlight = is_focused,
				},
			})
		end)
	end
end

-- Refresh display list and sync workspace items
local function refreshDisplays(callback)
	sbar.exec("rift-cli query displays 2>/dev/null", function(display_json)
		if type(display_json) ~= "table" then
			return
		end

		local current_screen_ids = {}
		for i, d in ipairs(display_json) do
			local sid = d.screen_id
			current_screen_ids[sid] = true
			displays[sid] = {
				space = d.space,
				uuid = d.uuid,
				name = d.name,
				sbar_display = i, -- 1-based index matching sketchybar's display numbering
			}
			createDisplayWorkspaces(sid)
		end

		-- Remove items for disconnected displays
		for sid, _ in pairs(display_workspaces) do
			if not current_screen_ids[sid] then
				removeDisplayWorkspaces(sid)
				displays[sid] = nil
			end
		end

		if callback then
			callback()
		end
	end)
end

-- Update all displays by querying workspaces per space
local function updateAllDisplays()
	-- Query each display's space for its workspace state
	for screen_id, info in pairs(displays) do
		local space_id = info.space
		sbar.exec(
			"rift-cli query workspaces --space-id " .. space_id .. " 2>/dev/null",
			function(ws_json)
				if type(ws_json) == "table" then
					updateDisplayFromWorkspaces(screen_id, ws_json)
				end
			end
		)
	end
end

-- Full refresh: re-query displays then update workspaces
local function fullRefresh()
	refreshDisplays(function()
		updateAllDisplays()
	end)
end

-- Initial setup
fullRefresh()

-- Event subscriptions
root:subscribe("rift_workspace_changed", function()
	updateAllDisplays()
end)

root:subscribe("rift_windows_changed", function()
	updateAllDisplays()
end)

root:subscribe("front_app_switched", function()
	updateAllDisplays()
end)

-- Display change (monitor connected/disconnected) requires full rebuild
root:subscribe("display_change", function()
	-- Remove all existing workspace items so they get recreated with correct display indices
	for sid, _ in pairs(display_workspaces) do
		removeDisplayWorkspaces(sid)
	end
	displays = {}
	fullRefresh()
end)
