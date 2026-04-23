if vim.fn.has("nvim-0.12.0") ~= 1 then return {} end
require("vim._core.ui2").enable {
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      list_cmd = "pager",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
}

return {
  {
    "folke/noice.nvim",
    optinal = true,
    enabled = false,
  },
  {
    "rachartier/tiny-cmdline.nvim",
    init = function()
      vim.o.cmdheight = 0
      vim.g.tiny_cmdline = {
        width = { value = "70%" },
        position = {
          y = "0%",
        },
        on_reposition = require("tiny-cmdline").adapters.blink,
        native_types = {},
      }
    end,
  },
}
