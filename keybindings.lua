local wezterm = require("wezterm")
local act = wezterm.action

local function inVim(pane)
	return pane:get_foreground_process_info().executable == "/usr/bin/nvim"
		or pane:get_foreground_process_info().executable == "/usr/local/bin/nvim"
		or pane:get_foreground_process_info().executable == "~/.local/bin/nvim" -- idk if this works correctly
end

return {
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

	{ key = '"', mods = "ALT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "SHIFT|ALT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },

	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
	{ key = "0", mods = "ALT", action = act.ActivateTab(9) },

	{
		key = "h",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			if inVim(pane) then
				win:perform_action(act.SendKey({ key = "h", mods = "ALT" }), pane)
				return
			end

			win:perform_action(act.ActivatePaneDirection("Left"), pane)
		end),
	},
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			if inVim(pane) then
				win:perform_action(act.SendKey({ key = "j", mods = "ALT" }), pane)
				return
			end

			win:perform_action(act.ActivatePaneDirection("Down"), pane)
		end),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			if inVim(pane) then
				win:perform_action(act.SendKey({ key = "k", mods = "ALT" }), pane)
				return
			end

			win:perform_action(act.ActivatePaneDirection("Up"), pane)
		end),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			if inVim(pane) then
				win:perform_action(act.SendKey({ key = "l", mods = "ALT" }), pane)
				return
			end

			win:perform_action(act.ActivatePaneDirection("Right"), pane)
		end),
	},
	{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },

	{ key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },

	-- { key = "X", mods = "CTRL", action = act.ActivateCopyMode },
	-- { key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },

	-- { key = "F", mods = "ALT", action = act.TogglePaneZoomState },

	-- { key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
	--
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
}
