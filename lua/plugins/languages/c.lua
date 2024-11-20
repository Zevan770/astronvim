-- if true then return {} end
if vim.fn.has "win" == 1 then return {} end

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.cpp" },
  },
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
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
    opts = {},
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          maps.n["<leader>cc"] = { function() require("cmake-tools").build_current_file() end, desc = "Build" }
        end,
      },
    },
  },
}
