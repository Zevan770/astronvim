vim.lsp.enable "texlab"
---@type LazySpec
return {
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  {
    "lervag/vimtex",
    lazy = true,
    ft = { "tex" },
    init = function(_)
      -- vim.g.vimtex_view_method = "general"
      -- vim.g.vimtex_view_general_viewer = "sumatrapdf"
      -- vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
      --   --      [[-reuse-instance -forward-search @tex @line @pdf -inverse-search "nircmd exec hide nvim --headless -c ^"Lazy load vimtex | VimtexInverseSearch %l '%f'^""]]
      -- vim.cmd [[
      --   if has('win32') || (has('unix') && exists('$WSLENV'))
      --     if executable('sioyek.exe')
      --       let g:vimtex_view_method = 'sioyek'
      --       let g:vimtex_view_sioyek_exe = 'sioyek.exe'
      --       let g:vimtex_callback_progpath = 'wsl nvim'
      --     elseif executable('mupdf.exe')
      --       let g:vimtex_view_general_viewer = 'mupdf.exe'
      --     elseif executable('SumatraPDF.exe')
      --       let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
      --     endif
      --   endif
      -- ]]
    end,
    keys = {
      {
        "<localleader>lt",
        function() return require("vimtex.snacks").toc() end,
        ft = "tex",
      },
    },
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    lazy = true,
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      use_treesitter = true, -- whether to use treesitter to determine if cursor is in math mode; if false, vimtex is used
      allow_on_markdown = true, -- whether to add snippets to markdown filetype
    },
  },
}
