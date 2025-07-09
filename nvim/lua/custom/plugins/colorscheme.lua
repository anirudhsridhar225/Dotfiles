return {
  'datsfilipe/vesper.nvim',
  priority = 1000,
  config = function()
    require('vesper').setup {
      transparent = true,
      italics = {
        comments = true,
        keywords = false,
        functions = false,
        strings = true,
        variables = false,
      },
    }
    -- vim.cmd.colorscheme 'vesper'
  end,
}
