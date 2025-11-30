-- Git 增强功能
return {
  -- Git 责备和符号
  {
    "lewis6991/gitsigns.nvim",
    lazy = false, -- 直接加载
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "下一个更改" })

        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "上一个更改" })

        map("n", "<leader>hs", gs.stage_hunk, { desc = "暂存更改" })
        map("n", "<leader>hR", gs.reset_hunk, { desc = "重置更改" })
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "暂存选中更改" })
        map("v", "<leader>hR", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "重置选中更改" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "暂存整个文件" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "撤销暂存" })
        map("n", "<leader>hB", gs.reset_buffer, { desc = "重置整个文件" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "预览更改" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "显示完整 blame" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "切换 blame 显示" })
        map("n", "<leader>hd", gs.diffthis, { desc = "对比差异" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "对比差异 (HEAD)" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "切换显示删除" })
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "选择 Git 更改" })
      end,
    },
  },

  -- Git 差异查看器
  {
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_horizontal" },
        file_history = { layout = "diff2_horizontal" },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = { flatten_dirs = true, folder_statuses = "only_folded" },
        win_config = { width = 35 },
      },
      file_history_panel = { win_config = { width = 35 } },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "打开 Git Diff" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "关闭 Git Diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git 文件历史" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "当前文件历史" },
      { "<leader>gf", "<cmd>DiffviewToggleFiles<cr>", desc = "切换文件面板" },
    },
  },

  -- Git 冲突解决器
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    lazy = false,
    config = true,
    opts = {
      default_mappings = true,
      default_commands = true,
      disable_diagnostics = false,
      highlights = { incoming = "DiffAdd", current = "DiffText" },
    },
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "选择我们的更改" },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "选择他们的更改" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "保留双方更改" },
      { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "下一个冲突" },
      { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "上一个冲突" },
      { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "冲突列表" },
    },
  },
}
