local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- [[ GENERAL SETTINGS ]] --

-- TODO: Modify here for config theme switcher
config.color_scheme = "Catppuccin Mocha"

-- change window decoration
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.96
config.macos_window_background_blur = 40

-- adjust startup size
config.initial_cols = 150
config.initial_rows = 40

-- setup tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- TODO: Modify here for config theme switcher
-- tabs colors
config.colors = {
	tab_bar = {
		background = "rgba(0, 0, 0, 0)",
		active_tab = {
			bg_color = "#74c7ec",
			fg_color = "rgba(0,0,0,0)",
		},
		inactive_tab = {
			bg_color = "rgba(0,0,0,0)",
			fg_color = "#cdd6f4",
		},
		new_tab = {
			bg_color = "rgba(0,0,0,0)",
			fg_color = "#74c7ec",
		},
	},
}

-- don't ever beep
config.audible_bell = "Disabled"

-- font settings (no ligatures)
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	weight = "Medium",
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
	brightness = 1.26,
}

-- TODO: Modify here for config theme switcher
-- some custom colors
local colors = {
	command_bg = "#181825",
	command_fg = "#cdd6f4",
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
}

local multiMod = function(...)
	local modArgs = { ... }
	return table.concat(modArgs, "|")
end

-- set leader key for wezterm itself
config.leader = { key = "a", mods = mods.c, timeout_milliseconds = 500 }

config.keys = {
	-- Pass leader through
	{
		key = "a",
		mods = multiMod(mods.l, mods.c),
		action = action.SendKey({ key = "a", mods = mods.c }),
	},

	-- Open Command Palette
	{
		key = "a",
		mods = mods.l,
		action = action.ActivateCommandPalette,
	},

	-- Some tab actions
	{
		key = "c",
		mods = mods.l,
		action = action.SpawnTab("DefaultDomain"),
	},
	{
		key = "w",
		mods = mods.g,
		action = action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "x",
		mods = mods.l,
		action = action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "n",
		mods = mods.l,
		action = action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = mods.l,
		action = action.ActivateTabRelative(-1),
	},

	-- Panes
	{
		key = "v",
		mods = mods.l,
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = mods.l,
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = mods.l,
		action = action.CloseCurrentPane({ confirm = false }),
	},

	{
		key = "h",
		mods = multiMod(mods.l, mods.c),
		action = action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = multiMod(mods.l, mods.c),
		action = action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = multiMod(mods.l, mods.c),
		action = action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = multiMod(mods.l, mods.c),
		action = action.ActivatePaneDirection("Right"),
	},

	{
		key = ">",
		mods = mods.l,
		action = action.RotatePanes("Clockwise"),
	},
	{
		key = "<",
		mods = mods.l,
		action = action.RotatePanes("CounterClockwise"),
	},

	-- TODO: add scrolling and copy / pasting
}

-- set leader + 0..9 to switch tabs
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = mods.l,
		action = action.ActivateTab(i - 1),
	})
end

return config
