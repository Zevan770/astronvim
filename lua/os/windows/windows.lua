vim.lsp.enable "dst_lsp"

if vim.fn.executable "pwsh.exe" then
  vim.cmd [[
  set noshelltemp
  let &shell = 'pwsh'
  let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
  let &shellcmdflag .= '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();'
  let &shellcmdflag .= '$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
  let &shellpipe  = '> %s 2>&1'
  set shellquote= shellxquote=
  let &shellcmdflag .= '$PSStyle.OutputRendering = ''PlainText'';'
  " Workaround (may not be needed in future version of pwsh):
  let $__SuppressAnsiEscapeSequences = 1
  ]]
end
return {}
