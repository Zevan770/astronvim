local H = {}

H.ft_builder = function()
  local res = {}
  local plain_text_fts = { "log", "help", "text", "norg", "json", "toml", "yaml", "csv" }
  plain_text_fts = require("astrocore").extend_tbl(plain_text_fts, require("utils.filetype").markdown_like)
  vim.tbl_map(function(ft) res[ft] = "any" end, plain_text_fts)

  -- stylua: ignore
  local comment_fts = {
    "lua", "python", "javascript", "typescript",
    "c",   "cpp",    "java",       "rust", "go", "lua",
  }

  for _, ft in ipairs(comment_fts) do
    res[ft] = { "comment", "string" } ---@diagnostic disable-line: unused-local
  end
  return res
end

---@type LazySpec
return {
  {
    "FluxxField/bionic-reading.nvim",
    event = "User AstroFile",
    opts = function()
      local opts = {
        -- determines if the file types below will be
        -- automatically highlighted on buffer open
        auto_highlight = true,
        -- the file types you want to highlight with
        -- the node types you would like to target
        -- using treesitter
        file_types = H.ft_builder(),
        -- the highlighting styles applied as val to nvim_set_hl()
        -- Please see :help nvim_set_hl() to see vals that can be passed
        hl_group_value = {
          bold = true,
        },
        -- Flag used to control if the user is prompted
        -- if BRToggle is called on a file type that is not
        -- explicitly defined above
        prompt_user = true,
        -- Enable or disable the use of treesitter
        treesitter = true,
        -- Flag used to control if highlighting is applied as
        -- you type
        update_in_insert_mode = false,
      }
      return opts
    end,
    config = function(_, opts) require("bionic-reading").setup(opts) end,
    keys = {
      { "<leader>uo", "<Cmd>BRToggle<CR>" },
    },
  },
}
