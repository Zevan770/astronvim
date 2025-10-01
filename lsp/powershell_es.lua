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
