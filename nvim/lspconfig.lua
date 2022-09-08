require'lspconfig'.rnix.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.sumneko_lua.setup{
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

vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 150;
  source_timeout = 300;
  incomplete_delay = 500;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    tags = true;
    treesitter = true;
  };
}

vim.keymap.set({"i","n"}, "<Tab>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end)
