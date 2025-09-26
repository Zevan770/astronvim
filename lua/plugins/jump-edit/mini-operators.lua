return {
  {
    "echasnovski/mini.operators",
    opts = {
      -- Evaluate text and replace with output
      -- stylua: ignore start
      evaluate = { prefix = "g=", func = nil },
      exchange = { prefix = "gsx", reindent_linewise = true },
      multiply = { prefix = "", func = nil },
      replace  = { prefix = "gsr", reindent_linewise = true },
      sort     = { prefix = "gst", func = nil },
      -- stylua: ignore end
    },
  },
}
