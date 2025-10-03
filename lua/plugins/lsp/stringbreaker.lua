return {
  "duqcyxwd/stringbreaker.nvim",
  config = function()
    require("string-breaker").setup {
      preview = {
        max_length = 1000, -- Maximum preview content length
        use_float = true, -- Use floating window for preview
        width = 100, -- Floating window width
        height = 4, -- Floating window height
      },
    }

    local stringBreaker = require "string-breaker"

    --- keybindings example
    vim.keymap.set({ "n", "v" }, "<space>ibe", stringBreaker.break_string, { desc = "Break string for editing" })
    vim.keymap.set({ "n", "v" }, "<space>ibp", stringBreaker.preview, { desc = "Preview string content" })
    vim.keymap.set("n", "<space>ibc", stringBreaker.cancel, { desc = "Cancel string editing" })

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
