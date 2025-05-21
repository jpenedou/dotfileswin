-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end -- This is where you actually apply your config choices

-- Para modificar un sheme
-- local scheme = wezterm.get_builtin_color_schemes()["Tokyo Night Moon"]
-- scheme.scrollbar_thumb = "#999999"
-- config.color_schemes = {
-- 	["Tokyo Night Moon"] = scheme,
-- }
config.color_scheme = "Tokyo Night Moon"

config.default_prog = { "pwsh" }

-- config.font = wezterm.font("JetBrains Mono")
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
-- config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 11
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local min_tittle_width = 16
	local title = tab_title(tab)
	local num_chars_padding = min_tittle_width - string.len(title)
	local prefix_and_sufix_tittle = ""
	if num_chars_padding > 0 then
		prefix_and_sufix_tittle = string.rep(" ", num_chars_padding)
	end
	if string.len(title) < min_tittle_width then
		title = prefix_and_sufix_tittle .. title .. prefix_and_sufix_tittle
	end
	if tab.is_active then
		return {
			{ Background = { Color = "#222436" } },
			{ Text = title },
		}
	end
	return title
end)
-- config.enable_scroll_bar = true

config.enable_kitty_graphics = true
-- and finally, return the configuration to wezterm
return config
