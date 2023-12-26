local lspconfig = require 'lspconfig'
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  'clangd',
  'pyright',
  {
    server = 'lua_ls',
    config = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
  },
  'dockerls',
  'docker_compose_language_service'
}

local function tableMerge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

function FORMAT_FILE()
  if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'readonly') then
    return
  end

  for _, client in ipairs(vim.lsp.buf_get_clients()) do
    local format_function = client.config.format_function
    if format_function then
      format_function(vim.api.nvim_buf_get_name(0))
    else
      vim.lsp.buf.format()
    end
  end
end

vim.cmd [[autocmd BufWritePre <buffer> lua FORMAT_FILE()]]

for _, lsp in ipairs(servers) do
  local config = {
    capabilities = capabilities
  }

  if type(lsp) == 'table' then
    lspconfig[lsp.server].setup(tableMerge(config, lsp.config))
  else
    lspconfig[lsp].setup(config)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
