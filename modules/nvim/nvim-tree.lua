require 'nvim-tree'.setup {
  sort_by = function(left, right)
    left = left.name:lower()
    right = right.name:lower()

    if left == right then
      return false
    end

    for i = 1, math.max(string.len(left), string.len(right)), 1 do
      local l = string.sub(left, i, -1)
      local r = string.sub(right, i, -1)

      if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
        local l_number = tonumber(string.match(l, "^[0-9]+"))
        local r_number = tonumber(string.match(r, "^[0-9]+"))

        if l_number ~= r_number then
          return l_number < r_number
        end
      elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
        return l < r
      end
    end
  end,
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
