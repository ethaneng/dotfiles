-- Pull in the wezter  API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Tab Bar
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.use_fancy_tab_bar = false
config.enable_tab_bar = true

-- Custom Modules
require('modules/appearance').apply_to_config(config)
require('modules/smart-splits').apply_to_config(config)
require('modules/mappings').apply_to_config(config)
require('modules/zen-mode').apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
