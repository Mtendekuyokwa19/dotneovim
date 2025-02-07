return {


  {
    "nvim-neorg/neorg",
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup({
        load = {

          ["core.defaults"] = {},

          ["core.keybinds"] = {},
          ["core.concealer"] = {
            config = {                -- We added a `config` table!
              icon_preset = "varied", -- And we set our option here.
            },
          },
        }
      })
    end,
  }
}
