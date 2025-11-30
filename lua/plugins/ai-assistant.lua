-- AI 代码助手 - Codeium
return {
  {
    "Exafunction/codeium.vim",
    lazy = false,
    config = function()
      vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true, desc = "接受 AI 建议" })
      vim.keymap.set("i", "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true, desc = "下一个建议" })
      vim.keymap.set("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true, desc = "上一个建议" })
      vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true, desc = "清除建议" })
      vim.keymap.set("i", "<C-Space>", function() return vim.fn["codeium#Complete"]() end, { expr = true, silent = true, desc = "触发 AI 建议" })
      vim.g.codeium_filetypes = { markdown = false, text = false }
    end,
  },
}
