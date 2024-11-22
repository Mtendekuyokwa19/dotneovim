return {
  -- Other plugins ...

  {
    "yuttie/comfortable-motion.vim",
    config = function()
      -- You can add any configuration here if you want to adjust the plugin behavior
      vim.g.comfortable_motion_speed = 10 -- Speed of scrolling (default 10)
      vim.g.comfortable_motion_mappings = 1 -- Enable default key mappings
    end,
  },

  -- Other plugins ...
}
