local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write buffer" })
map("n", "<leader>q", "<cmd>confirm quit<CR>", { desc = "Quit window" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus left" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus down" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus up" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus right" })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

map("n", "<leader>e", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "Explore files" })

map("n", "<leader>ff", function()
  MiniPick.builtin.files()
end, { desc = "Find files" })
map("n", "<leader>fg", function()
  MiniPick.builtin.grep_live()
end, { desc = "Find text" })
map("n", "<leader>fb", function()
  MiniPick.builtin.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
  MiniPick.builtin.help()
end, { desc = "Find help" })

map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git blame line" })
