;; extends
; vue_for_add_slot: In NiceGUI, you can add a template slot for elements. This is in
(call
  function: (attribute attribute: (identifier) @id (#match? @id "add_slot"))
  arguments: (argument_list
               (string (string_content) @injection.content (#set! injection.language "vue"))))

; sql_in_call: SQL syntax for strings which reside inside a `execute` or `read_sql` funciton call
(call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
               (string (string_content) @injection.content (#set! injection.language "sql"))))

; all_sql: SQL syntax for all strings containing uppercase SQL commands
(string
  (string_content) @injection.content
  (#vim-match? @injection.content "^\w*SELECT|FROM|INNER JOIN|WHERE|CREATE|DROP|INSERT|UPDATE|ALTER.*$")
  (#set! injection.language "sql"))

; rst_for_docstring: restructured text syntax in all python docstrings
(function_definition
  (block
    (expression_statement
      (string
        (string_content) @injection.content (#set! injection.language "rst")))))

; JavaScript syntax in all strings in assignments of identifiers that end with 'js'
(assignment
  ((identifier) @_varx (#match? @_varx ".*js$"))
  (string
    (string_content) @injection.content (#set! injection.language "javascript")))

; HTML syntax in all strings in assignments of identifiers that end with 'html'
(assignment
  ((identifier) @_varx (#match? @_varx ".*[hH][tT][mM][lL]$"))
  (string
    (string_content) @injection.content (#set! injection.language "html")))


; CSS syntax in all strings in assignments of identifiers that end with 'css'
(assignment
  ((identifier) @_varx (#match? @_varx ".*css$"))
  (string
    (string_content) @injection.content (#set! injection.language "css")))


; JSON syntax in all strings in call expressions that are method calls named 'loads'
(call
  function: (attribute
              attribute: (identifier) @_idd (#eq? @_idd "loads"))
  arguments: (argument_list
               (string (string_content) @injection.content (#set! injection.language "json") ) ) )

; R syntax in all strings that contain #R
(string
  (string_content) @injection.content
  (#vim-match? @injection.content "#R")
  (#set! injection.language "r")
)
