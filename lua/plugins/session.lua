-- 会话管理
return {
  -- 禁用 persistence.nvim
  {
    "folke/persistence.nvim",
    enabled = false,
  },

  -- auto-session (更新配置格式)
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      enabled = true,
      auto_create = true,
      auto_save = true,
      auto_restore = true,
      suppressed_dirs = { "~/", "~/Downloads", "/" },
      git_use_branch_name = false,
      log_level = "error",
      bypass_save_filetypes = { "alpha", "dashboard", "neo-tree" },
      session_lens = {
        load_on_setup = true,
        picker_opts = { border = true },
        previewer = false,
      },
    },
    keys = {
      { "<leader>qw", "<cmd>SessionSave<cr>", desc = "保存会话" },
      { "<leader>qr", "<cmd>SessionRestore<cr>", desc = "恢复会话" },
      { "<leader>qs", "<cmd>SessionSearch<cr>", desc = "查找会话" },
      { "<leader>qd", "<cmd>SessionDelete<cr>", desc = "删除会话" },
    },
  },
}
