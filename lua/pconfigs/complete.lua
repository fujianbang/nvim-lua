local config = function()
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    
    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noselect'
    
    -- luasnip setup
    local luasnip = require 'luasnip'
    
    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup {
    --   snippet = {
    --     expand = function(args)
    --       require('luasnip').lsp_expand(args.body)
    --     end,
    --   },
      mapping = {
        -- ['<C-j>'] = cmp.mapping.select_prev_item(),
        -- ['<C-k>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },

        ['<C-j>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        ['<C-k>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
end

return config