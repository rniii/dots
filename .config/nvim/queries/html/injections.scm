; extends

((attribute
  (attribute_name) @_attr
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#match? @_attr "^x-|[@:.]")
  (#set! injection.language "javascript"))
