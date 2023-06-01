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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
call plug#end()

set scrolloff=2
set expandtab shiftwidth=4
set number relativenumber signcolumn=yes
set smartcase ignorecase
set completeopt=menuone,longest
set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() nofoldenable

let mapleader = ","

map <Leader>f <Plug>(ale_fix)
map <Leader>a <Cmd>lua vim.lsp.buf.code_action()<CR>
map <Leader>r <Cmd>lua vim.lsp.buf.rename()<CR>
map <Leader>h <Cmd>lua vim.lsp.buf.hover()<CR>
map <Leader>gr <Cmd>lua vim.lsp.buf.references()<CR>
map <Leader>gi <Cmd>lua vim.lsp.buf.implementation()<CR>
map <Leader>gt <Cmd>lua vim.lsp.buf.type_definition()<CR>

" source everything in init.d, an attempt to organise things
" (and also bc calling lua from vim and vice-versa is always a bit awkward..
"  so I just use whatever's appropriate for a specific bit of the config)
runtime! init.d/**
