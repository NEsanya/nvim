local rainbow_delimiters = require('rainbow-delimiters')
local colors = require('dracula').colors()

local rainbow_colors = {
  ['RainbowDelimiterRed'] = colors.red,
  ['RainbowDelimiterYellow'] = colors.yellow,
  ['RainbowDelimiterBlue'] = colors.bright_blue,
  ['RainbowDelimiterOrange'] = colors.orange,
  ['RainbowDelimiterGreen'] = colors.green,
  ['RainbowDelimiterViolet'] = colors.purple,
  ['RainbowDelimiterCyan'] = colors.cian,
}

local color_names = {}
for name, color in pairs(rainbow_colors) do
  vim.api.nvim_set_hl(0, name, { fg = color })
  table.insert(color_names, name)
end

require('rainbow-delimiters.setup').setup {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local']
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks'
  },
  priority = {
    [''] = 110,
    lua = 210,
  },
  highlight = color_names,
}
