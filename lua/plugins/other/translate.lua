---@type LazySpec
return {
  {
    "potamides/pantran.nvim",
    cmd = {
      "Pantran",
    },
    opts = {
      -- Default engine to use for translation. To list valid engine names run
      -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
      default_engine = "google",
      -- Configuration for individual engines goes here.
      engines = {
        google = {
          -- Default languages can be defined on a per engine basis. In this case
          -- `:lua require("pantran.async").run(function() vim.print(require("pantran.engines").google:languages()) end)`
          -- can be used to list available language identifiers.
          fallback = {
            default_source = "auto",
            default_target = "zh-CN",
          },
          -- default_source = "auto",
          -- default_target = "zh-CN",
        },
      },
      controls = {
        mappings = {
          edit = {
            n = {
              -- Use this table to add additional mappings for the normal mode in
              -- the translation window. Either strings or function references are
              -- supported.
              ["j"] = "gj",
              ["k"] = "gk",
            },
            i = {
              -- Similar table but for insert mode. Using 'false' disables
              -- existing keybindings.
              ["<C-y>"] = false,
              ["<C-a>"] = function() require("pantran.ui.actions").yank_close_translation() end,
            },
          },
          -- Keybindings here are used in the selection window.
          select = {
            n = {
              -- ...
            },
          },
        },
      },
    },
  },
  {
    "noir4y/comment-translate.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("comment-translate").setup {
        target_language = "zh-CN",
        translate_service = "google", -- 'google' or 'llm'

        hover = {
          enabled = true,
          delay = 500,
          auto = false,
        },

        immersive = {
          enabled = false,
        },

        cache = {
          enabled = true,
          max_entries = 1000,
        },

        targets = {
          comment = true,
          string = true,
        },

        llm = {
          provider = "ollama", -- 'openai' | 'anthropic' | 'gemini' | 'ollama'
          model = "translategemma:4b",
          api_key = nil, -- not required for ollama
          timeout = 20,
          endpoint = "http://localhost:11434/api/chat", -- optional
        },

        keymaps = {
          hover = "<leader>th",
          hover_manual = "<leader>tc",
          replace = "<leader>tr",
          toggle = "<leader>tt",
        },
      }
    end,
  },
}
