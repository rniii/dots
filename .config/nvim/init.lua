require "paq" {
  --- LSP ------------------------------------------------------------
  "neovim/nvim-lspconfig", "b0o/schemastore.nvim",

  --- Linting --------------------------------------------------------
  "dense-analysis/ale",

  --- Completion -----------------------------------------------------
  "hrsh7th/nvim-cmp",         "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip",

  --- Highlighting ---------------------------------------------------
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "RRethy/vim-illuminate",

  --- Languages ------------------------------------------------------
  "sheerun/vim-polyglot", "Apeiros-46B/uiua.vim",

  --- Editing --------------------------------------------------------
  "windwp/nvim-autopairs", "windwp/nvim-ts-autotag",
  "tpope/vim-repeat",      "tpope/vim-commentary",
  "tpope/vim-rsi",         "tpope/vim-surround",
  "tpope/vim-sleuth",      "tpope/vim-fugitive",
  "tpope/vim-afterimage",  "junegunn/vim-easy-align",

  --- Theming --------------------------------------------------------
  { "catppuccin/nvim", as = "catppuccin" },
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim", "akinsho/bufferline.nvim",
  "Bekaboo/dropbar.nvim",      "lewis6991/satellite.nvim",
  "brenoprata10/nvim-highlight-colors",
  "j-hui/fidget.nvim",

  --- Bloat ----------------------------------------------------------
  "akinsho/toggleterm.nvim",
  "justinmk/vim-dirvish",
  "lewis6991/gitsigns.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
  "Shatur/neovim-session-manager",
  "lukas-reineke/headlines.nvim",
}

