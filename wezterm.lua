local wezterm = require("wezterm")

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
