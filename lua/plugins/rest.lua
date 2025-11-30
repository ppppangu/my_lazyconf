-- HTTP REST 客户端 (kulala)
-- 注意: 快捷键改为 <leader>hr 系列，避免与 refactoring 冲突
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>hr", function() require("kulala").run() end, desc = "Run HTTP request" },
      { "<leader>hp", function() require("kulala").jump_prev() end, desc = "Prev HTTP request" },
      { "<leader>hn", function() require("kulala").jump_next() end, desc = "Next HTTP request" },
    },
    opts = {},
  },
}
