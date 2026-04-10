if true then return {} end
return {
  "pu-007/im-select-ahk.nvim",
  event = { "InsertEnter", "InsertLeave", "CmdlineEnter", "CmdlineLeave", "ModeChanged" },
  opts = {
    -- 可选配置，以下为默认值
    exe_path = "im-select-ahk.exe",
    toggle_key = "RShift", -- 回退模式的切换键
    ime_timeout = 2500, -- SendMessage 超时时间 (ms)
    async = true, -- 异步执行（推荐）
    mode_config = {
      normal = "always_en", -- Normal 模式始终英文
      insert = "restore", -- Insert 模式记忆恢复
      cmdline = "restore", -- Command-line 模式记忆恢复
      search = "restore", -- 搜索模式记忆恢复
      visual = false, -- Visual 模式不干预
      replace = "restore", -- Replace 模式记忆恢复
      terminal = false, -- Terminal 模式不干预
      select = false, -- Select 模式不干预
    },
  },
}
