if true then return {} end
return {
  "ivanjermakov/troublesum.nvim",
  event = "LSPAttach",
  opts = function()
    local get_icon = require("astroui").get_icon
    return {
      severity_format = {
        get_icon "DiagnosticError",
        get_icon "DiagnosticInfo",
        get_icon "DiagnosticWarn",
        get_icon "DiagnosticHint",
      },
    }
  end,
}
