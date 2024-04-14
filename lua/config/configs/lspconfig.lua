local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local servers = {
  "html",
  "tsserver",
  "cssls",
  "bashls",
  "clangd",
  "pyright",
  "emmet_ls",
  "jsonls",
  "lua_ls",
}

for _, server in pairs(servers) do
  local opts = {
    capabilities = capabilities,
  }

  local require_ok, conf_opts = pcall(require, "config.configs.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
