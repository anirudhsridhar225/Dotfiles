return {
  'nanozuki/tabby.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = {
      fill = 'TabLineFill',
      head = 'TabLine',
      current_tab = 'TabLineSel',
      other_tab = 'TabLine',
    }

    require('tabby.tabline').set(function(line)
      return {
        {
          { '  ', hl = theme.head },
          line.tabs().foreach(function(tab)
            local wins = vim.api.nvim_tabpage_list_wins(tab.id)
            local win = wins[1]
            local buf = vim.api.nvim_win_get_buf(win)
            local path = vim.api.nvim_buf_get_name(buf)
            local parent = vim.fn.fnamemodify(path, ':h:t')
            local file = vim.fn.fnamemodify(path, ':t')
            return {
              ' ' .. parent .. '/' .. file .. ' ',
              hl = tab.is_current() and theme.current_tab or theme.other_tab,
            }
          end),
          hl = theme.fill,
        },
        line.spacer(),
      }
    end)
  end,
}
