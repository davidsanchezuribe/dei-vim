local telescope = require('telescope.builtin')

vim.keymap.set('n', '<Leader>sG', function()
  telescope.live_grep({
    additional_args = function()
      return { '--case-sensitive' }
    end,
  })
end, { desc = '[S]earch [G]rep (Case Sensitive)' })

vim.keymap.set({ 'n', 'v' }, '<Leader>sW', function()
  telescope.grep_string({
    additional_args = function()
      return { '--case-sensitive' }
    end,
  })
end, { desc = '[S]earch current [W]ord (Case Sensitive)' })

vim.api.nvim_create_user_command('GrepIn', function(opts)
  telescope.live_grep({ cwd = opts.args })
end, { nargs = 1, complete = 'dir' })


