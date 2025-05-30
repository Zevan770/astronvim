---@diagnostic disable: duplicate-set-field
--#region  HACK: vim api
vim.deprecate = function() end
vim.fn.executable0 = vim.fn.executable
require("hack.vim_fn_executable").setup()
-- vim.fn.executable = function() return 1 end

-- require "hack_vim_keymap_set"
--#endregion

require "snacks_profiler_setup"
-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- vim.lsp.set_log_level("debug")

require "utils"
require "lazy_setup"
require "polish"
