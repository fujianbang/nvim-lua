local global = require('core.global')

local function bind_option(options)
	vim.cmd [[au FocusGained,BufEnter * :silent! !]] -- file realod
    for k, v in pairs(options) do
        if v == true or v == false then
            vim.cmd('set ' .. k) -- setting boolean options, like: set nu
        else
            vim.cmd('set ' .. k .. '=' .. v) -- setting key value pair options, like: set mouse=a
        end
    end
end

local function load_options()
    -- global options
    local global_local = {
        mouse = 'a'; -- enable mouse
        number = true; -- show line numbers
        relativenumber = false; -- show relative line numbers
        scrolloff = 4; -- always keep 4 lines above and below the cursor
        cursorline = true; -- highlight the line where cursor is at currently
        list = true; -- enable list mode
        listchars = 'tab:| ,trail:.,extends:>,precedes:<'; -- settings tab visuallable
        tabstop = 4; -- 1 tab equals 4 spaces
        shiftwidth = 4; -- setting indention width
        softtabstop = 4;
        autoindent = true; -- auto indent
        smartindent = true; -- smart auto indent
        --smarttab = true;
        --textwidth = 80;
        --colorcolumn    = "80";
        wrap = false; -- do not wrap line when lines longer than the width of the windows
        timeoutlen = 500; -- press a key, waiting how many milliseconds for another key
        ignorecase = true; -- ignore case when searching
        smartcase = true; -- ignorecase is not setted if the search pattern contains upper case
        shortmess = 'aoOTIcF'; -- avoid some prompts caused by file messages
    }

    -- buffer & window options
    local bw_local  = {
    }
  
    if global.is_mac then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = {
                ["+"] = "pbcopy",
                ["*"] = "pbcopy",
            },
        paste = {
            ["+"] = "pbpaste",
            ["*"] = "pbpaste",
        },
        cache_enabled = 0
        }
        vim.g.python_host_prog = '/usr/bin/python'
        vim.g.python3_host_prog = '/usr/local/bin/python3'
    end
    for name, value in pairs(global_local) do
        vim.o[name] = value
    end
    bind_option(bw_local)
  end
  
  load_options()
  
