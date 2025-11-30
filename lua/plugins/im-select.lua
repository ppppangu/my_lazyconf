return {
  {
    "keaising/im-select.nvim",
    event = "VeryLazy",
    config = function()
      require("im_select").setup({
        default_im_select = "1033",
        default_command = "im-select.exe",
        set_default_events = { "InsertLeave" },
        set_previous_events = {},
      })
      
      -- 为 ToggleTerm 单独添加
      vim.api.nvim_create_autocmd("TermLeave", {
        pattern = "*",
        callback = function()
          vim.fn.system("im-select.exe 1033")
        end,
      })
    end,
  },
}