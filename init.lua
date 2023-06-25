-- If lua is not in jit mode - stop
if not jit then
  print 'You must install lua jit, b-baka~!'
  return
end

-- If there's no git - stop
local fn = vim.fn
if pcall(function() fn.system({ 'aboba' }) end) then
  print 'Look at this baka who still doesn\'t install git, hahaha~!'
  return
end

-- Install packer if there's no packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_path = fn.stdpath('config') .. '/plugin/packer_compiled.lua'
local is_path_empty = function(path)
  return fn.empty(fn.glob(path)) > 0
end

local packer_ensure = function()
  if not is_path_empty(install_path) then
    return false
  end
  if not is_path_empty(packer_path) then
    return false
  end

  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  return true
end

local packer_ensure_result = packer_ensure()

local require_list = { 'base', 'plugins' }
for _, module in pairs(require_list) do
  require(module)
end

if packer_ensure_result then
  require('packer').sync()
end
