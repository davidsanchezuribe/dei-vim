-------------------------------------------------------------------------------
-- 1. Keymaps
-------------------------------------------------------------------------------
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit Insert Mode' })
vim.keymap.set('v', 'jk', '<Esc>', { desc = 'Exit Visual Mode' })

-------------------------------------------------------------------------------
-- 2. Options
-------------------------------------------------------------------------------
vim.o.scrolloff = 4

vim.o.foldmethod = 'indent'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 5

-------------------------------------------------------------------------------
-- 3. Configuración LSP
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- 4. Plugins
-------------------------------------------------------------------------------
local function gh(repo)
  return 'https://github.com/' .. repo
end

-------------------------------------------------------------------------------
-- a. Neotree
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- b. Text Objects
-------------------------------------------------------------------------------
vim.pack.add {
  gh 'vim-scripts/camelcasemotion',
  gh 'vim-scripts/argtextobj.vim',
  gh 'michaeljsmith/vim-indent-object',
}

-------------------------------------------------------------------------------
-- c. Cut Plugin
-------------------------------------------------------------------------------
vim.pack.add { gh 'gbprod/cutlass.nvim' }

require('cutlass').setup {
  cut_key = 'm',
}

-------------------------------------------------------------------------------
-- d. Syntax Aware Text Objects
-------------------------------------------------------------------------------
vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-textobjects' }

require("nvim-treesitter-textobjects").setup {
  move = {
    set_jumps = true,
  },
}

-- Methods
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "Go to previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[M", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "Go to previous function end" })
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "Go to next function start" })
vim.keymap.set({ "n", "x", "o" }, "]M", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "Go to next function end" })

-- Classes/Interfaces
vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "Go to previous class start" })
vim.keymap.set({ "n", "x", "o" }, "][", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end, { desc = "Go to next class end" })
vim.keymap.set({ "n", "x", "o" }, "[]", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end, { desc = "Go to previous class end" })
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "Go to next class start" })

-- Loops
vim.keymap.set({ "n", "x", "o" }, "[o", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Go to previous loop start" })
vim.keymap.set({ "n", "x", "o" }, "[O", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Go to previous loop end" })
vim.keymap.set({ "n", "x", "o" }, "]o", function()
  require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Go to next loop start" })
vim.keymap.set({ "n", "x", "o" }, "]O", function()
  require("nvim-treesitter-textobjects.move").goto_next_end({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Go to next loop end" })

-- {} bodies
vim.keymap.set({ "n", "x", "o" }, "[s", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
end, { desc = "Go to previous local scope start" })
vim.keymap.set({ "n", "x", "o" }, "[S", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals")
end, { desc = "Go to previous local scope end" })
vim.keymap.set({ "n", "x", "o" }, "]s", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end, { desc = "Go to next local scope start" })
vim.keymap.set({ "n", "x", "o" }, "]S", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@local.scope", "locals")
end, { desc = "Go to next local scope end" })

-- Conditionals
vim.keymap.set({ "n", "x", "o" }, "[i", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@conditional.outer", "textobjects")
end, { desc = "Go to previous conditional start" })
vim.keymap.set({ "n", "x", "o" }, "[I", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@conditional.outer", "textobjects")
end, { desc = "Go to previous conditional end" })
vim.keymap.set({ "n", "x", "o" }, "]i", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@conditional.outer", "textobjects")
end, { desc = "Go to next conditional start" })
vim.keymap.set({ "n", "x", "o" }, "]I", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@conditional.outer", "textobjects")
end, { desc = "Go to next conditional end" })

-------------------------------------------------------------------------------
-- e. Telescope
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- e. Buffer remove
-------------------------------------------------------------------------------
vim.pack.add { gh 'echasnovski/mini.bufremove' }
vim.keymap.set("n", "<leader>bd", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer without closing window" })
