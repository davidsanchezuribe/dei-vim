local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add {
  gh 'MunifTanjim/nui.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'nvim-neo-tree/neo-tree.nvim',
}

require('neo-tree').setup({
  close_if_last_window = true,
  filesystem = {
    window = {
      mappings = {
        ["F"] = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          if node.type ~= "directory" then
            path = vim.fs.dirname(path)
          end

          require("telescope.builtin").live_grep({ search_dirs = { path } })
        end,
      },
    },
  },
})

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })

