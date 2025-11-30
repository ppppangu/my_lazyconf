-- 代码重构工具
return {
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {},
    keys = {
      { "<leader>re", function() require("refactoring").refactor("Extract Function") end, mode = "x", desc = "提取函数" },
      { "<leader>rf", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc = "提取函数到文件" },
      { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, mode = "x", desc = "提取变量" },
      { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc = "内联变量" },
      { "<leader>rb", function() require("refactoring").refactor("Extract Block") end, desc = "提取代码块" },
      { "<leader>rB", function() require("refactoring").refactor("Extract Block To File") end, desc = "提取代码块到文件" },
      { "<leader>rP", function() require("refactoring").debug.printf({ below = false }) end, desc = "添加 Printf" },
      { "<leader>rV", function() require("refactoring").debug.print_var({ normal = true }) end, desc = "打印变量" },
      { "<leader>rV", function() require("refactoring").debug.print_var() end, mode = "x", desc = "打印变量" },
      { "<leader>rc", function() require("refactoring").debug.cleanup({}) end, desc = "清理调试语句" },
      { "<leader>rr", function() require("telescope").extensions.refactoring.refactors() end, mode = { "n", "x" }, desc = "重构菜单" },
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      pcall(function() require("telescope").load_extension("refactoring") end)
    end,
  },
}
