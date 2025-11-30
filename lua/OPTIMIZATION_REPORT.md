# LazyVim 配置优化报告

## ✅ 已修复的问题

### 1. 重复配置
- [x] `satellite.nvim`: 在 `minimap.lua` 和 `satellite.lua` 重复 → 清空 `satellite.lua`
- [x] `todo-comments.nvim`: 在 `editing-enhanced.lua` 和 `todo-comments.lua` 重复 → 清空 `todo-comments.lua`

### 2. 废弃/过时配置
- [x] `tsserver` 已更名为 `ts_ls` (Neovim 0.10+) → 已更新
- [x] `lsp-inlayhints.nvim` 已废弃 → 改用 Neovim 内置 inlay hints
- [x] 移除了无效的 LSP setup keymaps 配置

### 3. 快捷键冲突
- [x] `<leader>w` 冲突 → 改为 `<leader>fs` (保存文件)
- [x] `rest.lua` 和 `refactoring.lua` 的 `<leader>r*` 冲突 → HTTP 请求改为 `<leader>hr*`
- [x] `toggleterm.lua` 终端快捷键 → 改为 `<leader>T*` 前缀
- [x] `<leader>lh` 重复 → lspsaga hover，inlay hints 改为 `<leader>li`
- [x] Codeium `<C-[>` 冲突 (是 ESC 别名) → 改为 `<M-[>` 和 `<M-]>`
- [x] `<leader>ca` aerial 冲突 → 改为 `<leader>cN`
- [x] `<leader>hr` gitsigns 冲突 → 改为 `<leader>hR`

### 4. Session 管理冲突
- [x] `persistence.nvim` 和 `auto-session` 同时启用 → 禁用 persistence，保留 auto-session

### 5. 懒加载优化
- [x] `aerial.nvim` → `cmd` 触发
- [x] `nvim-dap` → `keys` 触发
- [x] `rainbow-delimiters.nvim` → `event = "LazyFile"`
- [x] `neoscroll.nvim` → `event = "VeryLazy"`
- [x] `gitsigns.nvim` → `event = "LazyFile"`
- [x] `git-conflict.nvim` → `event = "BufReadPost"`
- [x] `multicursors.nvim` → 移除 `lazy = false`
- [x] `refactoring.nvim` → 移除 `lazy = false`
- [x] `toggleterm.nvim` → `event = "VeryLazy"`
- [x] `auto-save.nvim` → `event = { "InsertLeave", "TextChanged" }`

---

## ⚠️ 需要注意的事项

### 1. telescope-media-files
`image.lua` 中的 `telescope-media-files.nvim` 在 Windows 上通常不工作，需要：
- Linux/macOS: 安装 `ueberzug` 或 `chafa`
- Windows: 基本不可用

如果不需要，可以删除这个文件。

### 2. htop 命令
`toggleterm.lua` 中的 htop 快捷键在 Windows 上不可用，已添加平台检测。

### 3. im-select
Windows 输入法切换需要确保 `im-select.exe` 在 PATH 中。

---

## 📋 新的快捷键映射

### 文件操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>fs` | 保存文件 |
| `<leader>fS` | 保存所有文件 |

### 终端 (ToggleTerm)
| 快捷键 | 功能 |
|--------|------|
| `<leader>Tf` | 浮动终端 |
| `<leader>Th` | 水平终端 |
| `<leader>Tv` | 垂直终端 |
| `<leader>Tt` | 标签页终端 |
| `<leader>T1-4` | 终端 1-4 |
| `<leader>Ta` | 切换所有终端 |

### 运行代码
| 快捷键 | 功能 |
|--------|------|
| `<leader>Rp` | 运行 Python |
| `<leader>Ri` | 交互式 Python |
| `<leader>Rn` | 运行 Node |

### HTTP 请求 (Kulala)
| 快捷键 | 功能 |
|--------|------|
| `<leader>hr` | 运行请求 |
| `<leader>hp` | 上一个请求 |
| `<leader>hn` | 下一个请求 |

### LSP
| 快捷键 | 功能 |
|--------|------|
| `<leader>li` | 切换内联提示 |

### 代码大纲 (Aerial)
| 快捷键 | 功能 |
|--------|------|
| `<leader>cN` | 符号导航 |

### AI 建议 (Codeium)
| 快捷键 | 功能 |
|--------|------|
| `<C-g>` | 接受建议 |
| `<M-]>` | 下一个建议 |
| `<M-[>` | 上一个建议 |

---

## 🚀 进一步优化建议

### 1. 如果想进一步提升启动速度：
```lua
-- options.lua
vim.opt.updatetime = 100  -- 可以从 200 降到 100
```

### 2. 考虑移除的插件：
- `image.lua` (Windows 不可用)
- `nvim-silicon` (需要安装 silicon CLI)

### 3. 可选：恢复 matchparen
如果你需要括号匹配高亮，在 `lazy.lua` 的 `disabled_plugins` 中移除 `"matchparen"`。

---

## 验证步骤

1. 重启 Neovim
2. 运行 `:checkhealth` 检查健康状态
3. 运行 `:Lazy` 查看插件状态
4. 测试常用快捷键是否正常
