return switch(my_utils.my_animate, {
  snacks = function() return require "plugins.ui.animate.snacks_scroll" end,
  default = function() return require "plugins.ui.animate.neoscroll" end,
})
