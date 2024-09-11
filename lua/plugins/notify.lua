-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts) opts.timeout = 500 end,
  },
}
