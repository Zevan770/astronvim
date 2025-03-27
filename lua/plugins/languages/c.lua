-- if true then return {} end
if vim.fn.has "win" == 1 then return {} end

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.cmake" },
  },
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load { plugins = { "cmake-tools.nvim" } }
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then check() end
        end,
      })
    end,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          -- maps.n["<localleader>b"] = { function() require("cmake-tools").build_current_file {} end, desc = "Build" }
          -- maps.n["<localleader>g"] = { "<Cmd>CmakeGenerate<CR>" }
          -- maps.n["<localleader>r"] =
          --   { function() require("cmake-tools").run_current_file {} end, desc = "Cmake Run Cur" }
        end,
      },
    },
  },

  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        my_ft_c_cpp = {
          {
            event = "Filetype",
            pattern = "c",
            callback = function() vim.opt.tabstop = 4 end,
          },
        },
      },
    },
  },
}
