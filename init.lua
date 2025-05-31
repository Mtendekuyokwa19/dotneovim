require("config.lazy")
      vim.cmd("set ignorecase smartcase")
      vim.cmd("set ruler ")
require("neo-tree").setup({
  close_if_last_window = true,  -- Close if NeoTree is the last window
  auto_open = false,            -- Disable auto-open on startup
})
require("which-key")
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
---line numbers--
vim.cmd("set number")
vim.cmd("hi LineNr cterm=bold gui=bold")
vim.cmd("set relativenumber")
vim.cmd("hi LineNr guifg=#a6e3a1")
vim.cmd("hi LineNrAbove guifg=#04a5e5")
vim.cmd("hi LineNrBelow guifg=#ea76cb")
vim.cmd("hi Normal  guibg=#11111b")
---clipboard---
vim.cmd("set clipboard=unnamed")

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>w', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>f', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })



--on everybootup since sometimes you install plugins and the lazy pop up leads to it not working--
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  command = "source $MYVIMRC"
})

--vim auto-close--
vim.keymap.set("i", '"', '""<Left>')
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", "{}<Left>")

--escaping the terminal--
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
})
--lualines

vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = { current_line = false } })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
vim.keymap.set('n', '-', function()
  require("neo-tree.command").execute({
    toggle = true,
    position = "float", -- Opens in a floating window
    float={
	width = math.floor(vim.o.columns * 0.7),  -- 70% of editor width
      height = math.floor(vim.o.lines * 0.8),   -- 80% of editor height
      border = "rounded", 
    }
  })
end, { desc = "Toggle NeoTree (Float)" })
-- Enable ShaDa (persistent undo, marks, jumps, etc.)
vim.opt.shada = "'1000,<50,s10,h"  -- Save marks/registers for 1000 files, <50 lines, max 10KB per register
vim.opt.undofile = true             -- Persistent undo (even after closing file)
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"  -- Set undo directory
-- Move to previous tab (Shift+H)
vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- Move to next tab (Shift+L)
vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', '<Cmd>Alpha<CR>', { noremap = true, silent = true })

vim.opt.termguicolors = true
require("bufferline").setup{}
-- Use system clipboard for yank/delete/paste
vim.opt.clipboard = "unnamedplus"  -- Linux/macOS/Wayland
-- vim.opt.clipboard = "unnamed"   -- Windows (or older macOS)

-- Sync yanked text to clipboard automatically
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.fn.setreg("+", vim.fn.getreg('"'))  -- Sync default yank to clipboard
  end,
})


vim.keymap.set('t', '<leader>n', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<leader>t', ':belowright split | terminal<CR>', { noremap = true, silent = true ,desc='open terminal bottom'})
vim.keymap.set('n', '<leader>s', ':vsplit <CR><C-w>l', { noremap = true, silent = true, desc='split pane'})
vim.keymap.set('n', '<leader>l', ':source $MYVIMRC <CR>', { noremap = true, silent = true ,desc='source my vim'})
vim.keymap.set('n', '<leader>m', function()
  local marks_output = vim.fn.execute('marks')
  local lines = vim.split(marks_output, '\n')

  -- Filter out header lines and invalid marks
  local mark_lines = {}
  for _, line in ipairs(lines) do
    if line:match("^ [a-zA-Z]") then
      table.insert(mark_lines, line)
    end
  end

  -- Handle the case where there are no valid marks
  if #mark_lines == 0 then
    vim.notify("No marks found.", vim.log.levels.INFO)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, mark_lines)

  local width = math.max(40, math.floor(vim.o.columns * 0.5))
  local height = math.min(#mark_lines, 20)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Make buffer non-editable
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'

  -- Set keymap to jump to mark on <Enter>
  vim.keymap.set('n', '<CR>', function()
    local lnum = vim.fn.line('.')
    local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
    local mark = line:match("^ ([a-zA-Z])")

    if mark then
      vim.api.nvim_win_close(win, true)
      vim.cmd("normal! `" .. mark)
    end
  end, { buffer = buf })

  -- Close on <Esc>
  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })
end, { noremap = true, silent = true,desc="st.marks windows" })


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jsx", "*.tsx","*.ts","*.js" },
  callback = function()
    vim.keymap.set("n", "<leader>rf", "0i export function vim(){<CR> return<section></section> <CR>}<ESC> 2k ", { buffer = true, desc = "react function" })
  end,
})



vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
  desc = "Set filetype to markdown for .mdx files",
})
