return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 5,
      max_width = 120,
      max_height = 20,
      border = "rounded",
      win_options = {
        winblend = 10,
      },
    },
    use_float = true,
  },
  keys = {
    {
      "-",
      function() require("oil").open_float() end,
      desc = "Open parent directory in Oil (float)",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
}
