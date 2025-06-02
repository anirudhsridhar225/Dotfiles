return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    -- Keymaps for Oil
    {
      '<leader>e',
      function()
        require('oil').open()
      end,
      desc = 'Open Oil in floating window',
    },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['q'] = 'actions.close', -- `q` to close the float or regular Oil view
      ['<Esc>'] = 'actions.close',
      ['<CR>'] = function()
        local oil = require 'oil'
        local actions = require 'oil.actions'
        local entry = oil.get_cursor_entry()
        if not entry then
          return
        end
        if entry.type == 'directory' then
          actions.select.callback()
        else
          actions.select_tab.callback()
        end
      end,
    },
  },
}
