-- Resize the fugitive status window to a fixed height so it doesn't
-- consume half the screen when opened alongside a diff.
vim.cmd('resize 10')

-- Navigate to the next/prev changed file in the fugitive status buffer
-- and open it as a vertical diff split. Works from any window.
local function fugitive_nav(direction)
  local fugitive_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'fugitive' then
      fugitive_win = win
      break
    end
  end

  if not fugitive_win then
    vim.notify('No fugitive status window found', vim.log.levels.WARN)
    return
  end

  vim.api.nvim_set_current_win(fugitive_win)
  if direction == 'next' then
    vim.cmd('normal )')
  else
    vim.cmd('normal (')
  end
  vim.cmd('normal dq') -- close existing diff buffers cleanly
  vim.cmd('normal dv') -- open fresh vertical diff
end

vim.keymap.set('n', '<leader>gn', function() fugitive_nav('next') end, { noremap=true, silent=true, desc='Fugitive: next diff file' })
vim.keymap.set('n', '<leader>gp', function() fugitive_nav('prev') end, { noremap=true, silent=true, desc='Fugitive: prev diff file' })
