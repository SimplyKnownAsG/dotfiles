local wezterm = require 'wezterm'
local act = wezterm.action

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   local tab_title = tab.tab_title
--   if tab_title ~= nil and #tab_title > 0 then
--     return tab_title
--   end
--   return tab.active_pane.title
-- end)

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

local color_scheme = {
  color_scheme = "Builtin Dark"
}

local ok, mod = pcall(require, 'color_scheme')
if mod then
  color_scheme.color_scheme = mod.color_scheme
end

local ssh_domains = {}

local ok, work_ssh_domains = pcall(require, 'work_ssh_domains')
if work_ssh_domains then
  ssh_domains = work_ssh_domains
end

return {
  default_prog = { 'zsh', '-l' },
  font = wezterm.font {
    family = 'Cascadia Code PL',
    weight = 'Medium',
  },
  font_size = 10,
  color_scheme = color_scheme.color_scheme,
  scrollback_lines = 20000,
  default_cwd = wezterm.home_dir,

  window_decorations = "NONE",
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = true,
  tab_bar_at_bottom = true,
  enable_wayland = false,

  -- front_end = 'WebGpu',

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

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

    -- override tab default directory
    {
      key = 'T',
      mods = 'CTRL|SHIFT',
      action = act.SpawnCommandInNewTab { domain = 'CurrentPaneDomain', cwd=wezterm.home_dir, },
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
  },
  ssh_domains = ssh_domains,
}
