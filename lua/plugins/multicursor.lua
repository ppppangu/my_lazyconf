-- 多光标编辑
return {
  {
    "smoka7/multicursors.nvim",
    lazy = false,
    dependencies = { "nvimtools/hydra.nvim" },
    opts = {
      hint_config = { border = "rounded", position = "bottom-right" },
      generate_hints = { normal = true, insert = true, extend = true },
    },
    keys = {
      { "<leader>m", "<cmd>MCstart<cr>", mode = { "v", "n" }, desc = "创建多光标" },
      { "<leader>mp", "<cmd>MCpattern<cr>", mode = "v", desc = "按模式创建多光标" },
      { "<leader>ma", "<cmd>MCvisual<cr>", mode = "v", desc = "在选中区域创建多光标" },
      { "<leader>mu", "<cmd>MCunderCursor<cr>", desc = "在当前单词创建多光标" },
      { "<leader>mc", "<cmd>MCclear<cr>", mode = { "n", "v" }, desc = "清除多光标" },
    },
  },
}
