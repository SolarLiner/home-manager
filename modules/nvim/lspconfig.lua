-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>fs', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require 'lspconfig'.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.nixd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require 'lspconfig'.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require 'lspconfig'.wgsl_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require 'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    runtime = {
        version = "LuaJIT",
    },
    diagnostics = {
        globals = { "vim" },
    },
    workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
    },
}

require 'lspconfig'.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.slint_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '(d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ')d', vim.diagnostic.goto_next, opts)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
