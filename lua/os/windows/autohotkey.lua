-- local function get_autohotkey_path()
--   local path = vim.fn.exepath "autohotkey64.exe"
--   return #path > 0 and path or nil
-- end

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLspOpts
    opts = {
      servers = { "autohotkey_lsp" },
      config = {
        autohotkey_lsp = {
          cmd = { "autohotkey_lsp", "--stdio" },
          filetypes = { "autohotkey" },
          root_markers = { "package.json", ".git" },
          flags = { debounce_text_changes = 500 },
          capabilities = { offsetEncoding = "utf-8" },
          --capabilities = capabilities,
          --on_attach = custom_attach,
          -- reuse_client = true,
          -- single_file_support = false,
          init_options = {
            -- AutoLibInclude = "All",
            AutolibInclude = 3,
            CommentTags = "^;;\\s*(?<tag>.+)",
            CompleteFunctionParens = false,
            Diagnostics = {
              ClassNonDynamicMemberCheck = true,
              InvokeCheck = {
                "ParamCount",
                "ByrefParam",
                "ReturnUnset",
                "ReturnVoid",
              },
            },
            Warn = {
              Unused = false,
              VarUnset = true,
              LocalSameAsGlobal = false,
              CallWithoutParentheses = "Off",
            },
            ActionWhenV1IsDetected = "Warn",
            CompletionCommitCharacters = {
              ["Class"] = ".(",
              ["Function"] = "(",
            },
            FormatOptions = {
              -- align_continuation_section_with_ltrim0_to_left = false,
              -- array_style = "expand",
              break_chained_methods = false,
              ignore_comment = false,
              indent_string = "    ",
              max_preserve_newlines = 2,
              brace_style = "One True Brace",
              object_style = "none",
              preserve_newlines = true,
              space_after_double_colon = true,
              space_before_conditional = true,
              space_in_empty_paren = false,
              space_in_other = true,
              space_in_paren = false,
              wrap_line_length = 0,
            },
            InterpreterPath = "C:\\Program Files\\Autohotkey\\v2\\AutoHotkey.exe",
            SymbolFoldinFromOpenBrace = false,
            ExplicitContextOnly = false,
            WorkingDirs = {},
            -- locale = "zh-cn",
            -- fullySemanticToken = true,
            -- Files = {
            --   MaxDepth = 4,
            -- },
          },
        },
      },
    },
  },
}
