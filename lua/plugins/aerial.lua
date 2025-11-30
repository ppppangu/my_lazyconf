-- 代码大纲和符号浏览器
return {
  {
    "stevearc/aerial.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
      layout = {
        max_width = { 40, 0.25 },
        min_width = 25,
        default_direction = "prefer_right",
        placement = "edge",
      },
      attach_mode = "global",
      highlight_on_hover = true,
      highlight_on_jump = 300,
      autojump = true,
      icons = {
        Array = "󰅪 ", Boolean = "⊨ ", Class = "󰌗 ", Constructor = " ",
        Constant = "󰏿 ", Enum = " ", EnumMember = " ", Event = " ",
        Field = " ", File = "󰈙 ", Function = "󰊕 ", Interface = " ",
        Key = "󰌋 ", Method = "󰊕 ", Module = " ", Namespace = "󰦮 ",
        Null = "NULL ", Number = "󰎠 ", Object = " ", Operator = "󰆕 ",
        Package = " ", Property = " ", String = " ", Struct = "󰌗 ",
        TypeParameter = "󰊄 ", Variable = "󰀫 ",
      },
      filter_kind = false,
      lsp = { diagnostics_trigger_update = true, update_when_errors = true, update_delay = 300 },
      treesitter = { update_delay = 300 },
      markdown = { update_delay = 300 },
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "代码大纲 (Aerial)" },
      { "<leader>cn", "<cmd>AerialNext<cr>", desc = "下一个符号" },
      { "<leader>cp", "<cmd>AerialPrev<cr>", desc = "上一个符号" },
      { "<leader>cN", "<cmd>AerialNavToggle<cr>", desc = "符号导航" },
    },
  },
}
