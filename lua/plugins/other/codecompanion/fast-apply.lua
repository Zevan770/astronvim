---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "e2r2fx/codecompanion-fast-apply.nvim" },
    opts = {
      extensions = {
        fast_apply = {
          enabled = true,
          opts = {
            -- adapter = "openai_compatible",
            model = "morph-v3-large",
            url = "https://api.morphllm.com/v1",
            api_key = os.getenv "MORPH_API_KEY",
          },
        },
      },
    },
  },
}
