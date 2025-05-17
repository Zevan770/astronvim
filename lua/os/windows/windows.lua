return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        options = {
          opt = {
            -- shell = vim.fn.executable "pwsh.exe" == 1 and "pwsh.exe" or "powershell.exe",
            -- shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;",
            -- -- shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;",
            -- shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
            -- shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode',
            -- shellquote = "",
            -- shellxquote = "",
          },
        },
      })
    end,
  },
}
