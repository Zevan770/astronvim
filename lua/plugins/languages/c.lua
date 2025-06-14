-- if true then return {} end
if vim.fn.has "win32" == 1 then return {} end

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.cmake" },
  },
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    ft = { "c", "cpp" },
    -- init = function()
    --   local loaded = false
    --   local function check()
    --     local cwd = vim.fn.getcwd()
    --     if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
    --       require("lazy").load { plugins = { "cmake-tools.nvim" } }
    --       loaded = true
    --     end
    --   end
    --   check()
    --   vim.api.nvim_create_autocmd("DirChanged", {
    --     callback = function()
    --       if not loaded then check() end
    --     end,
    --   })
    -- end,
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
