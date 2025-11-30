-- 增强的 Telescope 搜索
return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      -- 覆盖默认的文件搜索，使用更好的配置
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "查找文件" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "查找文件" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "全局搜索" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "查找缓冲区" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "帮助标签" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "最近文件" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "命令" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "快捷键" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "搜索当前单词" },
      { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Vim 选项" },
      { "<leader>f?", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "当前缓冲区搜索" },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          -- 更大的预览窗口
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              preview_cutoff = 120,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          -- 排序策略
          sorting_strategy = "ascending",
          -- 更智能的搜索
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "dist/",
            "build/",
            "target/",
            "*.pyc",
            "__pycache__",
            ".venv",
            "venv",
          },
          -- 快捷键映射
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-d>"] = actions.delete_buffer,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
              ["<C-d>"] = actions.delete_buffer,
              ["q"] = actions.close,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
          },
          -- 性能优化
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- 去除缩进
          },
        },
        pickers = {
          find_files = {
            hidden = true, -- 显示隐藏文件
            follow = true, -- 跟随符号链接
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          buffers = {
            sort_mru = true, -- 最近使用的排在前面
            sort_lastused = true,
            ignore_current_buffer = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- 模糊搜索
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case", -- 智能大小写
          },
        },
      })
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      -- 加载 FZF 扩展
      require("telescope").load_extension("fzf")
    end,
  },
}
