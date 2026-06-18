" Vim compiler file for latexmk
" Purpose: Delegate all compilation logic to latexmk and .latexmkrc.
" No extra arguments (like -pdf or -interaction) are passed here.

if exists("current_compiler")
    finish
endif
let current_compiler = "latexmk"

" Save and set 'compatible' options
let s:keepcpo = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" 1. Set makeprg: call latexmk with the current file.
"    All essential options (engine, output dir, interaction mode, etc.)
"    must be set in your ~/.latexmkrc or ./latexmkrc.
" ---------------------------------------------------------------------
execute 'setlocal makeprg=latexmk\ -file-line-error\ -interaction=nonstopmode\ %'

" ---------------------------------------------------------------------
" 2. Set errorformat: parsed from VimTeX's proven configuration.
"    Works perfectly with -file-line-error (set in .latexmkrc).
" ---------------------------------------------------------------------
setlocal errorformat=%-P**%f
setlocal errorformat+=%-P**\"%f\"

" Match LaTeX errors
setlocal errorformat+=%E!\ LaTeX\ %trror:\ %m
setlocal errorformat+=%E%f:%l:\ %m
setlocal errorformat+=%E!\ %m

" More info for undefined control sequences
setlocal errorformat+=%Z<argument>\ %m

" More info for some errors
setlocal errorformat+=%Cl.%l\ %m

" Catch-all to ignore unmatched lines
setlocal errorformat+=%-G%.%#

" Restore 'compatible' options
let &cpo = s:keepcpo
unlet s:keepcpo
