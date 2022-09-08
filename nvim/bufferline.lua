vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    numbers = "buffer_id",
    name_formatter = function(buf)
      if buf.name:match '%.md' then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
  }
}
