return {
  "chrisgrieser/nvim-chainsaw",
  opts = {
    visuals = {
      icon = "󰹈",
    },
    preCommitHook = {
      enabled = true,
      dontInstallInDirs = { "**/nvim-chainsaw" }, -- plugin dir itself, when developing it
    },
    logStatements = {
      variableLog = {
        nvim_lua = "Chainsaw({{var}}) -- {{marker}}", -- nvim lua debug
        lua = 'print("{{marker}} {{var}}: " .. hs.inspect({{var}}))', -- Hammerspoon
        swift = 'fputs("{{marker}} {{var}}: \\({{var}})", stderr)', -- to STDERR, requires `import Foundation`
      },
      assertLog = {
        lua = 'assert({{var}}, "{{insert}}")', -- no marker, since intended to be permanent
      },
      objectLog = { -- re-purposing `objectLog` for alternative log statements for these
        -- Obsidian Notice
        typescript = "new Notice(`{{marker}} {{var}}: ${{{var}}}`, 0)",
        -- AppleScript notification
        zsh = 'osascript -e "display notification \\"{{marker}} ${{var}}\\" with title \\"{{var}}\\""',
        -- simple print statements for `snacks`' scratch buffer
        nvim_lua = "print({{var}}) -- {{marker}}",
        -- Hammerspoon: alert
        lua = 'hs.alert.show("{{marker}} {{var}}: " .. hs.inspect({{var}}))',
      },
      clearLog = { -- Hammerspoon
        lua = "hs.console.clearConsole() -- {{marker}}",
      },
      sound = { -- Hammerspoon
        lua = 'hs.sound.getByName("Sosumi"):play() ---@diagnostic disable-line: undefined-field -- {{marker}}',
      },
    },
  },
  config = function(_, opts) require("chainsaw").setup(opts) end,
  init = function()
    -- lazyload chainsaw only when `Chainsaw` function is called
    _G.Chainsaw = function(name) ---@diagnostic disable-line: duplicate-set-field
      require "chainsaw" -- load nvim-chainsaw, will override `_G.Chainsaw`
      Chainsaw(name) -- call original function
    end
  end,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(spec, opts)
        local maps = opts.mappings
        maps.n["<Leader>il"] = { desc = "Log" }
      end,
    },
  },
  keys = {
		-- stylua: ignore start
		{ "<leader>ilr", function() require("chainsaw").removeLogs() end, mode = {"n","x"}, desc = "󰅗 remove logs" },
		{ "<leader>ill", function() require("chainsaw").variableLog() end, mode = {"n","x"}, desc = "󰀫 variable" },
		{ "<leader>ilo", function() require("chainsaw").objectLog() end, mode = {"n","x"}, desc = "⬟ object" },
		{ "<leader>ila", function() require("chainsaw").assertLog() end, mode = {"n","x"}, desc = "󱈸 assert" },
		{ "<leader>ilt", function() require("chainsaw").typeLog() end, mode = {"n","x"}, desc = "󰜀 type" },
    -- stylua: ignore end
    { "<leader>ilm", function() require("chainsaw").messageLog() end, desc = "󰍩 message" },
    { "<leader>ile", function() require("chainsaw").emojiLog() end, desc = " emoji" },
    { "<leader>ils", function() require("chainsaw").sound() end, desc = "󱄠 sound" },
    { "<leader>ilp", function() require("chainsaw").timeLog() end, desc = "󱎫 performance" },
    { "<leader>ild", function() require("chainsaw").debugLog() end, desc = "󰃤 debugger" },
    { "<leader>ilS", function() require("chainsaw").stacktraceLog() end, desc = " stacktrace" },
    { "<leader>ilc", function() require("chainsaw").clearLog() end, desc = "󰃢 clear console" },
  },
}
