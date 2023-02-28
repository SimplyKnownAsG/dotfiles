local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_title = tab.tab_title
  if tab_title ~= nil and #tab_title > 0 then
    return tab_title
  end
  return tab.active_pane.title
end)

local hacky_user_commands = {
  ['set-tab-title'] = function(window, pane, cmd_context)
    pane:mux_pane():tab():set_title(cmd_context.title)
  end,
  ['open-tab'] = function(window, pane, cmd_context)
    for tab_index, tab in ipairs(window:mux_window():tabs()) do
      if tab:get_title() == cmd_context.title then
        window:perform_action(
          act.ActivateTab(tab_index-1),
          pane
        )
        return
      end
    end

    local new_tab, _, _ = window:mux_window():spawn_tab {
      cwd = cmd_context.cwd
    }

    new_tab:set_title(cmd_context.title)
  end,
}

wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == 'hacky-user-command' then
    local cmd_context = wezterm.json_parse(value)
    hacky_user_commands[cmd_context.cmd](window, pane, cmd_context)
    return
  end
end)

return {
  default_prog = { 'zsh', '-l' },
  font = wezterm.font 'Cascadia Code PL',
  font_size = 10,
  window_decorations = "RESIZE",
  color_scheme = 'deep',

  keys = {
    -- create splits
    {
      key = '_',
      mods = 'SHIFT|ALT',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '|',
      mods = 'SHIFT|ALT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    -- resize
    { mods = 'ALT|SHIFT', key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { mods = 'ALT|SHIFT', key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { mods = 'ALT|SHIFT', key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { mods = 'ALT|SHIFT', key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { mods = 'ALT|SHIFT', key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { mods = 'ALT|SHIFT', key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { mods = 'ALT|SHIFT', key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { mods = 'ALT|SHIFT', key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    -- active split
    { mods = 'ALT', key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { mods = 'ALT', key = 'h', action = act.ActivatePaneDirection 'Left' },

    { mods = 'ALT', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { mods = 'ALT', key = 'l', action = act.ActivatePaneDirection 'Right' },

    { mods = 'ALT', key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = 'ALT', key = 'k', action = act.ActivatePaneDirection 'Up' },

    { mods = 'ALT', key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { mods = 'ALT', key = 'j', action = act.ActivatePaneDirection 'Down' },
  }
}
