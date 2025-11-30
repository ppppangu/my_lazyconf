-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ===== 快速保存和退出 =====
-- 注意: <leader>w 在 LazyVim 中是 window 菜单，改用 <leader>fs
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "保存文件" })
map("n", "<leader>fS", "<cmd>wa<cr>", { desc = "保存所有文件" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "全部退出" })

-- ===== 更好的窗口导航 =====
map("n", "<C-h>", "<C-w>h", { desc = "跳到左窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "跳到下窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "跳到上窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "跳到右窗口" })

-- ===== 窗口大小调整 =====
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "增加窗口高度" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "减少窗口高度" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "减少窗口宽度" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "增加窗口宽度" })

-- ===== 更好的缩进（保持选择）=====
map("v", "<", "<gv", { desc = "向左缩进" })
map("v", ">", ">gv", { desc = "向右缩进" })

-- ===== 移动选中的行 =====
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "向下移动行" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "向上移动行" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "向下移动行" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "向上移动行" })

-- ===== 保持光标居中 =====
map("n", "<C-d>", "<C-d>zz", { desc = "向下翻半页" })
map("n", "<C-u>", "<C-u>zz", { desc = "向上翻半页" })
map("n", "n", "nzzzv", { desc = "下一个搜索结果" })
map("n", "N", "Nzzzv", { desc = "上一个搜索结果" })
map("n", "*", "*zzzv", { desc = "搜索当前单词" })
map("n", "#", "#zzzv", { desc = "反向搜索当前单词" })

-- ===== 快速清除搜索高亮 =====
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "清除搜索高亮" })

-- ===== 更好的粘贴（不覆盖寄存器）=====
map("x", "<leader>p", [["_dP]], { desc = "粘贴不覆盖寄存器" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "删除不进寄存器" })

-- ===== 快速替换 =====
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "替换当前单词" })
map("v", "<leader>sR", [[:s/\%V]], { desc = "在选中区域替换" })

-- ===== 快速选择 =====
map("n", "<leader>a", "ggVG", { desc = "全选" })

-- ===== 使文件可执行 =====
map("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "使文件可执行" })

-- ===== 快速打开配置 =====
map("n", "<leader>cv", "<cmd>e $MYVIMRC<cr>", { desc = "打开配置文件" })

-- ===== 终端模式快捷键 =====
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "<C-n>", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", "<cmd>wincmd h<cr>", opts)
  map("t", "<C-j>", "<cmd>wincmd j<cr>", opts)
  map("t", "<C-k>", "<cmd>wincmd k<cr>", opts)
  map("t", "<C-l>", "<cmd>wincmd l<cr>", opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- ===== 缓冲区导航 =====
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "上一个缓冲区" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "下一个缓冲区" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "删除缓冲区" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "关闭其他缓冲区" })

-- ===== 快速跳转 =====
map("n", "gj", "G", { desc = "跳到文件末尾" })
map("n", "gk", "gg", { desc = "跳到文件开头" })

-- ===== 分屏快捷键 =====
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "垂直分屏" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "水平分屏" })

-- ===== 诊断快捷键 =====
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "行诊断" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "下一个诊断" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "上一个诊断" })

-- ===== 查找引用快捷键 =====
-- 可视模式下选中后搜索整个项目
map("v", "<leader>fw", "y<cmd>Telescope grep_string search=<C-r>0<cr>", { desc = "搜索选中内容" })
-- 普通模式下搜索光标下的单词
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "搜索当前单词" })
-- 当前文件内搜索
map("n", "<leader>fW", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "当前文件搜索" })
