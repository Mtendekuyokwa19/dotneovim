-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.maplocalleader = 'é'
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':echo "Local Leader f pressed"<CR>', { noremap = true, silent = true })
