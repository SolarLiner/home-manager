require 'nvim-tree'.setup {
    system_open = {
        cmd = "xdg-open",
    },
    diagnostics = {
        enable = true,
    },
    git = {
        enable = true,
        ignore = false,
    },
    filters = {
        custom = {
            [[\\.git]],
            [[node_modules]]
        },
    },
    renderer = {
        special_files = {
            "LICENSE",
            "README.md",
            "Cargo.toml",
            "Makefile",
        },
    },
    on_attach = function(bufnr)
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        local ok, api = pcall(require, "nvim-tree.api")
        assert(ok, "api module is not found")
        vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts("Tab drop"))
    end
}

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        require("nvim-tree.api").tree.open()
    end
})

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {})
