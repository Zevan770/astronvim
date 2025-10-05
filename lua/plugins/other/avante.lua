-- if true then return {} end
---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    specs = {
      { "stevearc/dressing.nvim", optional = true },
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
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
    },
    keys = {
      {
        "<leader>a",
        function()
          -- HACK: Super hacky way to lazy-load avante.nvim only when key pressed
          vim.keymap.del({ "n", "v" }, "<leader>a")
          pcall(require("which-key").show, "<leader>a")
        end,
        desc = " Avante",
        mode = { "n", "v" },
      },
    },
    ---@module "avante"
    ---@type avante.Config
    opts = {
      debug = not not os.getenv "avante_debug",
      instructions_file = "AGENT.md",
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      -- rag_service = { -- RAG Service configuration
      --   -- enabled = my_utils.is_nixos, -- Enables the RAG service
      --   -- enabled = my_utils.is_nixos and not os.getenv "avante_no_rag", -- Enables the RAG service
      --   enabled = false,
      --   host_mount = os.getenv "HOME", -- Host mount path for the rag service (Docker will mount this path)
      --   runner = "docker", -- Runner for the RAG service (can use docker or nix)
      --   llm = { -- Language Model (LLM) configuration for RAG service
      --     provider = "openai", -- LLM provider
      --     endpoint = "http://host.docker.internal:4141",
      --     model = "gpt-4o", -- LLM model name
      --     extra = nil, -- Additional configuration options for LLM
      --   },
      --   embed = { -- Embedding model configuration for RAG service
      --     provider = "openai", -- Embedding provider
      --     endpoint = "http://host.docker.internal:4141",
      --     model = "text-embedding-3-small", -- Embedding model name
      --     extra = nil, -- Additional configuration options for the embedding model
      --   },
      -- },
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
          normal = { "<C-c>", "q" },
          insert = { "<C-c>" },
        },
        -- NOTE: The following will be safely set by avante.nvim
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<a-j>",
          reverse_switch_windows = "<a-k>",
          remove_file = "d",
          add_file = "@",
          close = { "q" },
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
      },
      selection = {
        enabled = true,
        hint_display = "none",
      },
      selector = {
        provider = "snacks",
      },
      input = { provider = "snacks" },
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
        ask = {
          floating = true, -- Open the 'AvanteAsk' prompt in a floating window
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the ask window
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },

      provider = "copilot_api",
      providers = {
        -- copilot = {
        --   model = "gpt-4.1",
        --   allow_insecure = false, -- Allow insecure server connections
        --   timeout = 30000, -- Timeout in milliseconds
        --   extra_request_body = {
        --     -- temperature = 0,
        --     -- max_tokens = 20480,
        --   },
        -- },
        copilot_api = {
          __inherited_from = "openai",
          api_key = "",
          endpoint = "http://localhost:4141/v1",
          model = "gpt-4.1",
        },
      },
    },
  },
}
