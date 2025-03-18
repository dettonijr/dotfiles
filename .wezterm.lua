-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.keys = {
  { mods='', key="Home", action=wezterm.action{SendString="\001"} },
  { mods='', key="End", action=wezterm.action{SendString="\005"} },
}

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

-- and finally, return the configuration to wezterm
return config

