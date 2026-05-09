--- 提供 hjkl 和方向键之间的互相映射
local M = {}

M.to_arrow = {
  h = "left",
  j = "down",
  k = "up",
  l = "right",
}

M.to_hjkl = {
  left = "h",
  down = "j",
  up = "k",
  right = "l",
}

-- available functions in require("coerce.case")
-- to_camel_case
-- to_dot_case
-- to_kebab_case
-- to_numerical_contraction
-- to_pascal_case
-- to_snake_case
-- to_upper_case
-- to_path_case
-- to_space_case

return M
