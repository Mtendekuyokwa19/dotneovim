return {
{
  dir = "~/Desktop/jects/stoics.nvim/", -- Replace with actual path
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme stoicsgodot")
    vim.cmd("StoicsMarcus")
  end,
}
}
