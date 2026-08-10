local servers = {
  lua_ls = "lua-language-server",
  ts_ls = "typescript-language-server",
  gopls = "gopls",
  rust_analyzer = "rust-analyzer",
  basedpyright = "basedpyright-langserver",
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = { globals = { "vim" } },
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

for server, executable in pairs(servers) do
  if vim.fn.executable(executable) == 1 then
    vim.lsp.enable(server)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("personal_lsp", { clear = true }),
  desc = "Enable native LSP completion",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    local function lsp_map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
    end

    lsp_map("gd", vim.lsp.buf.definition, "Go to definition")
    lsp_map("K", vim.lsp.buf.hover, "Hover documentation")
    lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    lsp_map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
    lsp_map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
  end,
})

vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { desc = "Trigger completion" })
