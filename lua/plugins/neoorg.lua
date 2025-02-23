return {


  {
    "nvim-neorg/neorg",
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup({
        load = {

          ["core.defaults"] = {},

          ["core.esupports.metagen"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                my_ws = "~/neorg", -- Format: <name_of_workspace> = <path_to_workspace_root>
                notes = "~/Desktop/dumbnotes/"
              },
              index = "index.norg", -- The name of the main (root) .norg file
            }
          },
          ["core.keybinds"] = {},

          ["core.summary"] = {},

          ["core.ui.calendar"] = {},
          ["core.journal"] = {},
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
