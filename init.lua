-- If lua is not in jit mode - stop
if not jit then
  print 'You must install lua jit, b-baka~!'
  return
end

-- If there's no git - stop
local fn = vim.fn
if not pcall(function() fn.system({ 'git' }) end) then
  print 'Look at this baka who still doesn\'t install git, hahaha~!'
  return
end

local require_list = { 'base', 'plugins' }
for _, module in pairs(require_list) do
  require(module)
end
