local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'echasnovski/mini.bufremove' }
vim.keymap.set("n", "<leader>bd", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer without closing window" })
