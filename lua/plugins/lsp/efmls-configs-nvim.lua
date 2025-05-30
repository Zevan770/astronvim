-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
---@type LazySpec
return {
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x", -- version is optional, but recommended
    enabled = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- Register linters and formatters per language
      local gitlint = require "efmls-configs.linters.gitlint"
      local languages = {}

      -- Or use the defaults provided by this plugin
      -- check doc/SUPPORTED_LIST.md for the supported languages
      --
      -- local languages = require('efmls-configs.defaults').languages()

      local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
          rootMarkers = { ".git/" },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      }

      require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
        -- Pass your custom lsp config below like on_attach and capabilities
        --
        -- on_attach = on_attach,
        -- capabilities = capabilities,
      }))
    end,
  },
}
