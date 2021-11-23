local config = function()
    if vim.fn.has('termguicolors') == 1 then
        vim.o['termguicolors'] = true
    end

    vim.g.gruvbox_flat_style = "hard"
    vim.cmd[[colorscheme gruvbox-flat]]
    require('lualine').setup {
        options = {
          theme = 'gruvbox-flat'
          -- ... your lualine config
        }
      }
end

return config