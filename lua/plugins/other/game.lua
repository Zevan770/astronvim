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
    enabled = true,
  },
  {
    "Eandrju/cellular-automaton.nvim",
    lazy = true,
    cmd = "CellularAutomaton",
  },
  {
    "iqxd/vim-mine-sweeping",
    cmd = "MineSweep",
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
  {
    "vuciv/golf",
    cmd = "Golf",
  },
  {
    "jim-fx/sudoku.nvim",
    cmd = "Sudoku",

    opts = {
      mappings = {
        { key = "1", action = "insert=1" },
        { key = "2", action = "insert=2" },
        { key = "3", action = "insert=3" },
        { key = "4", action = "insert=4" },
        { key = "5", action = "insert=5" },
        { key = "6", action = "insert=6" },
        { key = "7", action = "insert=7" },
        { key = "8", action = "insert=8" },
        { key = "9", action = "insert=9" },
        { key = "0", action = "clear_cell" },
      },
    },
  },
  { "rktjmp/playtime.nvim", cmd = { "Playtime" }, opts = { fps = 60 } },
  { "nvzone/typr", cmd = "TyprStats", dependencies = "nvzone/volt", opts = {} },
  {
    "NStefan002/2048.nvim",
    cmd = "Play2048",
    config = true,
    opts = {
      keys = {
        up = "<Up>",
        down = "<Down>",
        left = "<Left>",
        right = "<Right>",
        undo = "<C-z>",
      },
    },
  },
}
