local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- [[ GENERAL SETTINGS ]] --

config.color_scheme = "tokyonight_night"

-- change window decoration
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.96
config.macos_window_background_blur = 40

-- adjust startup size
config.initial_cols = 150
config.initial_rows = 40

-- deactivate tab bar fully
config.enable_tab_bar = false

-- don't ever beep
config.audible_bell = "Disabled"

-- font settings (no ligatures)
config.font = wezterm.font({
	family = "Hack Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.font_size = 16.0

-- change window padding
config.window_padding = {
	left = 10,
	right = 5,
	top = 15,
	bottom = 0,
}

-- make fonts appear a little bit brighter
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.2,
}

-- some custom colors
local colors = {
	command_bg = "#292e42",
	command_fg = "#c0caf5",
}

-- change command palette look
config.command_palette_font_size = 16.0
config.command_palette_bg_color = colors.command_bg
config.command_palette_fg_color = colors.command_fg

-- remove confirmation on close
config.window_close_confirmation = "NeverPrompt"

-- change look for inactive panes
config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.8,
}

-- [[ KEY MAPPING SETTINGS ]] --

local action = wezterm.action
local mods = {
	l = "LEADER",
	g = "CMD", -- GUI  (as used in ZMK)
	m = "ALT", -- Meta (alt, opt)
	c = "CTRL",
	all = "CMD | CTRL | ALT",
}
local tmux = { key = "a", mods = "CTRL" }

-- quick map tmux actions
local tmux_action = function(key)
	return action.Multiple({
		action.SendKey(tmux),
		action.SendKey({ key = key }),
	})
end

-- map CMD-<number> to corresponding tmux tab switch key
local number_keys = function()
	local key_table = {}

	for i = 0, 9 do
		local key = tostring(i)

		table.insert(key_table, {
			key = key,
			mods = mods.g,
			action = tmux_action(key),
		})
	end

	return table.unpack(key_table)
end

-- set leader key for wezterm itself
config.leader = { key = "`", mods = mods.c, timeout_milliseconds = 1000 }

config.keys = {
	-- Open Command Palette
	{
		key = "p",
		mods = mods.l,
		action = action.ActivateCommandPalette,
	},

	-- we might need a way to close the window
	{
		key = "w",
		mods = mods.all,
		action = action.CloseCurrentTab({ confirm = false }),
	},

	-- Rebind default key combos to tmux commands
	-- open sesh
	{
		key = "k",
		mods = mods.g,
		action = tmux_action("f"),
	},
	-- session overview
	{
		key = "o",
		mods = mods.g,
		action = tmux_action("s"),
	},
	-- create new window
	{
		key = "t",
		mods = mods.g,
		action = tmux_action("c"),
	},
	-- close active window
	{
		key = "w",
		mods = mods.g,
		action = tmux_action("x"),
	},

	-- map number keys
	number_keys(),
}

return config
