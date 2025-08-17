local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

return {
  -- expands -inf into float("-inf")
  s('-inf', {
    t 'float("-inf")',
  }),

  --expands inf into float("inf")
  s('inf', {
    t 'float("inf")',
  }),
}
