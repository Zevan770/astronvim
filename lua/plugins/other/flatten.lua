-- if true then return {} end
---@type LazySpec
return {
  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 10000,
    dependencies = {
      {
        "willothy/wezterm.nvim",
        dev = true,
        opts = {
          executable = "wezterm.exe",
        },
      },
    },
    opts = function(_, opts)
      ---@type Terminal?
      local saved_terminal
      ---@module 'flatten'
      ---@type Flatten.PartialConfig
      return {
        window = {
          -- open = "alternate",
          open = function(args)
            local bufnr, winnr

            local focus = args.files[1]
            -- If there's an stdin buf, focus that
            if args.stdin_buf then focus = args.stdin_buf end

            bufnr = focus.bufnr
            winnr = vim.fn.win_getid(vim.fn.winnr "#")

            vim.api.nvim_win_set_buf(winnr, bufnr)
            if not vim.tbl_contains(vim.api.nvim_list_bufs(), bufnr) then
              -- 说明被vim-fetch关闭了, 则尝试获取对应的原始文件

              -- ~/.local/share/nvim/lazy/vim-fetch/autoload/fetch.vim:125
              vim.cmd [[
              function! CheckFlatten(bufname) abort " ({{{
                " check for a matching spec, return if none matches
                for [l:key, l:spec] in items(fetch#specs())
                  if index(g:fetch_disabled_specs, l:key) != -1
                    unlet! l:spec
                    continue
                  endif
                  if matchend(a:bufname, l:spec.pattern) is len(a:bufname)
                    break
                  endif
                  unlet! l:spec
                endfor
                if exists('l:spec') isnot 1 | return 0 | endif
                let [l:file, l:jump] = l:spec.parse(a:bufname)
                return bufadd(l:file)
              endfunction " }}}
              ]]
              bufnr = vim.fn.CheckFlatten(focus.fname)
              vim.api.nvim_win_set_buf(winnr, bufnr)
            end
            vim.api.nvim_set_current_win(winnr)
            return bufnr, winnr
          end,
        },
        hooks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")

            -- Alternatively, we can block if we find the diff-mode option
            -- return vim.tbl_contains(argv, "-d")
          end,
          pre_open = function()
            local ok, term = pcall(require, "toggleterm.terminal")
            if not ok then return end
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(o)
            local bufnr, winnr, ft, is_blocking = o.bufnr, o.winnr, o.filetype, o.is_blocking
            -- vim.notify(o)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)

              -- If we're in a different wezterm pane/tab, switch to the current one
              -- Requires willothy/wezterm.nvim
              -- require("wezterm").switch_pane.id(tonumber(os.getenv "WEZTERM_PANE"))
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function() require("astrocore.buffer").close(bufnr) end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
        integrations = { wezterm = false },
        nest_if_no_args = true,
      }
    end,
  },
  -- {
  --   "lewis6991/fileline.nvim",
  --   lazy = false,
  --   priority = 10000,
  -- },
  {
    "wsdjeg/vim-fetch",
    lazy = false,
    priority = 9999,
  },
}
