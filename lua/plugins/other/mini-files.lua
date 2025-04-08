return {

  { import = "astrocommunity.file-explorer.mini-files" },
  {
    "echasnovski/mini.files",
    specs = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          autocmds = {
            mini_files_lsp_operations = {
              {
                event = "User",
                pattern = "MiniFilesBufferCreate",
                desc = "Create mappings to modify target window via split",
                callback = function(args)
                  local buf_id = args.data.buf_id
                  vim.keymap.set(
                    "n",
                    "<C-s>",
                    function() require("mini.files").synchronize() end,
                    { buffer = buf_id, desc = "Synchronize/Save" }
                  )
                end,
              },
            },
          },
        },
      },
    },
  },
}
