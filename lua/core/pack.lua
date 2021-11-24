-- packer: plugins manager
local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require('core.global').vim_path
local data_dir = require('core.global').data_dir
local modules_dir = vim_path .. '/lua/modules'
local packer_compiled = data_dir .. 'packer_compiled.vim'
local compile_to_lua = data_dir .. 'lua/_compiled.lua'
local packer = nil

local function init_ensure_plugins()
    local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
    local state = uv.fs_stat(packer_dir)
    if not state then
        local cmd = "!git clone https://github.com/wbthomason/packer.nvim " ..
                        packer_dir
        api.nvim_command(cmd)
        uv.fs_mkdir(data_dir .. 'lua', 511,
                    function() assert("make compile path dir faield") end)
    end
end

local function startup_plugins()
    if not packer then
        api.nvim_command('packadd packer.nvim')
        packer = require('packer')
    end
    packer.startup(function(use)
        -- Packer can manage itself
        use {'wbthomason/packer.nvim', opt = true}

        use {'nvim-lualine/lualine.nvim'}
        use {
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require("bufferline").setup {} end
        }

        use {
            'eddyekofo94/gruvbox-flat.nvim',
            config = require('pconfigs.gruvbox_flat')
        }

        use {
            'neovim/nvim-lspconfig',
            event = 'BufReadPre',
            config = require('pconfigs.lsp_config')
        }

        use {
            'tami5/lspsaga.nvim',
            branch = 'nvim51',
            cmd = 'Lspsaga',
            config = require('pconfigs.lspsaga')
        }

        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim'
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            event = 'BufRead',
            after = 'telescope.nvim',
            config = require('pconfigs.nvim_treesitter')
        }

        use {
            "hrsh7th/nvim-cmp",
            requires = {
                'L3MON4D3/LuaSnip', -- Snippets plugin
                'hrsh7th/cmp-nvim-lsp', -- Source nvim lsp
                'ray-x/lsp_signature.nvim', -- LSP Signature
                'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
                'hrsh7th/cmp-path'
            },
            config = require('pconfigs.complete')
        }

        use {
            'ray-x/go.nvim',
            ft = {'go'},
            config = function() require('go').setup() end
        }

        use {
            {'nvim-lua/plenary.nvim'},
            {'nvim-lua/popup.nvim'},
            config = function()
                require('telescope').register_extension {
                    exports = {goimpl = require('custom.lang.go').goimpl}
                }
            end
        }

        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            opt = true,
            cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
            config = require('pconfigs.nvim_tree')
        }

        use {
            'phaazon/hop.nvim',
            branch = 'v1', -- optional but strongly recommended
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
                require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
            end
        }

        use {
          'windwp/nvim-autopairs',
          config = function() require('nvim-autopairs').setup{} end
        }

        use {'kdheepak/lazygit.nvim'}

        -- TODO config
        use {"akinsho/toggleterm.nvim", config = function () require("toggleterm").setup{} end }

        use {
            "blackCauldron7/surround.nvim",
            config = function()
              require"surround".setup {mappings_style = "surround"}
            end
        }
		
        use {'liuchengxu/vista.vim', config=require('pconfigs.vista')}

        use {'b3nj5m1n/kommentary', config=function() require('kommentary.config').use_extended_mappings() end}

        use {'yamatsum/nvim-cursorline'}

        use {'airblade/vim-rooter', config=function() vim.api.nvim_command[[autocmd BufEnter * :Rooter]] end}

        use {
            "NTBBloodbath/rest.nvim",
            ft={'http'},
            requires = { "nvim-lua/plenary.nvim" },
            config = require('pconfigs.rest')
        }
		
		-- rust-tools
		use {'simrat39/rust-tools.nvim',
			ft = {'rust'},
			config=function()
				require('rust-tools').setup({})
			end
		}
    end)
end

init_ensure_plugins()
startup_plugins()
