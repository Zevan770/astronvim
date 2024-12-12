---@type LazySpec
return {
  {
    "johngrib/vim-game-snake",
    cmd = "VimGameSnake",
    enabled = true,
  },
  {
    "johngrib/vim-game-code-break",
    cmd = "VimGameCodeBreak",
    enabled = false,
  },
  {
    "Eandrju/cellular-automaton.nvim",
    lazy = true,
    cmd = "CellularAutomaton",
  },
}
