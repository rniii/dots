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

nnoremap <space> za

" source everything in init.d
runtime! init.d/**
