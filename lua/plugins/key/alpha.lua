if true then return {} end
return {
  "goolord/alpha-nvim",
  -- enabled = false,
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    local dashboard = require "alpha.themes.dashboard"

    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("q", get_icon("TabClose", 2, true)        .. "Quit  ",                "<Leader>q",  { remap = true }),
      dashboard.button("n", get_icon("FileNew", 2, true)     .. "New File  ",            "<Leader>n" , { remap = true }),
      dashboard.button("f", get_icon("Search", 2, true)      .. "File Search In Project  ", "<Leader>pf", { remap = true }),
      dashboard.button("r", get_icon("DefaultFile", 2, true) .. "Recents File  ",        "<Leader>fr", { remap = true }),
      dashboard.button("s", get_icon("WordFile", 2, true)    .. "Search Text In Project",   "<Leader>ss", { remap = true }),
      dashboard.button("'", get_icon("Bookmarks", 2, true)   .. "Bookmarks  ",           "<Leader>f'", { remap = true }),
      dashboard.button("l", get_icon("Refresh", 2, true)     .. "Last Session  ",        "<Leader>pl", { remap = true }),
      dashboard.button("e", get_icon("Eye", 2, true)        .. "Explorer pwd  ",           "<leader>ay", { remap = true }),
    }
    return opts
  end,
}
