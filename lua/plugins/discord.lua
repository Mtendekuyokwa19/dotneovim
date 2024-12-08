return {
  "vyfor/cord.nvim",
  run = "./build || .\\build",
  config = function()
    require("cord").setup()
  end,
}
