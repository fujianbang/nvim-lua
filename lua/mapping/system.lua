local golbal = require('core.global')
local bind = require('mapping.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

vim.g.mapleader = " " -- 设置空格为leader键

local system_mappings = {
    ['i|df'] = map_cmd('<ESC>'), -- 插入模式下jj返回normal模式
    ['n|<Leader>q'] = map_cr('q'), -- :q
    ['n|<Leader>Q'] = map_cr('qa'), -- :qa
    ['n|<Leader>w'] = map_cr('w'), -- :w
    ['n|<Leader>n'] = map_cr('noh'):with_silent(), -- 取消搜索高亮
    ['n|<'] = map_cmd('<<'):with_noremap(), -- 快捷缩进
    ['n|>'] = map_cmd('>>'):with_noremap(), -- 快捷缩进
    -- motion
    ['n|J']      = map_cmd('5j'):with_noremap(), -- 大写J向下5行
    ['n|K']      = map_cmd('5k'):with_noremap(), -- 大写K向上5行
    ['n|H']      = map_cmd('_'):with_noremap(), -- 大写H跳转到行首
    ['n|L']      = map_cmd('$'):with_noremap(), -- 大写L跳转到行尾
    ['v|H']      = map_cmd('_'):with_noremap(), -- 大写H跳转到行首
    ['v|L']      = map_cmd('$'):with_noremap(), -- 大写L跳转到行尾
    -- window
    ['n|<Leader>|'] = map_cr('vsplit'):with_silent(), -- 垂直分屏
    ['n|<Leader>_'] = map_cr('split'):with_silent(), -- 水平分屏
    ['n|<UP>'] = map_cr('res +5'):with_noremap():with_silent(), -- 增加窗口高度
    ['n|<DOWN>'] = map_cr('res -5'):with_noremap():with_silent(), -- 减小窗口高度
    ['n|<LEFT>'] = map_cr('vertical res +5'):with_noremap():with_silent(), -- 增加窗口宽度
    ['n|<RIGHT>'] = map_cr('vertical res -5'):with_noremap():with_silent(), -- 减小窗口宽度
    -- copy[ctrl+c] paste[ctrl+v] undo[ctrl+z] save[ctrl+s]
    ['|<C-c>'] = map_cmd('"+y'), -- 复制到系统剪切板
    ['n|<C-v>'] = map_cmd('"+p'), -- 从系统剪切板粘贴
    ['v|<C-v>'] = map_cmd('"+p'), -- 从系统剪切板粘贴
    ['i|<C-v>'] = map_cmd('<Esc>"+pa'), -- 从系统剪切板粘贴
    ['n|<C-z>'] = map_cmd('u'), -- 撤销
    -- ['i|<C-z>'] = map_cmd('<Esc>ua'),
    -- ['i|<C-s>'] = map_cmd('<Esc>:w<CR>a'):with_silent(),
}

local mac_mappings = {
    ['n|˙'] = map_cmd('<C-w>h'):with_silent():with_noremap(), -- <option>h 跳转到左侧窗口
    ['n|¬'] = map_cmd('<C-w>l'):with_silent():with_noremap(), -- <option>l 跳转到右侧窗口
    ['n|∆'] = map_cmd('<C-w>j'):with_silent():with_noremap(), -- <option>j 跳转到下方窗口
    ['n|˚'] = map_cmd('<C-w>k'):with_silent():with_noremap(), -- <option>k 跳转到上方窗口
    ['i|ø'] = map_cmd('<ESC>o'):with_noremap(), -- <option>o insert模式下新起一行
}

local non_mac_mappings = {
    ['n|<M-h>'] = map_cmd('<C-w>h'),
    ['n|<M-l>'] = map_cmd('<C-w>l'),
    ['n|<M-j>'] = map_cmd('<C-w>j'),
    ['n|<M-k>'] = map_cmd('<C-w>k'),
    ['i|<M-o>'] = map_cmd('<ESC>o'):with_noremap(), -- new line in insert mode
}

bind.nvim_load_mapping(system_mappings)
if golbal.is_mac then
    bind.nvim_load_mapping(mac_mappings)
else
    bind.nvim_load_mapping(non_mac_mappings)
end
