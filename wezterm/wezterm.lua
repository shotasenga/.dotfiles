local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Apparence

config.color_scheme = 'Synthwave (Gogh)'
config.color_scheme = 'SynthwaveAlpha'
config.color_scheme = 'Horizon Dark (Gogh)'
config.color_scheme = 'Tokyo Night'
config.color_scheme = 'Rapture'
config.color_scheme = 'Omni (Gogh)'
config.color_scheme = 'iceberg-dark'
config.color_scheme = 'Tinacious Design (Dark)'
config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'Rosé Pine (Gogh)'
config.color_scheme = 'Banana Blueberry'

config.window_background_gradient = {
   colors = { '#191323', '#191323', '#2a2940', '#56b6c2' },
   orientation = { Linear = { angle = -45.0 } },
   noise = 64,
}

config.hide_tab_bar_if_only_one_tab = true

if string.find(wezterm.target_triple, "darwin") then
  config.window_background_opacity = 0.8
  config.macos_window_background_blur = 20
end

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  fade_in_function = 'EaseIn',
  fade_out_function = 'EaseOut',
}
config.colors = {
  visual_bell = '#56b6c2',
}

-- Fonts

if string.find(wezterm.target_triple, "darwin") then
  config.font = wezterm.font 'Hack Nerd Font Mono'
  config.font_size = 13
end

if string.find(wezterm.target_triple, "linux") then
  config.font = wezterm.font 'hack'
  config.font_size = 10
end


-- Keybindings
config.keys = {
  { key = 'P', mods = 'SUPER', action = wezterm.action.ActivateCommandPalette }
  -- { key = 'P', mods = 'CTRL', action = nil }
  -- TODO: select pane https://github.com/wez/wezterm/issues/1975#issuecomment-1134817741
  -- TODO: split window https://wezfurlong.org/wezterm/config/keys.html#leader-key
}


return config
