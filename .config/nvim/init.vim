call plug#begin()
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
" SO MANY SNIPPET PLUGINS AAAAA
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
call plug#end()

set expandtab shiftwidth=4
set number relativenumber signcolumn=yes
set smartcase ignorecase
set completeopt=menuone,longest
set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() nofoldenable

let g:ale_fixers = {}
let g:ale_linters = {}

let g:ale_fixers.rust = ['cspell', 'rustfmt']
let g:ale_linters.html = ['cspell']
let g:ale_linters.ruby = ['cspell']
let g:ale_linters.rust = ['cspell']

let g:ale_fixers.markdown = ['pandoc']
let g:ale_linters.markdown = ['cspell']
let g:ale_markdown_pandoc_options = '--columns=120 -t gfm'

let g:ale_fixers.json = ['prettier']
let g:ale_fixers.css = ['prettier']
let g:ale_fixers.scss = ['prettier']
let g:ale_fixers.html = ['prettier']
let g:ale_fixers.yaml = ['prettier']
let g:ale_javascript_prettier_options = '--tab-width 4'

let g:ale_linters.json = ['jq']

let g:ale_fixers.typescript = ['eslint']
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.typescriptreact = ['eslint']
let g:ale_fixers.javascriptreact = ['eslint']
let g:ale_linters.typescript = ['cspell', 'eslint']
let g:ale_linters.javascript = ['cspell', 'eslint']
let g:ale_linters.typescriptreact = ['cspell', 'eslint']
let g:ale_linters.javascriptreact = ['cspell', 'eslint']

let g:ale_fix_on_save = 1

let mapleader = ","

nnoremap <Space> za

map <Leader>f <Plug>(ale_fix)
map <Leader>a <Cmd>lua vim.lsp.buf.code_action()<CR>
map <Leader>r <Cmd>lua vim.lsp.buf.rename()<CR>

" source everything in init.d
runtime! init.d/**
