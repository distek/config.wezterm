local wezterm = require("wezterm")
local act = wezterm.action

local function inVim(pane)
	return pane:get_foreground_process_info().executable == "/usr/bin/nvim"
		or pane:get_foreground_process_info().executable == "/usr/local/bin/nvim"
		or pane:get_foreground_process_info().executable == os.getenv("HOME") .. "/.local/bin/nvim"
end

local function movePane(paneID, argDir)
	local s, out, err = wezterm.run_child_process({
		"wezterm",
		"cli",
		"move-pane-to-new-tab",
		"--pane-id=" .. paneID,
	})
	if not s then
		wezterm.log_info(out)
		wezterm.log_info(err)
		return
	end

	local s, out, err = wezterm.run_child_process({
		"wezterm",
		"cli",
		"split-pane",
		"--move-pane-id=" .. paneID,
		argDir,
	})
	if not s then
		wezterm.log_info(out)
		wezterm.log_info(err)
		return
	end
end

return {
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

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
	{
		key = "H",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab = pane:tab()

			if
				tab:get_pane_direction("Left") ~= nil
				or tab:get_pane_direction("Up") ~= nil
				or tab:get_pane_direction("Down") ~= nil
			then
				movePane(pane:pane_id(), "--left")
			end
		end),
	},
	{
		key = "J",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab = pane:tab()

			if
				tab:get_pane_direction("Down") ~= nil
				or tab:get_pane_direction("Right") ~= nil
				or tab:get_pane_direction("Left") ~= nil
			then
				movePane(pane:pane_id(), "--bottom")
			end
		end),
	},
	{
		key = "K",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab = pane:tab()

			if
				tab:get_pane_direction("Top") ~= nil
				or tab:get_pane_direction("Right") ~= nil
				or tab:get_pane_direction("Left") ~= nil
			then
				movePane(pane:pane_id(), "--top")
			end
		end),
	},
	{
		key = "L",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab = pane:tab()

			if
				tab:get_pane_direction("Right") ~= nil
				or tab:get_pane_direction("Up") ~= nil
				or tab:get_pane_direction("Down") ~= nil
			then
				movePane(pane:pane_id(), "--right")
			end
		end),
	},

	{ key = "h", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "j", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "k", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "l", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 1 }) },

	{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },

	{ key = "f", mods = "ALT", action = act.TogglePaneZoomState },

	{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },

	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },

	{
		key = "a",
		mods = "ALT",
		action = act.ActivateKeyTable({
			name = "prefix",
			one_shot = true,
		}),
	},
}
