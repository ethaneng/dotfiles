local module = {}
local w = require("wezterm")

function module.apply_to_config(config)
	local smart_splits = w.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
	smart_splits.apply_to_config(config)
	--
	-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
	local function is_vim(pane)
		-- this is set by the plugin, and unset on ExitPre in Neovim
		return pane:get_user_vars().IS_NVIM == "true"
	end

	local direction_keys = {
		h = "Left",
		j = "Down",
		k = "Up",
		l = "Right",
	}

	local function split_nav(resize_or_move, key)
		table.insert(config.keys, {
			key = key,
			mods = resize_or_move == "resize" and "META" or "CTRL",
			action = w.action_callback(function(win, pane)
				if is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
					}, pane)
				else
					if resize_or_move == "resize" then
						win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
					else
						win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
					end
				end
			end),
		})
	end

	-- move between split panes
	split_nav("move", "h")
	split_nav("move", "j")
	split_nav("move", "k")
	split_nav("move", "l")
	-- resize panes
	split_nav("resize", "h")
	split_nav("resize", "j")
	split_nav("resize", "k")
	split_nav("resize", "l")
end

return module
