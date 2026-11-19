local M = {}

M.parsers = {
  "bash",
  "css",
  "diff",
  "git_config",
  "git_rebase",
  "gitcommit",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

function M.setup()
  local treesitter = require("nvim-treesitter")
  local installed = {}

  for _, parser in ipairs(treesitter.get_installed()) do
    installed[parser] = true
  end

  local missing = vim.tbl_filter(function(parser)
    return not installed[parser]
  end, M.parsers)

  -- Install quietly during an interactive session. Headless checks stay fast;
  -- `mise run nvim:sync` performs the same work synchronously.
  if #missing > 0 and #vim.api.nvim_list_uis() > 0 then
    treesitter.install(missing)
  end
end

function M.sync()
  require("nvim-treesitter").install(M.parsers):wait(300000)
end

return M
