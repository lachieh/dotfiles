local group = vim.api.nvim_create_augroup("personal_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight text after yanking it",
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  desc = "Return to the last edit position",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "Use Treesitter highlighting when a parser is available",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
