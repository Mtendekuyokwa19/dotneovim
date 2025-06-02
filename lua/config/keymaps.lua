-- lua/config/keymaps.lua
local M = {}

function M.setup()
  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<leader>f', builtin.buffers, { desc = 'Telescope buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

  -- Auto-close pairs
  vim.keymap.set("i", '"', '""<Left>')
  vim.keymap.set("i", "'", "''<Left>")
  vim.keymap.set("i", "(", "()<Left>")
  vim.keymap.set("i", "[", "[]<Left>")
  vim.keymap.set("i", "{", "{}<Left>")

  -- Terminal escape
  vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])
  vim.keymap.set('t', '<leader>n', [[<C-\><C-n>]], { noremap = true })

  -- Window navigation
  vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
  vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

  -- Terminal open / split window
  vim.keymap.set('n', '<leader>t', ':belowright split | terminal<CR>', { noremap = true, silent = true, desc='open terminal bottom' })
  vim.keymap.set('n', '<leader>s', ':vsplit <CR><C-w>l', { noremap = true, silent = true, desc='split pane' })

  -- Source config
  vim.keymap.set('n', '<leader>l', ':source $MYVIMRC <CR>', { noremap = true, silent = true ,desc='source my vim' })
  vim.keymap.set('n', '<leader>h', '<Cmd>Alpha<CR>', { noremap = true, silent = true })

  -- Buffer navigation
  vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })

  -- Mark viewer window
  vim.keymap.set('n', '<leader>m', function()
    local marks_output = vim.fn.execute('marks')
    local lines = vim.split(marks_output, '\n')
    local mark_lines = {}

    for _, line in ipairs(lines) do
      if line:match("^ [a-zA-Z]") then
        table.insert(mark_lines, line)
      end
    end

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

    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = 'wipe'

    vim.keymap.set('n', '<CR>', function()
      local lnum = vim.fn.line('.')
      local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
      local mark = line:match("^ ([a-zA-Z])")
      if mark then
        vim.api.nvim_win_close(win, true)
        vim.cmd("normal! `" .. mark)
      end
    end, { buffer = buf })

    vim.keymap.set('n', '<Esc>', function()
      vim.api.nvim_win_close(win, true)
    end, { buffer = buf })
  end, { noremap = true, silent = true, desc = "st.marks window" })

  -- React snippet
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.jsx", "*.tsx", "*.ts", "*.js" },
    callback = function()
      vim.keymap.set("n", "<leader>rf", "0i export function vim(){<CR> return<section></section> <CR>}<ESC> 2k ", { buffer = true, desc = "react function" })
    end,
  })

  -- MDX filetype set
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.mdx",
    callback = function()
      vim.bo.filetype = "markdown"
    end,
    desc = "Set filetype to markdown for .mdx files",
  })
end

return M

