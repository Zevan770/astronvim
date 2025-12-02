[Mode 2031 support · Issue #4269 · tmux/tmux](https://github.com/tmux/tmux/issues/4269)
[OSC11 query caches response until client is changed · Issue #3582 · tmux/tmux](https://github.com/tmux/tmux/issues/3582)
Apparently there's something called ["CSI 996" or "DSR 996" or "Mode 2031"](https://github.com/contour-terminal/contour/blob/f3c3334aa5c861348c5bbe8ffe572c872eef2e08/docs/vt-extensions/color-palette-update-notifications.md), which allows terminal programs to query whether a light or dark theme is used.
I found implementations in [kitty](https://github.com/kovidgoyal/kitty/commit/dd9d8353dfbb8da655d93fe449ce31be0f0956b6), [contour](https://github.com/contour-terminal/contour/commit/60781dca40036bfc94b39a93446d561484b3ae45), [ghostty](https://github.com/ghostty-org/ghostty/pull/1444), [neovim](https://github.com/neovim/neovim/pull/31350/) and open issues for [wezterm](https://github.com/wezterm/wezterm/issues/6454), [tmux](https://github.com/tmux/tmux/issues/4269), [zellij](https://github.com/zellij-org/zellij/issues/3831).

React

[](https://github.com/fdncred)

```lua
--- Guess value of 'background' based on terminal color.
---
--- We write Operating System Command (OSC) 11 to the terminal to request the
--- terminal's background color. We then wait for a response. If the response
--- matches `rgba:RRRR/GGGG/BBBB/AAAA` where R, G, B, and A are hex digits, then
--- compute the luminance[1] of the RGB color and classify it as light/dark
--- accordingly. Note that the color components may have anywhere from one to
--- four hex digits, and require scaling accordingly as values out of 4, 8, 12,
--- or 16 bits. Also note the A(lpha) component is optional, and is parsed but
--- ignored in the calculations.
---
--- [1] https://en.wikipedia.org/wiki/Luma_%28video%29
do
  --- Parse a string of hex characters as a color.
  ---
  --- The string can contain 1 to 4 hex characters. The returned value is
  --- between 0.0 and 1.0 (inclusive) representing the intensity of the color.
  ---
  --- For instance, if only a single hex char "a" is used, then this function
  --- returns 0.625 (10 / 16), while a value of "aa" would return 0.664 (170 /
  --- 256).
  ---
  --- @param c string Color as a string of hex chars
  --- @return number? Intensity of the color
  local function parsecolor(c)
    if #c == 0 or #c > 4 then return nil end

    local val = tonumber(c, 16)
    if not val then return nil end

    local max = assert(tonumber(string.rep("f", #c), 16))
    return val / max
  end

  --- Parse an OSC 11 response
  ---
  --- Either of the two formats below are accepted:
  ---
  ---   OSC 11 ; rgb:<red>/<green>/<blue>
  ---
  --- or
  ---
  ---   OSC 11 ; rgba:<red>/<green>/<blue>/<alpha>
  ---
  --- where
  ---
  ---   <red>, <green>, <blue>, <alpha> := h | hh | hhh | hhhh
  ---
  --- The alpha component is ignored, if present.
  ---
  --- @param resp string OSC 11 response
  --- @return string? Red component
  --- @return string? Green component
  --- @return string? Blue component
  local function parseosc11(resp)
    local r, g, b
    r, g, b = resp:match "^\027%]11;rgb:(%x+)/(%x+)/(%x+)$"
    if not r and not g and not b then
      local a
      r, g, b, a = resp:match "^\027%]11;rgba:(%x+)/(%x+)/(%x+)/(%x+)$"
      if not a or #a > 4 then return nil, nil, nil end
    end

    if r and g and b and #r <= 4 and #g <= 4 and #b <= 4 then return r, g, b end

    return nil, nil, nil
  end

  -- This autocommand updates the value of 'background' anytime we receive
  -- an OSC 11 response from the terminal emulator. If the user has set
  -- 'background' explicitly then we will delete this autocommand,
  -- effectively disabling automatic background setting.
  local force = false
  local id = vim.api.nvim_create_autocmd("TermResponse", {
    group = group,
    nested = true,
    desc = "Update the value of 'background' automatically based on the terminal emulator's background color",
    callback = function(args)
      local resp = args.data.sequence ---@type string
      local r, g, b = parseosc11(resp)
      if r and g and b then
        local rr = parsecolor(r)
        local gg = parsecolor(g)
        local bb = parsecolor(b)

        if rr and gg and bb then
          local luminance = (0.299 * rr) + (0.587 * gg) + (0.114 * bb)
          local bg = luminance < 0.5 and "dark" or "light"
          setoption("background", bg, force)

          -- On the first query response, don't force setting the option in
          -- case the user has already set it manually. If they have, then
          -- this autocommand will be deleted. If they haven't, then we do
          -- want to force setting the option to override the value set by
          -- this autocommand.
          if not force then force = true end
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    nested = true,
    once = true,
    callback = function()
      if vim.api.nvim_get_option_info2("background", {}).was_set then vim.api.nvim_del_autocmd(id) end
    end,
  })

  vim.api.nvim_ui_send "\027]11;?\007"
end
```

```lua
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  once = true,
  callback = function(ev)
    if vim.opt.background:get() == "dark" then
      vim.cmd "colorscheme blue"
    else
      vim.cmd "colorscheme morning"
    end
  end,
})
```

```lua
vim.api.nvim_ui_send "\027]11;?\007"
```
