local wezterm        = require 'wezterm'
local act            = wezterm.action

local LEADER         = 'SHIFT|CMD'

-- The color scheme you want to use
local scheme         = 'Tomorrow Night'

-- Obtain the definition of that color scheme
local scheme_def     = wezterm.color.get_builtin_schemes()[scheme]

-- Neovim integration

local direction_keys = { h = 'Left', j = 'Down', k = 'Up', l = 'Right' }

local function split_nav(key)
  return {
    key = key,
    mods = 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if pane:get_user_vars().IS_NVIM == "true" then
        win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end)
  }
end

-- Events

wezterm.on('update-status', function(window, pane)
  window:set_right_status(
    wezterm.format({
      { Text = wezterm.mux.get_active_workspace() .. '/' .. pane:get_domain_name() }
    })
  )
end)

-- Configuration

return {

  unix_domains = {
    {
      name = 'unix',
    },
  },

  window_padding = {
    left = 4,
    right = 4,
    top = 2,
    bottom = 0,
  },

  max_fps = 120,

  window_decorations = "RESIZE",

  window_close_confirmation = 'NeverPrompt',

  adjust_window_size_when_changing_font_size = false,

  font = wezterm.font 'MesloLGS Nerd Font',

  font_size = 10.0,

  window_frame = {
    font = wezterm.font 'MesloLGS Nerd Font',
    font_size = 8.0,
  },

  color_scheme = scheme,

  colors = {
    tab_bar = {
      active_tab = {
        bg_color = scheme_def.background,
        fg_color = scheme_def.foreground,
      }
    }
  },

  keys = {
    split_nav('h'),
    split_nav('j'),
    split_nav('k'),
    split_nav('l'),

    { mods = LEADER, key = 'T',          action = act.SpawnTab 'CurrentPaneDomain' },
    { mods = LEADER, key = 'RightArrow', action = act.ActivateTabRelative(1) },
    { mods = LEADER, key = 'LeftArrow',  action = act.ActivateTabRelative(-1) },
    { mods = LEADER, key = '|',          action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = LEADER, key = '_',          action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { mods = LEADER, key = 'S',          action = act.ActivateCopyMode },
    { mods = LEADER, key = 'Y',          action = act.QuickSelect },
    { mods = LEADER, key = 'W',          action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
    { mods = LEADER, key = 'A',          action = act.AttachDomain 'unix' },
    { mods = LEADER, key = 'D',          action = act.DetachDomain { DomainName = 'unix' } },
    {
      mods = LEADER,
      key = 'R',
      action = act.PromptInputLine { description = 'Enter new name for session',
        action = wezterm.action_callback(
          function(window, _, line)
            if line then
              wezterm.mux.rename_workspace(
                window:mux_window():get_workspace(),
                line
              )
            end
          end
        ),
      },
    },
    { mods = 'ALT',  key = 'Enter', action = act.ToggleFullScreen },
    { mods = 'CTRL', key = 'U',     action = act.ScrollByPage(-0.5) },
    { mods = 'CTRL', key = 'D',     action = act.ScrollByPage(0.5) },
  }
}
