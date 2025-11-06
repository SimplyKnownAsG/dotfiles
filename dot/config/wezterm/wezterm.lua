local wezterm = require 'wezterm'
local act = wezterm.action

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   local tab_title = tab.tab_title
--   if tab_title ~= nil and #tab_title > 0 then
--     return tab_title
--   end
--   return tab.active_pane.title
-- end)

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
  default_cwd = wezterm.home_dir,
  font = wezterm.font {
    family = 'Cascadia Code PL',
    weight = 'Medium',
  },
  font_size = 10,
  color_scheme = color_scheme.color_scheme,
  scrollback_lines = 20000,

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

    {
      mods = 'CTRL|SHIFT',
      key = 'i',
      action = wezterm.action_callback(function(win, pane)
        wezterm.log_info 'Hello from callback!'
        wezterm.log_info(
          'WindowID:',
          win:window_id(),
          'PaneID:',
          pane:pane_id()
        )
      end),
    },

    -- open buffer in vim
    {
      key = 'f',
      mods = 'ALT',
      action = wezterm.action_callback(function(window, pane)
        local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

        -- Create a temporary file to pass to vim
        local name = os.tmpname()
        local f = io.open(name, 'w+')
        f:write(text)
        f:flush()
        f:close()

        wezterm.log_info("thing:")
        wezterm.log_info("thing: " ..name)
        -- Open a new window running vim and tell it to open the file
        window:perform_action(
          act.SpawnCommandInNewTab {
            args = { 'vim', name },
          },
          pane
        )

        -- -- Wait "enough" time for vim to read the file before we remove it.
        -- -- The window creation and process spawn are asynchronous wrt. running
        -- -- this script and are not awaitable, so we just pick a number.
        -- --
        -- -- Note: We don't strictly need to remove this file, but it is nice
        -- -- to avoid cluttering up the temporary directory.
        wezterm.sleep_ms(1000)
        os.remove(name)
      end)
    },

    -- override tab default directory
    {
      key = 'T',
      mods = 'CTRL|SHIFT',
      -- action = act.SpawnTab 'CurrentPaneDomain',
      action = act.SpawnCommandInNewTab {
        domain = 'DefaultDomain',
        cwd = wezterm.home_dir,
      },
      -- action = act.SpawnCommandInNewTab {
      --   -- XXX: This can be removed once the default_prog fix is available
      --   -- XXX: https://github.com/wezterm/wezterm/issues/6955
      --   args = { 'zsh', '-l' },
      --   domain = 'CurrentPaneDomain',
      --   cwd = wezterm.home_dir,
      -- },
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
