; extends

(call_expression
  function: (identifier) @_name
  arguments: [
    (arguments
      (template_string) @injection.content)
    (template_string) @injection.content
  ]
  (#eq? @_name "re")
  (#set! injection.include-children)
  (#set! injection.language "javascript")
  (#offset! @injection.content 0 1 0 -1))
