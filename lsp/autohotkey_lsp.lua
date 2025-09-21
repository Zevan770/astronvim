---@brief
---
--- https://github.com/thqby/vscode-autohotkey2-lsp
---
--- AutoHotkey v2.0 LSP implementation
---
--- NOTE: AutoHotkey is Windows-only.

local function get_autohotkey_path()
  local path = vim.fn.exepath "autohotkey64.exe"
  return #path > 0 and path or nil
end

---@type vim.lsp.Config
return {
  cmd = { "autohotkey_lsp", "--stdio" },
  filetypes = { "autohotkey" },
  -- root_markers = { "package.json", ".git" },
  flags = { debounce_text_changes = 500 },
  --capabilities = capabilities,
  --on_attach = custom_attach,
  -- reuse_client = true,
  single_file_support = false,
  init_options = {
    locale = "zh-cn",
    fullySemanticToken = "true",
    InterpreterPath = "E:/PortableApps/autohotkey_h/AutoHotkey64.exe",
    WorkingDirs = {
      vim.fs.root(0, { "package.json", ".git" }),
    },
    AutoLibInclude = "All",
    CommentTags = "^;;\\s*(?<tag>.+)",
    CompleteFunctionParens = true,
    SymbolFoldinFromOpenBrace = false,
    Diagnostics = {
      ClassStaticMemberCheck = true,
      ParamsCheck = true,
    },
    ActionWhenV1IsDetected = "SwithToV1",
    FormatOptions = {
      array_style = "expand",
      break_chained_methods = false,
      ignore_comment = false,
      indent_string = "\t",
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
    Files = {
      ScanMaxDepth = 4,
    },
    CompletionCommitCharacters = {
      ["Class"] = ".(",
      ["Function"] = "(",
    },
  },
}
