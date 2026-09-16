local servers = require('mason-lspconfig').get_installed_servers()
servers.eslint = {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
  end,
}

vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')

