-- if true then return {} end
return {
  "folke/todo-comments.nvim",
  ---@diagnostic disable: missing-fields
  ---@module "todo-comments"
  ---@type TodoOptions
  opts = {
    keywords = {
      region = {
        icon = " ",
        color = "default",
        alt = { [[region]], [[endregion]] },
      },
    },
  },
}
