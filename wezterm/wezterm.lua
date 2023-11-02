local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- [[ GENERAL SETTINGS ]] --

-- the best colorscheme to have ever existed
config.color_scheme = "Catppuccin Mocha"

-- change window decoration
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- adjust startup size
config.initial_cols = 150
config.initial_rows = 40

-- deactivate tab bar fully
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- dont' ever beep
config.audible_bell = "Disabled"

-- font settings (no ligatures)
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.font_size = 16.0

-- change window padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- catppuccin colors (named according to 'Color Slurp')
local colors = {
	cinders = "#11111B",
	mirage = "#171825",
	santas_gray = "#9399B1",
	melrose = "#B4BEFD",
	morning_glory = "#94E2D5",
	hit_pink = "#FAB386",
	granny_smith_apple = "#A7E3A1",
	peach_yellow = "#F9E2AF",
	mauvelous = "#F38BA8",
	sea_pink = "#ECA0AC",
}

-- set font for tab bar
config.window_frame = {
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = colors.mirage,
	inactive_titlebar_bg = colors.mirage,
	border_left_width = "0cell",
	border_right_width = "0cell",
	border_top_height = "0.3cell",
	border_bottom_height = "0cell",
	border_left_color = colors.cinders,
	border_right_color = colors.cinders,
	border_top_color = colors.cinders,
	border_bottom_color = colors.cinders,
}

-- helper function for directory names
local dirName = function(dir)
	if not dir then
		return
	end

	local short_dir = dir:match("([^/]+)/?$")
	return short_dir
end

-- change command palette look
config.command_palette_font_size = 16.0
config.command_palette_bg_color = colors.cinders
config.command_palette_fg_color = colors.santas_gray

-- remove confirmation on close
config.window_close_confirmation = "NeverPrompt"

-- change look for inactive panes
config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.8,
}

-- [[ KEY MAPPING SETTINGS ]] --

-- keyboard shortcuts / overrides
config.leader = { key = "`", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Open Command Palette
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateCommandPalette,
	},

	-- Insert Umlauts
	{ key = "u", mods = "LEADER|CTRL", action = wezterm.action.SendString("ü") },
	{ key = "o", mods = "LEADER|CTRL", action = wezterm.action.SendString("ö") },
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendString("ä") },
	{ key = "s", mods = "LEADER|CTRL", action = wezterm.action.SendString("ß") },

	-- Deactivate CMD-T to not have Tabs interfere with TMUX
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.Nop,
	},
}

-- [[ Additional Styling ]] --

-- style 'status bar'
wezterm.on("update-status", function(window, pane)
	local workspace = wezterm.nerdfonts.dev_terminal .. " " .. window:active_workspace()
	local keytable = workspace
	local leader = ""

	-- key table active?
	if window:active_key_table() then
		keytable = wezterm.nerdfonts.md_table_key .. " " .. window:active_key_table()
	end

	-- leader pressed?
	if window:leader_is_active() then
		leader = "[ " .. wezterm.nerdfonts.oct_command_palette .. " ] "
	end

	-- current working directory
	local cwd = dirName(pane:get_current_working_dir())

	-- active process
	local active_process = dirName(pane:get_foreground_process_name())

	local statusElements = {
		{ Background = { Color = colors.mirage } },
		{ Foreground = { Color = colors.granny_smith_apple } },
		{ Text = leader },
		"ResetAttributes",
		{ Background = { Color = colors.mirage } },
		-- { Foreground = { Color = colors.peach_yellow } },
		-- { Text = keytable .. "  " },
		-- { Foreground = { Color = colors.sea_pink } },
		-- { Text = wezterm.nerdfonts.oct_file_directory_open_fill .. " " .. cwd .. "  " },
		{ Foreground = { Color = colors.morning_glory } },
		{ Text = wezterm.nerdfonts.cod_vm_running .. " " .. active_process .. "  " },

		{ Text = " " },
	}

	window:set_right_status(wezterm.format(statusElements))
end)

-- return config
return config
