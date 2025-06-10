return {
  "monaqa/dial.nvim",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          v = {
            ["+"] = {
              function() return require("dial.map").manipulate("increment", "visual") end,
              desc = "Increment",
            },
            ["-"] = {
              function() return require("dial.map").manipulate("decrement", "visual") end,
              desc = "Decrement",
            },
          },
          x = {
            ["g+"] = {
              function() return require("dial.map").manipulate("increment", "gvisual") end,
              desc = "Increment",
            },
            ["g-"] = {
              function() return require("dial.map").manipulate("decrement", "gvisual") end,
              desc = "Decrement",
            },
          },
          n = {
            ["+"] = {
              function() return require("dial.map").manipulate("increment", "normal") end,
              desc = "Increment",
            },
            ["-"] = {
              function() return require("dial.map").manipulate("decrement", "normal") end,
              desc = "Decrement",
            },
            ["g+"] = {
              function() return require("dial.map").manipulate("increment", "gnormal") end,
              desc = "Increment",
            },
            ["g-"] = {
              function() return require("dial.map").manipulate("decrement", "gnormal") end,
              desc = "Decrement",
            },
          },
        },
      },
    },
  },
  config = function()
    local augend = require "dial.augend"
    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.misc.alias.markdown_header,
        augend.date.new {
          pattern = "%B", -- titlecased month names
          default_kind = "day",
        },
        augend.constant.new {
          elements = {
            "零",
            "一",
            "二",
            "三",
            "四",
            "五",
            "六",
            "七",
            "八",
            "九",
          },
        },
        augend.constant.new {
          elements = {
            "星期一",
            "星期二",
            "星期三",
            "星期四",
            "星期五",
            "星期六",
            "星期天",
          },
        },
        augend.constant.new {
          elements = {
            "january",
            "february",
            "march",
            "april",
            "may",
            "june",
            "july",
            "august",
            "september",
            "october",
            "november",
            "december",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "monday",
            "tuesday",
            "wednesday",
            "thursday",
            "friday",
            "saturday",
            "sunday",
          },
          word = true,
          cyclic = true,
        },
        augend.case.new {
          types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
        },
      },
    }
  end,
}
