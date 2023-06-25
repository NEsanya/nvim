local lspconfig = require 'lspconfig'
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  'clangd',
  'pyright',
  {
    server = 'lua_ls',
    config = {
      globals = { 'vim' }
    }
  }
}

for _, lsp in ipairs(servers) do
  local config = {
    capabilities = capabilities
  }

  if type(lsp) == 'table' then
    for k, v in pairs(lsp.config) do config[k] = v end
    lspconfig[lsp.server].setup(config)
  else
    lspconfig[lsp].setup(config)
  end
end

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
