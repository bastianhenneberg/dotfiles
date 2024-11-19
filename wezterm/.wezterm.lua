-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

max_fps = 60

-- This is where you actually apply your config choices
--
-- Spawn a fish shell in login mode
config.default_prog = { "/bin/zsh", "-l" }

-- For example, changing the color scheme:
config.color_scheme = "Dracula"
config.font_size = 12
config.line_height = 1.5
config.cell_width = 1.03
-- config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Medium', italic = false})

config.enable_wayland = false

config.font = wezterm.font("Fira Code Nerd Font")
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
config.font = wezterm.font("Fira Code Nerd Font", { weight = "Medium", italic = false })

config.enable_wayland = false

config.window_decorations = "NONE"
config.window_padding = {
	left = "5px",
	right = "0px",
	top = "0px",
	bottom = "0px",
}
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false

-- Zen Mode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- and finally, return the configuration to wezterm
return config
