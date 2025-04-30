			return {
{
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_suppress_dirs = { "~/Downloads", "/" },  -- Ignore these dirs
      auto_save_enabled = true,   -- Auto-save session on exit
      auto_restore_enabled = true, -- Auto-restore session on startup
    })
  end,
}
}
