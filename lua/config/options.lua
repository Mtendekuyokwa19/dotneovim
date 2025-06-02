local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

-- General options
opt.ignorecase = true
opt.smartcase = true
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.shada = "'1000,<50,s10,h"
opt.undofile = true
opt.undodir = fn.getenv("HOME") .. "/.local/share/nvim/undo"


-- Clipboard yank sync
api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    fn.setreg("+", fn.getreg('"'))
  end,
})

-- Set .mdx as markdown
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
  desc = "Set filetype to markdown for .mdx files",
})

-- Autocmd to reload config
api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  command = "source $MYVIMRC"
})
vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = { current_line = false } })
