if os.getenv "CLIPBOARD_BUFFER" ~= 1 then
  -- print "normal"
  return {}
end
-- print "clip"
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      notifications = false,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        showtabline = 0,
      },
      g = { -- vim.g.<key>
      },
    },
  },
}
