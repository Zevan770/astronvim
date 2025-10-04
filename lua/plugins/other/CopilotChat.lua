if true then return {} end
---@type LazySpec
return {
  -- { import = "astrocommunity.editing-support.copilotchat-nvim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    version = "^3",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
      "CopilotChatDebugInfo",
      "CopilotChatModels",
      "CopilotChatAgents",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatFixTests",
      "CopilotChatCommit",
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = opts.options.g.copilot_chat_prefix or "<Leader>c"
          local astroui = require "astroui"

          maps.n[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }
          maps.v[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }

          maps.n[prefix .. "o"] = { "<Cmd>CopilotChatOpen<CR>", desc = "Open Chat" }
          maps.v[prefix .. "o"] = maps.n[prefix .. "o"]
          maps.n[prefix .. "c"] = { "<Cmd>CopilotChatClose<CR>", desc = "Close Chat" }
          maps.n[prefix .. "t"] = { "<Cmd>CopilotChatToggle<CR>", desc = "Toggle Chat" }
          maps.n[prefix .. "r"] = { "<Cmd>CopilotChatReset<CR>", desc = "Reset Chat" }
          maps.n[prefix .. "s"] = { "<Cmd>CopilotChatStop<CR>", desc = "Stop Chat" }

          maps.n[prefix .. "S"] = {
            function()
              vim.ui.input({ prompt = "Save Chat: " }, function(input)
                if input ~= nil and input ~= "" then require("CopilotChat").save(input) end
              end)
            end,
            desc = "Save Chat",
          }

          maps.n[prefix .. "L"] = {
            function()
              local copilot_chat = require "CopilotChat"
              local path = copilot_chat.config.history_path
              local chats = require("plenary.scandir").scan_dir(path, { depth = 1, hidden = true })
              -- Remove the path from the chat names and .json
              for i, chat in ipairs(chats) do
                chats[i] = chat:sub(#path + 2, -6)
              end
              vim.ui.select(chats, { prompt = "Load Chat: " }, function(selected)
                if selected ~= nil and selected ~= "" then copilot_chat.load(selected) end
              end)
            end,
            desc = "Load Chat",
          }

          local function select_action(selection_type)
            return function()
              require("CopilotChat").select_prompt { selection = require("CopilotChat.select")[selection_type] }
            end
          end

          maps.n[prefix .. "p"] = {
            select_action "buffer",
            desc = "Prompt actions",
          }

          maps.v[prefix .. "p"] = {
            select_action "visual",
            desc = "Prompt actions",
          }

          local function quick_chat(selection_type)
            return function()
              vim.ui.input({ prompt = "Quick Chat: " }, function(input)
                if input ~= nil and input ~= "" then
                  require("CopilotChat").ask(input, { selection = require("CopilotChat.select")[selection_type] })
                end
              end)
            end
          end

          maps.n[prefix .. "q"] = {
            quick_chat "buffer",
            desc = "Quick Chat",
          }

          maps.v[prefix .. "q"] = {
            quick_chat "visual",
            desc = "Quick Chat",
          }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { CopilotChat = "" } } },
    },
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = "claude-3.7-sonnet",
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
