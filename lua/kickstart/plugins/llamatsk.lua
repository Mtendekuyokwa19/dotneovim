return {
  -- In your `~/.config/nvim/lua/plugins.lua` or similar config file:
  {
    dir = '~/Desktop/jects/llamatsk',
    name = 'llamatsk',
    config = function()
      -- Optional plugin config here
      require('llamatsk').setup()
    end,
  },
}
