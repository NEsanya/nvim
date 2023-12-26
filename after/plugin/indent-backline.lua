local colors = require('dracula').colors()
local highlight = {
  "RainbowGreen",
  "RainbowBlue",
  "RainbowYellow",
  "RainbowRed",
  "RainbowRed",
  "RainbowRed"
}

local hooks = require('ibl.hooks')
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.cyan })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
end)

require('ibl').setup({ indent = { highlight = highlight } })
