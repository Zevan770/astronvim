---@type LazySpec
return {
  {
    "mikavilpas/blink-ripgrep.nvim",
    -- enabled = false,
    init = function()
      local original_get_command = require("blink-ripgrep.backends.ripgrep.ripgrep_command").get_command
      -- HACK: monkey patch 函数
      require("blink-ripgrep.backends.ripgrep.ripgrep_command").get_command = function(prefix, options)
        local root = vim.uv.cwd()

        if vim.g.blink_ripgrep_disabled then return nil end

        -- 检查文件数量（只在第一次检查）
        if vim.g.blink_ripgrep_checked ~= root then
          vim.notify "starting fd"
          vim.system(
            { "sh", "-c", string.format("fd --max-results 100000 . %s 2>/dev/null | wc -l", root) },
            { text = true },
            function(out)
              local count = tonumber(out.stdout) or 0
              if count >= 100000 then require("blink-ripgrep").config.mode = "off" end
              vim.g.blink_ripgrep_checked = root
            end
          )
          return nil
        end

        -- 复用原有逻辑
        return original_get_command(prefix, options)
      end
    end,
    dependencies = {
      {
        "Saghen/blink.cmp",
        dependencies = { "mikavilpas/blink-ripgrep.nvim" },
        ---@type blink.cmp.Config
        opts = {
          sources = {
            default = { "ripgrep" },
            providers = {
              -- 👇🏻👇🏻 add the ripgrep provider config below
              ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                score_offset = -99, -- NOTE: score_offset is 0 by default
                -- the options below are optional, some default values are shown
                ---@module "blink-ripgrep"
                ---@type blink-ripgrep.Options
                opts = {
                  -- debug = true,
                  prefix_min_len = 3,
                  fallback_to_regex_highlighting = true,
                  project_root_marker = ".git",
                  toggles = {
                    on_off = "<Leader>ubg",
                    debug = "<Leader>ubd",
                  },
                  backend = {
                    context_size = 5,
                    use = "ripgrep",
                    ripgrep = {
                      max_filesize = "1M",
                      project_root_fallback = true,
                      search_casing = "--ignore-case",
                      additional_rg_options = {},
                      ignore_paths = {},
                      additional_paths = {},
                    },
                  },
                },
              },
            },
          },
          keymap = {
            ["<a-g>"] = {
              function()
                -- invoke manually, requires blink >v0.8.0
                require("blink.cmp").show { providers = { "ripgrep" } }
              end,
            },
          },
        },
      },
    },
  },
}
