---@diagnostic disable: missing-fields
if vim.fn.has "unix" == 1 then return {} end
return {
  { import = "astrocommunity.pack.ps1" },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = {
        "powershell_es",
      },
      config = {
        powershell_es = (function()
          local bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services"
          local shell = "pwsh"

          local temp_path = vim.fn.stdpath "cache"
          local function make_cmd()
            if bundle_path ~= nil then
              -- https://github.com/neovim/nvim-lspconfig/pull/3920
              local command_fmt =
                [[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal]]
              local command = command_fmt:format(bundle_path, bundle_path, temp_path, temp_path)
              return { shell, "-NoLogo", "-NoProfile", "-Command", command }
            end
          end

          return {
            bundle_path = bundle_path,
            cmd = make_cmd(),
            shell = shell,
          }
        end)(),
      },
    },
  },
  -- {
  --   "TheLeoP/powershell.nvim",
  --   -- ft = "ps1",
  --   ---@type powershell.user_config
  --   opts = {
  --     capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
  --     bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  --     init_options = {
  --       enableProfileLoading = false,
  --     },
  --     settings = {
  --       enableProfileLoading = false,
  --     },
  --   },
  -- },
}
