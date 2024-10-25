---@type LazySpec
return {
  "nvim-pack/nvim-spectre",
  enabled = false,
  opts = function()
    return {
      mapping = {
        send_to_qf = { map = ",q" },
        replace_cmd = { map = ",c" },
        show_option_menu = { map = ",o" },
        run_current_replace = { map = ",r" },
        run_replace = { map = ",R" },
        change_view_mode = { map = "v" },
        resume_last_search = { map = ",l" },
      },
    }
  end,
}
