-- Pull in the wezterm API
local wezterm = require('wezterm');

-- This will hold the configuration.
local config = wezterm.config_builder();

-- Default Editor Configs
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {});
    window:gui_window():maximize();
end);

-- Fonts
config.font_size = 11;
config.font = wezterm.font("UbuntuMono Nerd Font Propo");

-- Theme
config.color_scheme = "Gruvbox Dark (Gogh)";

-- Default shell
config.default_prog = { "pwsh.exe" };

return config;