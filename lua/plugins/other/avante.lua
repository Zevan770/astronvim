---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "User AstroFile", -- load on file open because Avante manages it's own bindings
    specs = {
      { "stevearc/dressing.nvim", optional = true },
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { -- if copilot.lua is available, default to copilot provider
        "zbirenbaum/copilot.lua",
        optional = true,
        specs = {
          {
            "yetone/avante.nvim",
            opts = {
              provider = "copilot",
              auto_suggestions_provider = "copilot",
            },
          },
        },
      },
      {
        "saghen/blink.cmp",
        dependencies = {
          "Kaiser-Yang/blink-cmp-avante",
        },
        opts = {
          sources = {
            -- Add 'avante' to the list
            default = { "avante" },
            providers = {
              avante = {
                module = "blink-cmp-avante",
                name = "Avante",
                opts = {
                  -- options for blink-cmp-avante
                },
              },
            },
          },
        },
      },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts) opts.mappings.n["<Leader>ai"] = { desc = " Avante" } end,
      },
    },
    keys = {
      "<Leader>ai",
    },
    ---@module "avante"
    ---@type avante.Config
    opts = {
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      rag_service = {
        enabled = false, -- Enables the RAG service
        host_mount = os.getenv "HOME", -- Host mount path for the rag service
        provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
        llm_model = "deepseek-chat", -- The LLM model to use for RAG service
        embed_model = "text-embedding-v3", -- The embedding model to use for RAG service
        endpoint = "http://localhost:3000", -- The API endpoint for RAG service
      },
      mappings = {
        ---@type AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        cancel = {
          normal = { "<C-c>", "<Esc>", "q" },
          insert = { "<C-c>" },
        },
        -- NOTE: The following will be safely set by avante.nvim
        ask = "<leader>aia",
        new_ask = "<leader>ain",
        edit = "<leader>aie",
        refresh = "<leader>air",
        focus = "<leader>aif",
        stop = "<leader>aiS",
        toggle = {
          default = "<leader>aitt",
          debug = "<leader>aitd",
          hint = "<leader>aith",
          suggestion = "<leader>aits",
          repomap = "<leader>aitR",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<a-j>",
          reverse_switch_windows = "<a-k>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
        files = {
          add_current = "<leader>aic", -- Add current buffer to selected files
          add_all_buffers = "<leader>aiB", -- Add all buffer files to selected files
        },
        select_model = "<leader>aim", -- Select model command
        select_history = "<leader>aih", -- Select history command
      },
      hints = {
        enabled = false,
      },
      windows = {
        -- position = "smart",
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width in vertical layout
        height = 30, -- default % based on available height in horizontal layout
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          border = { " ", " ", " ", " ", " ", " ", " ", " " },
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = true, -- Open the 'AvanteAsk' prompt in a floating window
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the ask window
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },

      provider = "copilot",
      providers = {
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          model = "claude-3.5-sonnet",
          proxy = nil, -- [protocol://]host[:port] Use this proxy
          allow_insecure = false, -- Allow insecure server connections
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            -- temperature = 0,
            -- max_tokens = 20480,
          },
        },
        ["copilot-claude-3.7"] = {
          __inherited_from = "copilot",
          model = "claude-3.7-sonnet",
        },
      },
    },
  },
}