vim.cmd [[
set expandtab

set nowrap
set scrolloff=2   sidescrolloff=20
set textwidth=100 colorcolumn=81,+1

set cul    culopt=line
set nu rnu signcolumn=yes
set list   listchars=extends:>,precedes:<,tab:\ \ ,trail:•
set title  titlestring=%t%(\ (%{fnamemodify(getcwd(),\":~\")})%)%(\ -\ nvim%)

set smartcase ignorecase
set completeopt=menuone,longest
set nofoldenable foldmethod=marker
set undofile sessionoptions+=globals

let mapleader = ","
let filetype_i = "nasm"

map <Space> za

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
map <C-k> <Cmd>BufferLineCyclePrev<CR>
map <C-j> <Cmd>BufferLineCycleNext<CR>

nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-N><C-w>h
tnoremap <C-w>j <C-\><C-N><C-w>j
tnoremap <C-w>k <C-\><C-N><C-w>k
tnoremap <C-w>l <C-\><C-N><C-w>l

autocmd FileType cpp setlocal commentstring=//\ %s

let g:ale_disable_lsp = 1
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_dprint_use_global = 1

let g:ale_fixers = {}
let g:ale_linters = {}

for [lang, fmt] in [
\   ['c',       'clang-format'], ['cpp',    'clang-format'],
\   ['css',     'prettier'],     ['d',      'dfmt'],
\   ['elm',     'elm-format'],   ['go',     'gofmt'],
\   ['haskell', 'fourmolu'],     ['html',   'prettier'],
\   ['lua',     'stylua'],       ['ocaml',  'ocamlformat'],
\   ['python',  'black'],        ['reason', 'refmt'],
\   ['ruby',    'rubocop'],      ['rust',   'rustfmt'],
\   ['scss',    'prettier'],     ['vue',    'prettier'],
\   ['yaml',    'prettier'],     ['zig',    'zigfmt']
\ ]
    let g:ale_fixers[lang] = [fmt]
    let g:ale_linters[lang] = []
endfor

for lang in ['javascript', 'javascriptreact', 'typescript', 'typescriptreact']
    let g:ale_fixers[lang] = ['dprint', 'eslint']
    let g:ale_linters[lang] = []
endfor

let g:ale_linters.json = ['jq']
let g:ale_fixers.json = ['prettier']

let g:ale_markdown_pandoc_options = '--columns=120 -t gfm'
let g:ale_rust_rustfmt_options = '--edition 2021' " AAAAAAAAAAAAAAAAAA
" using the 4-ident fork for 2-ident :3
let g:ale_haskell_fourmolu_options = '--indentation 2 --indent-wheres true --haddock-style single-line'
let g:ale_d_dfmt_options = '--indent_size 2 --brace_style otbs'
]]

--- Theme ----------------------------------------------------------------------

require("nvim-web-devicons").setup {
  color_icons = false,
}

local U = require("catppuccin.utils.colors")

require("catppuccin").setup {
  flavour = "mocha",
  custom_highlights = function (colors)
    return {
      IlluminatedWordText  = { bg = colors.surface2 },
      IlluminatedWordRead  = { bg = colors.surface2 },
      IlluminatedWordWrite = { bg = colors.surface2 },

      uiuaRed       = { fg = colors.red      },
      uiuaOrange    = { fg = colors.peach    },
      uiuaYellow    = { fg = colors.yellow   },
      uiuaBeige     = { fg = colors.green    },
      uiuaGreen     = { fg = colors.green    },
      uiuaAqua      = { fg = colors.teal     },
      uiuaBlue      = { fg = colors.blue     },
      uiuaIndigo    = { fg = colors.blue     },
      uiuaPurple    = { fg = colors.mauve    },
      uiuaPink      = { fg = colors.pink     },
      uiuaLightPink = { fg = colors.pink     },
      uiuaFaded     = { fg = colors.overlay0 },

      uiuaForeground      = { fg = colors.text     },
      uiuaForegroundDark  = { fg = colors.overlay0 },
      uiuaForegroundLight = { fg = colors.text     },

      rainbow1 = { fg = "#ee9598" },
      rainbow2 = { fg = "#e8b197" },
      rainbow3 = { fg = "#e8d097" },
      rainbow4 = { fg = "#9be099" },
      rainbow5 = { fg = "#97d0e8" },
      rainbow6 = { fg = "#979ae8" },
      rainbow7 = { fg = "#ca97e8" },

      Headline1 = { bg = U.blend("#ee9598", colors.base, 0.15) },
      Headline2 = { bg = U.blend("#e8b197", colors.base, 0.15) },
      Headline3 = { bg = U.blend("#e8d097", colors.base, 0.15) },
      Headline4 = { bg = U.blend("#9be099", colors.base, 0.15) },
      Headline5 = { bg = U.blend("#97d0e8", colors.base, 0.15) },
      Headline6 = { bg = U.blend("#979ae8", colors.base, 0.15) },
    }
  end,
  color_overrides = {
    mocha = {
      base      = "#121212",  crust     = "#181818",
      mantle    = "#181818",  surface0  = "#181818",
      surface1  = "#303030",  surface2  = "#303030",
      overlay0  = "#909090",  overlay1  = "#909090",
      overlay2  = "#909090",  text      = "#d8d0d5",
      subtext0  = "#d8d0d5",  subtext1  = "#d8d0d5",
      pink      = "#ee95d2",  peach     = "#ee95d2",
      red       = "#ee9598",  maroon    = "#ee9598",
      flamingo  = "#e8d097",  yellow    = "#e8d097",
      green     = "#9be099",  teal      = "#97d0e8",
      sky       = "#97d0e8",  sapphire  = "#97d0e8",
      blue      = "#979ae8",  lavender  = "#979ae8",
      mauve     = "#ca97e8",  rosewater = "#d895ee",
    },
  },
}

vim.cmd [[
colorscheme catppuccin

hi link Bullet1 rainbow1
hi link Bullet2 rainbow2
hi link Bullet3 rainbow3
hi link Bullet4 rainbow4
hi link Bullet5 rainbow5
hi link Bullet6 rainbow6
]]

local ff_symbols = { unix = "lf", dos = "crlf", mac = "cr" }

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

require("lualine").setup {
  options = {
    section_separators = " ",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", { "diff", source = diff_source } },
    lualine_c = { { "filename", newfile_status = true }, "diagnostics" },
    lualine_x = { { "filetype", icons_enabled = false } },
    lualine_y = { "encoding", { "fileformat", symbols = ff_symbols } },
    lualine_z = { "progress", "location" },
  },
}

require("bufferline").setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    indicator = { style = "none" },
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
  }
}

require("dropbar").setup {}

require("satellite").setup {
  handlers = {
    diagnostic = { signs = {'-'} },
  },
}

vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Visual" }]]

require("illuminate").configure {
  providers = {"lsp", "treesitter"}
}

require("nvim-highlight-colors").setup {}

--- LSP ------------------------------------------------------------------------

local lspconfig = require("lspconfig")

local servers = {
  "astro", "ccls", "csharp_ls", "elmls", "emmet_language_server", "gopls",
  "hls", "lua_ls", "mesonlsp", "ocamllsp", "purescriptls", "pylsp", "qmlls",
  "rust_analyzer", "serve_d", "taplo", "ts_ls", "uiua", "volar", "zls", "cssls",
  "eslint", "jsonls", "html",
  -- "clojure_lsp", "crystalline", "gleam", "erlangls", "solargraph", "wgsl_analyzer",
}

lspconfig.util.default_config.settings = {
  ["json"] = {
    schemas = require("schemastore").json.schemas(),
    validate = { enable = true },
  },
  ["rust-analyzer"] = {
    check = { command = "clippy" },
    imports = {
      granularity = { group = "module", enforce = true },
    },
  },
  ["ccls"] = {
    diagnostics = { onOpen = 100 },
  },
}

lspconfig.util.default_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end

--- Syntax ---------------------------------------------------------------------

vim.diagnostic.config {
  virtual_text = { prefix = "･" },
  float = { prefix = function (d) return d.source .. " " end },
  severity_sort = true,
}

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash", "cpp", "c_sharp", "c", "css", "doxygen", "d", "embedded_template", "gleam", "glsl",
    "go", "haskell", "html", "javascript", "java", "jsdoc", "jsonc", "json", "lua",
    "markdown_inline", "markdown", "ocaml", "purescript", "python", "regex", "ruby", "rust",
    "scheme", "scss", "tcl", "toml", "tsx", "typescript", "vimdoc", "vim", "vue", "yaml",
    -- "astro", "clojure", "ebnf", "htmldjango", "ocamllex", "rasi"
  },
  highlight = { enable = true },
  autotag = { enable = true },
  indent = { enable = true },
}

vim.treesitter.language.register("ruby", "crystal")

--- Completion -----------------------------------------------------------------

local npairs = require("nvim-autopairs")

npairs.setup { check_ts = true }
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm(),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable() then
        luasnip.jump()
      else
        fallback()
      end
    end),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
}

--- Bloat ----------------------------------------------------------------------

require("toggleterm").setup {
  size = 12,
  open_mapping = [[<Leader>t]],
  insert_mappings = false,
  on_open = function ()
    vim.cmd [[startinsert]]
  end
}

require("telescope").setup {
  defaults = {
    initial_mode = "normal",
  }
}

require("gitsigns").setup {}

require("fidget").setup {
  progress = {
    display = {
      render_limit = 5,
      progress_icon = { "noise" },
    },
  },
}

require("headlines").setup {
  markdown = {
    headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
    bullet_highlights   = { "Bullet1",   "Bullet2",   "Bullet3",   "Bullet4",   "Bullet5",   "Bullet6"   },
  }
}

require("session_manager").setup {
  autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
        return
      end
    end
    require("session_manager").save_current_session()
  end
})
