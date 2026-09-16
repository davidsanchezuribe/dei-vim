local function gh(repo)
  return 'https://github.com/' .. repo
end

-------------------------------------------------------------------------------
-- Text Objects (Vim scripts)
-------------------------------------------------------------------------------
vim.pack.add {
  gh 'vim-scripts/camelcasemotion',
  gh 'vim-scripts/argtextobj.vim',
  gh 'michaeljsmith/vim-indent-object',
}

-------------------------------------------------------------------------------
-- Syntax Aware Text Objects (Treesitter)
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


