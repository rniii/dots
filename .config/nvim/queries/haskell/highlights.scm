; Modified from the builtin highlights. I just removed everything using @function, because it
; makes no sense for haskell. Monads act similar to functions and you mix them up a lot

[(variable) (pattern/wildcard)] @variable
[(integer) (negation) (float)] @number
(char) @character
(string) @string
(comment) @comment
(haddock) @comment.documentation

["(" ")" "{" "}" "[" "]"] @punctuation.bracket
["," ";" "."] @punctuation.delimiter

["forall" "∀"] @keyword.repeat
(pragma) @keyword.directive
["if" "then" "else" "case" "of"] @keyword.conditional
["import" "qualified" "module"] @keyword.import
[(operator) (constructor_operator) (all_names) (wildcard)
  ".." "=" "|" "::" "=>" "->" "<-" "\\" "`" "@"
  "∷" "⇒" "→" "←"] @operator

(module (module_id) @module)

["where" "let" "in" "class" "instance" "pattern" "data"
  "newtype" "family" "type" "as" "hiding" "deriving" "via"
  "stock" "anyclass" "do" "mdo" "rec" "infix" "infixl"
  "infixr"] @keyword

(infix_id
  [(variable) @operator
   (qualified (variable) @operator)])

(decl/signature name: (variable) @function)
(decl/function name: (variable) @function)
(decl name: (variable) @function)

(name) @type
(type/unit) @type
(type/star) @type
(constructor) @type

((constructor) @boolean
 (#any-of? @boolean "True" "False"))

((variable) @boolean
 (#eq? @boolean "otherwise"))

(quoter) @function.call

(quasiquote
 quoter: [(quoter) @_name
          (quoter (qualified id: (variable) @_name))]
 (#eq? @_name "qq")
 body: (quasiquote_body) @string)

(quoter
 [(variable) @function.call
  (_ (module) @module . (variable) @function.call)])

(field_name
  (variable) @variable.member)

(import_name
  (name) . (children (variable) @variable.member))

(comment) @spell
