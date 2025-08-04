return {
  'kawre/leetcode.nvim',
  cmd = 'Leet',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim', -- required
    'MunifTanjim/nui.nvim',

    -- optional
    'nvim-treesitter/nvim-treesitter',
    'rcarriga/nvim-notify',
  },
  config = function()
    require('leetcode').setup {
      lang = 'python3',
      cn = {
        enabled = false,
        translator = true,
        translate_problems = true,
      },

      storage = {
        home = vim.fn.stdpath 'data' .. '/leetcode',
        cache = vim.fn.stdpath 'cache' .. '/leetcode',
      },
      plugins = {
        non_standalone = true,
      },
      logging = true,
      hooks = {
        ---@type fun()[]
        ['enter'] = {},

        ---@type fun(question: lc.ui.Question)[]
        ['question_enter'] = {},

        ---@type fun()[]
        ['leave'] = {},
      },
      image_support = true,
    }
  end,
}
