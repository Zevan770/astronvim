-- if true then return {} end
local prefix = "<Leader>c"
local astrocore = require "astrocore"

local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require "CopilotChat.actions"
    local items = actions[kind .. "_actions"]()
    if not items then
      astrocore.notify("No " .. kind .. " found on the current line")
      return
    end
    local map = {
      "telescope",
      "fzflua",
      "snacks",
    }
    for _, m in ipairs(map) do
      local ok = astrocore.is_available(m)
      if ok then return require("CopilotChat.integrations." .. m).pick(items) end
    end
    astrocore.notify.error "No picker found"
  end
end

---@type LazySpec
return {
  -- ai/completion
  -- "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- branch = "canary",
    cmd = "CopilotChat",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          maps.n[prefix] = { desc = " Copilot Chat" }
          maps.v[prefix] = { desc = " Copilot Chat" }
        end,
      },
    },
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = "gpt-4",
        auto_insert_mode = true,
        show_help = true,
        question_header = "#   " .. user .. " ",
        answer_header = "#   Copilot ",
        -- window = {
        --   width = 0.4,
        -- },
        chat_autocomplete = true,
        selection = function(source)
          local select = require "CopilotChat.select"
          return select.visual(source) or select.buffer(source)
        end,

        highlight_headers = false,
        error_header = "> [!ERROR] Error",
      }
    end,
    keys = {
      -- { "<c-CR>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      -- { prefix .. "", "", desc = "+Copilot ai", mode = { "n", "v" } },
      {
        prefix .. "o",
        function() return require("CopilotChat").open() end,
        desc = "Open (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        prefix .. "x",
        function() return require("CopilotChat").reset() end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        prefix .. "q",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then require("CopilotChat").ask(input) end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      { prefix .. "d", M.pick "help", desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
      -- Show prompts actions with telescope
      { prefix .. "p", M.pick "prompt", desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"
      vim.treesitter.language.register("markdown", "copilot-chat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
    specs = {
      {
        -- Edgy integration
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          opts.right = opts.right or {}
          table.insert(opts.right, {
            ft = "copilot-chat",
            title = " Copilot Chat",
            size = { width = 50 },
          })
        end,
      },
    },
  },
}
