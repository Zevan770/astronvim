return {
  "duqcyxwd/stringbreaker.nvim",
  opts = {
    preview = {
      max_length = 1000, -- Maximum preview content length
      use_float = true, -- Use floating window for preview
      width = 100, -- Floating window width
      height = 4, -- Floating window height
    },
  },
  keys = {
    {
      "<space>ibe",
      function() require("string-breaker").break_string() end,
      mode = { "n", "v" },
      desc = "Break string for editing",
    },
    {
      "<space>ibp",
      function() require("string-breaker").preview() end,
      mode = { "n", "v" },
      desc = "Preview string content",
    },
  },
  config = function(_, opts)
    require("string-breaker").setup(opts)
    local stringBreaker = require "string-breaker"
    -- Auto-keybindings in string editor buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "stringBreaker",
      callback = function()
        local opts = { buffer = true, silent = true }
        vim.keymap.set("n", "<C-s>", stringBreaker.save, opts)
        vim.keymap.set("n", "<C-c>", stringBreaker.cancel, opts)
      end,
    })
  end,
}
