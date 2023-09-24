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

-- dont' ever beep
config.audible_bell = "Disabled"

-- font settings
config.font = wezterm.font("JetBrainsMono Nerd Font")
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
}

-- hide little | symbal delimiting inactive tabs
config.colors = {
	tab_bar = {
		inactive_tab_edge = colors.mirage,
		new_tab_hover = {
			bg_color = colors.melrose,
			fg_color = colors.mirage,
		},
		new_tab = {
			fg_color = colors.melrose,
			bg_color = colors.mirage,
		},
	},
}

-- helper function for directory names
local dirName = function(dir)
	if not dir then
		return
	end

	local short_dir = dir:match("([^/]+)/?$")
	return short_dir
end

-- style tab bar
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- helper to style tab title
	function tab_title(tab_info)
		local title = tab_info.tab_title
		-- internal counting starts at 0 even if global setting is otherwise, so add 1
		-- to match display and actual key mapping
		local index = tab_info.tab_index + 1 .. " | "

		-- if the tab title is explicitly set, take that
		if title and #title > 0 then
			return index .. title
		end
		-- Otherwise, use the title from the active pane in that tab
		return index .. tab_info.active_pane.title
	end

	local edge_background = colors.mirage
	local background = colors.mirage
	local foreground = colors.hit_pink

	if tab.is_active then
		background = colors.hit_pink
		foreground = colors.mirage
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	-- title = wezterm.truncate_right(title, max_width - 2)
	title = dirName(title)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
	}
end)

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
		{ Foreground = { Color = colors.peach_yellow } },
		{ Text = keytable .. "  " },
		{ Foreground = { Color = colors.sea_pink } },
		{ Text = wezterm.nerdfonts.oct_file_directory_open_fill .. " " .. cwd .. "  " },
		{ Foreground = { Color = colors.morning_glory } },
		{ Text = wezterm.nerdfonts.cod_vm_running .. " " .. active_process .. "  " },

		{ Text = " " },
	}

	window:set_right_status(wezterm.format(statusElements))
end)

-- [[ KEY MAPPING SETTINGS ]] --

-- keyboard shortcuts / overrides
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- CONVENIENCE --
	-- Leader C-a -> Send C-a as command to terminal
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- SPLIT PANE --
	-- Leader | -> Split Horizontally
	{
		key = "H",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal,
	},
	-- Leader - -> Split vertically
	{
		key = "V",
		mods = "LEADER",
		action = wezterm.action.SplitVertical,
	},
	-- Leader x -> Close currently selected panel
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},

	-- SWITCH PANE --
	-- Unfortunately needs to be set up this way in order to not interfere with NeoVim
	-- split settings

	-- Leader h -> Activate pane to the left
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	-- Leader l -> Activate pane to the right
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Leader j -> Activate pane below
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Leader k -> Activate pane above
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	-- Leader z -> Zoom state of pane
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- switch 'mode' to key table to be able to easily resize our panes
	{
		key = "+",
		mods = "LEADER|SHIFT",
		action = wezterm.action.ActivateKeyTable({ name = "resizePanes", one_shot = false }),
	},

	-- pane selection mode
	{
		key = "o",
		mods = "LEADER",
		action = wezterm.action.PaneSelect,
	},

	--  some keybinds to manage tabs without having to move my thumb the long long way
	--  to CMD
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- Just testing some features
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateCommandPalette,
	},

	-- Workspace overview
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},

	-- Create new frontend / backend workspace in current directory
	{
		key = "d",
		mods = "LEADER|CTRL",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = colors.hit_pink } },
				{ Text = "Enter name for new development workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				local project_dir = pane:get_current_working_dir()
				project_dir = string.gsub(project_dir, "file://[^/]+/", "")

				wezterm.log_info("Project Dir: " .. project_dir)

				local workspace_name = "dev"

				if line then
					workspace_name = line
				end

				local tab, editor_pane, new_window = wezterm.mux.spawn_window({
					workspace = workspace_name,
					cwd = project_dir,
				})

				local term_pane_1 = editor_pane:split({
					direction = "Right",
					size = 0.35,
					cwd = project_dir,
				})

				local term_pane_2 = term_pane_1:split({
					direction = "Bottom",
					size = 0.5,
					cwd = project_dir,
				})

				editor_pane:send_text("vim .\n")
				editor_pane:activate()

				-- We want to startup in the coding workspace
				wezterm.mux.set_active_workspace(workspace_name)
			end),
		}),
	},
}

-- assign keys 1 to 9 to switch to tabs 1 to 9
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- [[ KEY TABLES ]] --

-- RESIZING PANES
-- amount of columns to adjust panes by
local resize_width = 5

config.key_tables = {
	resizePanes = {
		{
			key = "h",
			action = wezterm.action.AdjustPaneSize({ "Left", resize_width }),
		},
		{
			key = "l",
			action = wezterm.action.AdjustPaneSize({ "Right", resize_width }),
		},
		{
			key = "j",
			action = wezterm.action.AdjustPaneSize({ "Down", resize_width }),
		},
		{
			key = "k",
			action = wezterm.action.AdjustPaneSize({ "Up", resize_width }),
		},
		{
			key = "Escape",
			action = wezterm.action.PopKeyTable,
		},
		{
			key = "c",
			mods = "CTRL",
			action = wezterm.action.PopKeyTable,
		},
	},
}

-- return config
return config
