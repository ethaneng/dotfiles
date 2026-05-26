local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Root is used to handle event subscriptions
local root = sbar.add("item", { drawing = false })
local workspaces = {}

-- Define workspace types
local project_workspaces = { "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10" }
local fixed_workspaces = { "y", "u", "i", "o", "p" }

-- Combined order for iteration (project first, then fixed)
local workspace_order = {}
for _, ws in ipairs(project_workspaces) do
	table.insert(workspace_order, ws)
end
for _, ws in ipairs(fixed_workspaces) do
	table.insert(workspace_order, ws)
end

local fullscreened_icon = "󰊓 "

-- Workspace type detection
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

-- Get project number from label (p1 -> 1, p10 -> 10)
local function get_project_number(label)
	return label:match("^p(%d+)$")
end

-- Read workspace names from JSON file
local function read_workspace_names()
	local names = {}
	local file = io.open(os.getenv("HOME") .. "/.config/yabai/workspace_names.json", "r")
	if file then
		local content = file:read("*a")
		file:close()
		-- Parse JSON (simple implementation for flat object)
		for key, value in content:gmatch('"(p%d+)"%s*:%s*"([^"]*)"') do
			names[key] = value
		end
	end
	return names
end

-- Generate display string for workspace icon
local function get_workspace_display(label)
	if is_project_workspace(label) then
		local num = get_project_number(label)
		local names = read_workspace_names()
		local custom_name = names[label] or ""
		if custom_name ~= "" then
			return num .. " " .. custom_name
		else
			return num
		end
	else
		-- Fixed workspace - just uppercase letter
		return label:upper()
	end
end

local function withWindows(f)
	local open_windows = {}

	-- Query all spaces to build workspace list
	sbar.exec("yabai -m query --spaces", function(spaces_json)
		local spaces = spaces_json

		-- Query all windows
		sbar.exec("yabai -m query --windows", function(windows_json)
			local windows = windows_json

			-- Build open_windows table organized by workspace label
			for _, window in ipairs(windows) do
				if window.app and window.space then
					-- Find the space label for this space ID
					local workspace_label = nil
					for _, space in ipairs(spaces) do
						if space.index == window.space then
							workspace_label = space.label
							break
						end
					end

					if workspace_label then
						local app = {
							name = window.app,
							fullscreen = window["has-fullscreen-zoom"] or window["is-native-fullscreen"],
						}
						if open_windows[workspace_label] == nil then
							open_windows[workspace_label] = {}
						end
						table.insert(open_windows[workspace_label], app)
					end
				end
			end

			-- Get focused space
			sbar.exec("yabai -m query --spaces --space", function(focused_space_json)
				local focused_workspace = focused_space_json.label or ""

				-- Get visible workspaces (one per display)
				local visible_workspaces = {}
				for _, space in ipairs(spaces) do
					if space["is-visible"] then
						table.insert(visible_workspaces, {
							workspace = space.label,
							display = space.display,
						})
					end
				end

				local args = {
					open_windows = open_windows,
					focused_workspaces = focused_workspace,
					visible_workspaces = visible_workspaces,
				}
				f(args)
			end)
		end)
	end)
end

local function updateWindow(workspace_index, args)
	local open_windows = args.open_windows[workspace_index]
	local focused_workspaces = args.focused_workspaces
	local visible_workspaces = args.visible_workspaces

	if open_windows == nil then
		open_windows = {}
	end

	local icon_line = ""
	local has_windows = #open_windows > 0

	for i, open_window in ipairs(open_windows) do
		local app = open_window.name
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)
		local fullscreen_icon = open_window.fullscreen and fullscreened_icon or ""
		icon_line = icon_line .. " " .. icon .. fullscreen_icon
	end

	local is_focused = workspace_index == focused_workspaces
	local is_visible = false
	for _, v in ipairs(visible_workspaces) do
		if v.workspace == workspace_index then
			is_visible = true
			break
		end
	end

	-- Visibility rules:
	-- Fixed workspaces: ALWAYS visible
	-- Project workspaces: Only visible if has windows OR is focused OR is visible on a display
	local should_draw = false
	if is_fixed_workspace(workspace_index) then
		should_draw = true -- Always show fixed workspaces
	else
		should_draw = has_windows or is_focused or is_visible
	end

	if not has_windows then
		icon_line = " —"
	end

	sbar.animate("tanh", 10, function()
		workspaces[workspace_index]:set({
			drawing = should_draw,
			icon = {
				string = get_workspace_display(workspace_index),
				highlight = is_focused,
			},
			label = {
				string = icon_line,
				highlight = is_focused,
			},
		})
	end)
end

local function updateWindows()
	withWindows(function(args)
		for workspace_index, _ in pairs(workspaces) do
			updateWindow(workspace_index, args)
		end
	end)
end

local function updateWorkspaceMonitor()
	local workspace_monitor = {}
	sbar.exec("yabai -m query --spaces", function(spaces)
		for _, space in ipairs(spaces) do
			if space.label then
				workspace_monitor[space.label] = space.display
			end
		end
		for workspace_index, _ in pairs(workspaces) do
			workspaces[workspace_index]:set({
				display = workspace_monitor[workspace_index],
			})
		end
	end)
end

-- Create workspaces in the specified order (project first, then fixed)
for _, workspace_index in ipairs(workspace_order) do
	local initial_drawing = is_fixed_workspace(workspace_index) -- Fixed always visible initially

	local workspace = sbar.add("item", {
		background = {
			color = colors.bg1,
			drawing = true,
		},
		click_script = "yabai -m space --focus " .. workspace_index,
		drawing = initial_drawing,
		icon = {
			color = colors.with_alpha(colors.white, 0.3),
			drawing = true,
			font = { family = settings.font.numbers },
			highlight_color = colors.white,
			padding_left = 5,
			padding_right = 4,
			string = get_workspace_display(workspace_index),
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

	workspaces[workspace_index] = workspace

	workspace:subscribe("yabai_space_change", function(env)
		local focused_workspace = env.FOCUSED_WORKSPACE
		local is_focused = focused_workspace == workspace_index

		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = is_focused },
				label = { highlight = is_focused },
				blur_radius = 30,
			})
		end)
	end)
end

-- Initial setup and event subscriptions
sbar.exec("yabai -m query --spaces", function(spaces)
	updateWindows()
	updateWorkspaceMonitor()

	-- Subscribe to yabai space change events
	root:subscribe("yabai_space_change", function()
		updateWindows()
	end)

	-- Subscribe to yabai focus change
	root:subscribe("yabai_focus_change", function()
		updateWindows()
	end)

	-- Subscribe to yabai window change events
	root:subscribe("yabai_window_change", function()
		updateWindows()
	end)

	-- Subscribe to front app changes
	root:subscribe("front_app_switched", function()
		updateWindows()
	end)

	root:subscribe("display_change", function()
		updateWorkspaceMonitor()
		updateWindows()
	end)

	root:subscribe("yabai_fullscreen_change", function()
		updateWindows()
	end)

	-- Set initial focused workspace
	sbar.exec("yabai -m query --spaces --space", function(focused_space)
		if focused_space.label then
			local focused_workspace = focused_space.label
			if workspaces[focused_workspace] then
				workspaces[focused_workspace]:set({
					icon = { highlight = true },
					label = { highlight = true },
				})
			end
		end
	end)
end)
