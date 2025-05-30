return {
  {
    "SunnyTamang/select-undo.nvim",
    opts = {
      persistent_undo = true, -- Enables persistent undo history
      mapping = true, -- Enables default keybindings
      line_mapping = "gu", -- Undo for entire lines
      partial_mapping = "gU", -- Undo for selected characters -- Note: dont use this line as gu can also handle partial undo
    },
  },
}
