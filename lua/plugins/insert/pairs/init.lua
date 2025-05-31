return switch(my_utils.autopair, {
  blink = function() return require "plugins.insert.pairs.blink-pairs" end,
  default = function() return require "plugins.insert.pairs.auto-pairs" end,
})
