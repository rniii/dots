let g:ale_disable_lsp = 1
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_dprint_use_global = 1

let g:ale_fixers = {}
let g:ale_linters = {}

for [lang, fmt] in [
\   ['c', ['clang-format']],
\   ['cpp', ['clang-format']],
\   ['elm', ['elm-format']],
\   ['haskell', ['fourmolu']],
\   ['markdown', ['pandoc']],
\   ['ocaml', ['ocamlformat']],
\   ['reason', ['refmt']],
\   ['ruby', ['rubocop']],
\   ['rust', ['rustfmt']],
\   ['vue', ['prettier']]
\ ]
    let g:ale_fixers[lang] = fmt
    let g:ale_linters[lang] = []
endfor

let g:ale_linters.lua = ['luac']
let g:ale_linters.json = ['jq']
let g:ale_fixers.json = ['prettier']

let g:ale_markdown_pandoc_options = '--columns=120 -t gfm'
let g:ale_rust_rustfmt_options = '--edition 2021' " AAAAAAAAAAAAAAAAAA
" using the 4-ident fork for 2-ident :3
let g:ale_haskell_fourmolu_options = '--indentation 2 --indent-wheres true --haddock-style single-line'

for lang in ['typescript', 'javascript', 'typescriptreact', 'javascriptreact']
    let g:ale_fixers[lang] = ['eslint', 'dprint']
    let g:ale_linters[lang] = []
endfor

for lang in ['html', 'scss', 'css', 'yaml']
    let g:ale_fixers[lang] = ['prettier']
    let g:ale_linters[lang] = []
endfor
