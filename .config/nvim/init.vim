call plug#begin()
" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'b0o/schemastore.nvim'
" completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
" highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'sheerun/vim-polyglot'
Plug 'RRethy/vim-illuminate'
Plug 'wuelnerdotexe/vim-astro'
" editing stuff
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
" linting
Plug 'dense-analysis/ale'
" theme stuff
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'Bekaboo/dropbar.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/satellite.nvim'
" bloat
Plug 'justinmk/vim-dirvish' " I HATE NETRW I HATE NETRW I HATE
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-afterimage'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
Plug 'andweeb/presence.nvim'
Plug 'Shatur/neovim-session-manager'
call plug#end()

let g:presence_main_image = 'file'
let g:presence_file_assets = {}

for name in [
\       'Astro',
\       'C',
\       ['cpp', ['C++', 'cpp']],
\       ['cxx', ['C++', 'cpp']],
\       ['cc', ['C++', 'cpp']],
\       ['Cargo.toml', ['Cargo.toml', 'cargo']],
\       ['Cargo.lock', ['Cargo.lock', 'cargo']],
\       ['clj', 'Clojure'],
\       ['edn', 'Clojure'],
\       'CSS',
\       'D',
\       'Elm',
\       'Erlang',
\       ['.eslintrc.json', 'ESLint'],
\       'Gemfile',
\       ['.gitignore', 'git'],
\       'Go',
\       ['hs', 'Haskell'],
\       'HTML',
\       ['js', ['JavaScript', 'js']],
\       'JSON',
\       'JSX',
\       ['kt', 'Kotlin'],
\       'Lisp',
\       ['cl', 'Lisp'],
\       ['l', 'Lisp'],
\       ['lsp', 'Lisp'],
\       'Lua',
\       ['md', 'Markdown'],
\       ['ml', 'OCaml'],
\       ['py', 'Python'],
\       ['rb', 'Ruby'],
\       ['rs', 'Rust'],
\       ['purs', "Purescript"],
\       'SCSS',
\       ['sass', 'SCSS'],
\       'Svelte',
\       'SVG',
\       'TOML',
\       ['ts', ['TypeScript', 'ts']],
\       'TSX',
\       ['.zlogin', ['zsh', 'shell']],
\       ['.zprofile', ['zsh', 'shell']],
\       ['.zshenv', ['zsh', 'shell']],
\       ['.zshrc', ['zsh', 'shell']],
\ ]
    if type(name) == v:t_string
        let key = name->tolower()
        let file = key
    else
        let [key, name] = name
        if type(name) == v:t_string
            let file = name->tolower()
        else
            let [name, file] = name
        endif
    endif

    let g:presence_file_assets[key] = [name, 'https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/' .. file .. '.png']
endfor

set scrolloff=2
set expandtab
set number relativenumber signcolumn=yes
set smartcase ignorecase
set completeopt=menuone,longest
set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() nofoldenable
set noshowcmd
set undofile

let mapleader = ","

map <Leader>f <Plug>(ale_fix)

map <Leader>a <Cmd>lua vim.lsp.buf.code_action()<CR>
map <Leader>r <Cmd>lua vim.lsp.buf.rename()<CR>
map <Leader>h <Cmd>lua vim.lsp.buf.hover()<CR>
map <Leader>d <Cmd>lua vim.diagnostic.open_float()<CR>
map <Leader>n <Cmd>lua vim.diagnostic.goto_next()<CR>

map <leader>gr <Cmd>Telescope lsp_references<CR>
map <Leader>gi <Cmd>Telescope lsp_implementations<CR>
map <Leader>gt <Cmd>Telescope lsp_type_definitions<CR>

map <Leader>l <Cmd>Telescope find_files<CR>
map <Leader>p <Cmd>Telescope live_grep<CR>

map gb <Cmd>BufferLinePick<CR>

autocmd FileType cpp setlocal commentstring=//\ %s

" source everything in init.d, an attempt to organise things
" (and also bc calling lua from vim and vice-versa is always a bit awkward..
"  so I just use whatever's appropriate for a specific bit of the config)
runtime! init.d/**
