return {
  "ivanjermakov/troublesum.nvim",
  event = "LSPAttach",
  opts = function()
    local get_icon = require("astroui").get_icon
    return {
      severity_format = {
        get_icon "DiagnosticError",
        get_icon "DiagnosticHint",
        get_icon "DiagnosticWarn",
        get_icon "DiagnosticInfo",
      },
    }
  end,
}
