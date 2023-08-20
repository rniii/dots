let g:ale_disable_lsp = 1
let g:ale_use_neovim_diagnostics_api = 1

let g:ale_fixers = {}
let g:ale_linters = {}

let g:ale_fixers.markdown = ['pandoc']
let g:ale_linters.markdown = []
let g:ale_markdown_pandoc_options = '--columns=120 -t gfm'

let g:ale_fixers.rust = ['rustfmt']
let g:ale_linters.rust = []
let g:ale_rust_rustfmt_options = '--edition 2021' " AAAAAAAAAAAAAAAAAA

let g:ale_linters.ruby = ['ruby']

let g:ale_linters.lua = ['luac']

let g:ale_fixers.json = ['prettier']
let g:ale_linters.json = ['jq']

for lang in ['typescript', 'javascript', 'typescriptreact', 'javascriptreact']
    let g:ale_fixers[lang] = ['eslint', 'dprint']
    let g:ale_linters[lang] = ['eslint']
endfor

for lang in ['html', 'scss', 'css', 'yaml']
    let g:ale_fixers[lang] = ['prettier']
    let g:ale_linters[lang] = []
endfor

let g:ale_javascript_prettier_options = '--tab-width 4'
