-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.maplocalleader = 'é'
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':echo "Local Leader f pressed"<CR>', { noremap = true, silent = true })
vim.cmd([[colorscheme everforest]])

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
