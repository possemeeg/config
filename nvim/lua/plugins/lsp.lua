return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Enable official HashiCorp terraform language server using the new API
    vim.lsp.config("terraformls", {})

    -- Auto-format .tf files on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.tf", "*.tfvars" },
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
