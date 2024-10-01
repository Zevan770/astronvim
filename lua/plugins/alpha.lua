return {
  "goolord/alpha-nvim",
  -- enabled = false,
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    local dashboard = require "alpha.themes.dashboard"

    -- stylua: ignore
    dashboard.section.buttons.val = {
      -- dashboard.button("LDR q  ", get_icon("Quit", 2, true)        .. "Quit  "),
      dashboard.button("LDR n  ", get_icon("FileNew", 2, true)     .. "New File  "),
      dashboard.button("LDR f f", get_icon("Search", 2, true)      .. "Find File  "),
      dashboard.button("LDR f r", get_icon("DefaultFile", 2, true) .. "Recents  "),
      dashboard.button("LDR s p", get_icon("WordFile", 2, true)    .. "Find Word  "),
      dashboard.button("LDR f '", get_icon("Bookmarks", 2, true)   .. "Bookmarks  "),
      dashboard.button("LDR p L", get_icon("Refresh", 2, true)     .. "Last Session  "),
    }
    return opts
  end,
}
