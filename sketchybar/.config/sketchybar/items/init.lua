require("items.apple")
require("items.calendar")
require("items.outlook")
-- require("items.messages")
-- require("items.widgets")

-- Auto-detect window manager and load appropriate workspace widget
-- Priority: omniwm > rift > yabai > aerospace
local function detect_wm()
	local checks = {
		{ name = "omniwm", cmd = "pgrep -x OmniWM" },
		{ name = "rift", cmd = "pgrep -x rift" },
		{ name = "yabai", cmd = "pgrep -x yabai" },
	}
	for _, check in ipairs(checks) do
		local handle = io.popen(check.cmd .. " > /dev/null 2>&1 && echo 'found' || echo ''")
		local result = handle:read("*a"):gsub("%s+", "")
		handle:close()
		if result == "found" then
			return check.name
		end
	end
	return "aerospace"
end

local wm = detect_wm()

if wm == "omniwm" then
	require("items.omniwm")
elseif wm == "rift" then
	require("items.rift")
elseif wm == "yabai" then
	require("items.yabai")
else
	require("items.aerospace")
end

require("items.front_app")
-- require("items.front_apps")
require("items.media")
require("items.menus")
