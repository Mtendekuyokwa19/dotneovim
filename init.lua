-- bootstrap lazy.nvim, LazyVim and your plugins
-- bootstrap lazy.nvim, LazyVim and your plugins
-- Trigger :ShowkeysToggle on startup
require("config.lazy")
vim.cmd("autocmd VimEnter * ShowkeysToggle")
vim.keymap.set("n", "<C-\\><C-n>", "<C-Space>")
vim.cmd([[
      au BufRead,BufNewFile *.ejs set filetype=html
]])
vim.cmd([[colorscheme tokyonight-storm]])
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  command = "set filetype=ejs",
})
