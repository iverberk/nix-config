local wezterm = require 'wezterm'
local act = wezterm.action

local LEADER = 'SHIFT|CMD'

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if pane:get_title():find("nvim") ~= nil or pane:get_title():find("ssh") ~= nil then
    window:perform_action(act.SendKey({ key = vim_direction, mods = 'CTRL' }), pane)
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)

wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)

wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)

wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

return {

  window_decorations = "RESIZE",

  window_close_confirmation = 'NeverPrompt',

  adjust_window_size_when_changing_font_size = false,

  font = wezterm.font 'MesloLGS Nerd Font',

  font_size = 10.0,

  window_frame = {
    font = wezterm.font 'MesloLGS Nerd Font',
    font_size = 8.0,
  },
  
  color_scheme = 'Tomorrow Night',

  keys = {
    { key = 't', mods = LEADER, action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'RightArrow', mods = LEADER, action = act.ActivateTabRelative(1) },
    { key = 'LeftArrow', mods = LEADER, action = act.ActivateTabRelative(-1) },
    { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
    { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'LeftArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Down', 1 } },
    { key = '|', mods = LEADER, action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = '_', mods = LEADER, action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    { key = 's', mods = LEADER, action = act.ActivateCopyMode },
    { key = 'y', mods = LEADER, action = act.QuickSelect },
    { key = 'U', mods = 'CTRL', action = act.ScrollByPage(-0.5) },
    { key = 'D', mods = 'CTRL', action = act.ScrollByPage(0.5) },
  }
  
}