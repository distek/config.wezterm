local wezterm = require("wezterm")

wezterm.on("update-status", function(window, pane)
	-- Left status{{{
	local leftStatus = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = "wztrm" },
	})
	--}}}
	-- Right status{{{
	-- Date/Time
	local date = wezterm.strftime("%Y-%m-%d")
	local time = wezterm.strftime("%H:%M")

	local dateFmt = wezterm.format({
		{
			Foreground = {
				AnsiColor = "White",
			},
		},
		{ Text = date },
	})

	local timeFmt = wezterm.format({
		{
			Foreground = {
				AnsiColor = "Olive",
			},
		},
		{ Text = time },
	})

	-- Battery info
	local batInfo = wezterm.battery_info()[1]
	local batLevel = batInfo.state_of_charge
	local bat = string.format("%.0f%%", batInfo.state_of_charge * 100)

	local batColorString = ""
	if batLevel >= 0.81 then
		batColorString = "Green"
	elseif batLevel >= 0.5 then
		batColorString = "Yellow"
	else
		batColorString = "Red"
	end

	local batFmt = wezterm.format({
		{
			Foreground = {
				AnsiColor = batColorString,
			},
		},
		{ Text = bat },
	})
	-- }}}

	window:set_right_status(batFmt .. " │ " .. dateFmt .. " " .. timeFmt)

	window:set_left_status(" " .. leftStatus .. " ")
end)

return {
	disable_default_key_bindings = true,
	disable_default_mouse_bindings = false,

	enable_wayland = true,

	font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }),

	colors = require("colors"),
	keys = require("keybindings"),
	key_tables = require("keytables"),

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	window_background_opacity = 0.9,

	-- default_prog = {
	--     '/bin/zsh',
	--     '-l',
	--     '-c',
	--     '/bin/tmux'
	-- },

	enable_tab_bar = true,
	use_fancy_tab_bar = false,

	alternate_buffer_wheel_scroll_speed = 1,
}
