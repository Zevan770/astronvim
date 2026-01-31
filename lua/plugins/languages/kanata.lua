-- NOTE: enable after server stdio logging issue fixed
if false then vim.lsp.enable "kanata" end
vim.treesitter.language.register("clojure", "kanata")
-- vim.lsp.log.set_level(vim.log.levels.DEBUG)
return {}
