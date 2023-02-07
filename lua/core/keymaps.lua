vim.g.mapleader = " "

local map = vim.keymap

-- 插入模式
map.set("i", "jk", "<ESC>")

-- 视觉模式
-- -- 多行移动
map.set("v", "J", ":m '>+1<CR>gv=gv")
map.set("v", "K", ":m '<-2<CR>gv=gv")
map.set("v", "jk", "<ESC>")

-- 正常模式
-- -- 窗口分割
map.set("n", "<leader>sv", "<C-w>v") --水平分割窗口
map.set("n", "<leader>sh", "<C-w>s") --垂直分割窗口

-- -- 高亮或取消高亮
map.set("n", "<leader>nh", ":nohl<CR>")

-- 插件键位映射
-- -- nvim-tree 文档树
map.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- -- bufferline 文件缓冲区
map.set("n", "<A-h>", ":BufferLineCyclePrev<CR>")
map.set("n", "<A-l>", ":BufferLineCycleNext<CR>")
