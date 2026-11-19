vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
}, { confirm = false })

require("mini.ai").setup({ n_lines = 500 })
require("mini.comment").setup()
require("mini.files").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
require("mini.surround").setup()

require("mini.base16").setup({
  palette = {
    base00 = "#070B0D",
    base01 = "#152228",
    base02 = "#1F243D",
    base03 = "#3A4356",
    base04 = "#5C5855",
    base05 = "#D6E0E4",
    base06 = "#A1F0FF",
    base07 = "#A2FBBD",
    base08 = "#FB4B63",
    base09 = "#FA8C48",
    base0A = "#F0DD7D",
    base0B = "#58EE85",
    base0C = "#00CDE8",
    base0D = "#20A1F7",
    base0E = "#F498FD",
    base0F = "#40B078",
  },
})

local which_key = require("which-key")
which_key.setup()
which_key.add({
  { "<leader>c", group = "code" },
  { "<leader>f", group = "find" },
  { "<leader>g", group = "git" },
})
require("gitsigns").setup()

require("conform").setup({
  formatters_by_ft = {
    go = { "gofmt" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    python = { "ruff_format", "black", stop_after_first = true },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
  },
  default_format_opts = {
    lsp_format = "fallback",
    timeout_ms = 1000,
  },
})

require("config.treesitter").setup()
