if true then return {} end
---@type LazySpec
return {
  -- {
  --   "AstroNvim/astrocommunity",
  --   import = "astrocommunity.motion.leap-nvim",
  -- },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat",
    },
    opts = function(self, opts)
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")

      vim.keymap.set(
        { "x", "n", "o" },
        "s",
        function()
          require("leap").leap {
            target_windows = { vim.api.nvim_get_current_win() },
          }
        end
      )

      vim.keymap.set(
        { "x", "n", "o" },
        "S",
        function()
          require("leap").leap {
            target_windows = require("leap.util").get_enterable_windows(),
          }
        end
      )

      -- I only use remote operations via operating pending mode. This allows me to
      -- save wasting another key in my normal mode mappings.
      vim.keymap.set({ "n", "o" }, "gs", function() require("leap.remote").action() end)

      -- This mapping is what LazyVim uses for the built-in treesitter plugin
      -- incremental selection, so using it doesn't waste another key in my
      -- configuration as I already had this one bound to the same function..
      vim.keymap.set({ "n", "x", "o" }, "<C-Space>", function() require("leap.treesitter").select() end)

      -- Automatically paste when doing a remote yank operation.
      vim.api.nvim_create_augroup("LeapRemote", {})
      vim.api.nvim_create_autocmd("User", {
        pattern = "RemoteOperationDone",
        group = "LeapRemote",
        callback = function(event)
          vim.notify(event.data.register)
          -- Do not paste if some special register was in use.
          if vim.v.operator == "y" and event.data.register == "+" then vim.cmd "normal! p" end
        end,
      })
    end,
  },
  {
    "noearc/leap-zh.nvim",
    dependencies = { "noearc/jieba-lua" },
    config = function(self, opts)
      local map = vim.keymap
      map.set("n", "fw", "<cmd>lua require'leap-zh'.leap_jieba()<CR>") -- 搜索当前行的中文词
      map.set("n", "fs", "<cmd>lua require'leap-zh'.leap_zh()<CR>") -- 向下搜索
      map.set("n", "fb", "<cmd>lua require'leap-zh'.leap_zh_bak()<CR>") -- 向上搜索
      map.set("n", "fb", "<cmd>lua require'leap-zh'.leap_zh_all()<CR>") -- 同时向上下搜索，默认先跳转到向后搜素的第一个结果
    end,
  },
  {
    "ggandor/flit.nvim",
    opts = {
      keys = { f = "f", F = "F", t = "t", T = "T" },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "v",
      -- Repeat with the trigger key itself.
      clever_repeat = true,
      multiline = true,
      -- Like `leap`s similar argument (call-specific overrides).
      -- E.g.: opts = { equivalence_classes = {} }
      opts = {},
    },
  },
}
