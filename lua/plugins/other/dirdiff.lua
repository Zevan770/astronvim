if true then return {} end
-- NOTE: We have nvim.difftool and Codediff now, both of which are better than these old guys.
---@type LazySpec
return {
  {
    "will133/vim-dirdiff",
    cmd = "DirDiff",
  },
  {
    "taze55/vim-dirdifftree",
    cmd = "DirDiffTree",
  },
}
