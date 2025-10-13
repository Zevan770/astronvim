local snippet_path = vim.fn.stdpath "config" .. "/snippets"
return {
  {
    "chrisgrieser/nvim-scissors",
    event = "InsertEnter",
    opts = {
      snippetDir = snippet_path,
    },
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      enable_autosnippets = true,
    },
    config = function(...)
      require "astronvim.plugins.configs.luasnip"(...)
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { snippet_path },
      }
    end,
  },
  {
    "TwIStOy/luasnip-snippets",
    dependencies = { "L3MON4D3/LuaSnip" },
    event = { "InsertEnter" },
    config = function()
      -- register all snippets into LuaSnip
      require("luasnip-snippets").setup(
        ---@type LSSnippets.Config
        {
          user = {
            -- user's name, used in todo-related snippets now
            name = nil,
          },
          snippet = {
            lua = {
              -- enable neovim related snippets in lua
              vim_snippet = true,
            },
            cpp = {
              quick_type = {
                -- use `std::unordered_map` instead of `absl::flat_hash_map`
                extra_trig = {
                  { trig = "m", params = 2, template = "std::unordered_map<%s, %s>" },
                },
                -- enable qt-related snippets
                qt = true,
                -- whether to add cpplint related comments in some snippets
                cpplint = true,
              },
            },
            rust = {
              -- add `#[rstest]` to test function's attribute choices, if the test mod has already use `rstest` directly
              rstest_support = false,
            },
          },
          disable_auto_expansion = {
            -- disable these snippets' auto expansion
            -- cpp = { "i32", "i64" },
          },
          disable_langs = {
            -- disable these language's snippets
            -- "dart"
          },
        }
      )
    end,
  },
}
