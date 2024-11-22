-- bootstrap lazy.nvim, LazyVim and your plugins
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Trigger :ShowkeysToggle on startup
vim.cmd("autocmd VimEnter * ShowkeysToggle")
vim.cmd([[colorscheme tokyonight-night]])
--
