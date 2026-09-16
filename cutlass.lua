local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'gbprod/cutlass.nvim' }

require('cutlass').setup {
  cut_key = 'm',
}

