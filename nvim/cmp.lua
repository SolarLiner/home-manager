-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require'snippy'.expand_snippet(args.body) -- For `snippy` users.
            end,
        },
        mapping = {
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
                { name = 'path' },
                { name = 'buffer' },
                { name = 'crates' },
                { name = 'nvim_lsp' },
                { name = 'snippy' },
            }),
        experimental = { ghost_text = false }
    })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
    })
