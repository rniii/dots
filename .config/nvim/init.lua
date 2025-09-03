vim.cmd [[
set expandtab

set nowrap
set scrolloff=2   sidescrolloff=20
set textwidth=100 colorcolumn=81,+1

set nu rnu signcolumn=yes
set cursorline culopt=line
set list listchars=extends:>,precedes:<,tab:\ \ ,trail:•
set title titlestring=%t%(\ (%{fnamemodify(getcwd(),\":~\")})%)%(\ -\ nvim%)

set smartcase ignorecase
set completeopt=menuone,longest
set nofoldenable foldmethod=marker
set undofile sessionoptions+=globals
]]

vim.g.mapleader = ","

--- Plugins --------------------------------------------------------------- {{{1
require "paq" {
  "nvim-tree/nvim-web-devicons",

  "nvim-lualine/lualine.nvim", "akinsho/bufferline.nvim",
  "Bekaboo/dropbar.nvim",      "lewis6991/satellite.nvim",
  "lewis6991/gitsigns.nvim",   "j-hui/fidget.nvim",

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "RRethy/vim-illuminate", "brenoprata10/nvim-highlight-colors",

  "neovim/nvim-lspconfig", "b0o/schemastore.nvim",

  "windwp/nvim-autopairs", "windwp/nvim-ts-autotag",
  "tpope/vim-repeat",      "tpope/vim-commentary",
  "tpope/vim-rsi",         "tpope/vim-surround",
  "tpope/vim-sleuth",      "tpope/vim-fugitive",
  "tpope/vim-afterimage",  "junegunn/vim-easy-align",

  "stevearc/conform.nvim",

  "hrsh7th/nvim-cmp",         "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip",

  "Apeiros-46B/uiua.vim",
  "sheerun/vim-polyglot",
  "justinmk/vim-dirvish",
  "nvim-lua/plenary.nvim",
  "Shatur/neovim-session-manager",
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
}

--- Theme ----------------------------------------------------------------- {{{1
vim.cmd.colorscheme "thorns"

require("nvim-web-devicons").setup { color_icons = false }

--- UI -------------------------------------------------------------------- {{{1
vim.diagnostic.config {
  virtual_text = { prefix = "･" },
  severity_sort = true,
}

local ff_symbols = { unix = "lf", dos = "crlf", mac = "cr" }

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict

  return gitsigns and {
    added = gitsigns.added,
    modified = gitsigns.changed,
    removed = gitsigns.removed,
  }
end

require("lualine").setup {
  options = {
    theme = "thorns",
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

require("gitsigns").setup {}

require("fidget").setup {
  progress = {
    display = {
      render_limit = 5,
      progress_icon = { "noise" },
    },
  },
}

require("telescope").setup {
  defaults = {
    initial_mode = "normal",
  },
}

--- Highlighting ---------------------------------------------------------- {{{1
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "embedded_template", "javascript", "markdown_inline", "purescript", "typescript",
    ----------- ----------- ----------- ----------- ----------- ----------- -----------
    "bash",     "cpp",      "c_sharp",  "c",        "css",      "doxygen",  "d",
    "gleam",    "glsl",     "go",       "haskell",  "html",     "java",     "jsdoc",
    "jsonc",    "json",     "lua",      "markdown", "ocaml",    "python",   "regex",
    "ruby",     "rust",     "scheme",   "scss",     "tcl",      "toml",     "tsx",
    "vimdoc",   "vim",      "vue",      "yaml",
  },
  highlight = { enable = true },
  autotag = { enable = true },
  indent = { enable = true },
}

vim.treesitter.language.register("ruby", "crystal")

require("illuminate").configure {
  providers = {"lsp", "treesitter"}
}

require("nvim-highlight-colors").setup {}

--- LSP ------------------------------------------------------------------- {{{1
local lspconfig = require "lspconfig"

lspconfig.util.default_config.settings = {
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

-- lspconfig.util.default_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.enable {
  "csharp_ls", "emmet_language_server", "kotlin_lsp", "purescriptls", "rust_analyzer",
  ----------- ----------- ----------- ----------- ----------- ----------- -----------
  "astro",    "ccls",     "efm",      "elmls",    "gopls",    "hls",      "lua_ls",
  "mesonlsp", "ocamllsp", "ols",      "pylsp",    "qmlls",    "serve_d",  "taplo",
  "ts_ls",    "uiua",     "volar",    "zls",      "cssls",    "eslint",   "jsonls",
  "html",
}

vim.lsp.config("efm", {
  filetypes = { "sh", "bash", "zsh" },
  settings = {
    languages = {
      sh = {
        {
          lintCommand = "shellcheck -f gcc -x",
          lintSource = "shellcheck",
          lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
          lintIgnoreExitCode = true,
        },
      }
    }
  }
})

vim.lsp.config("jsonls", {
  settings = { json = { validate = { enable = true } } },
  before_init = function (_, config)
    config.settings.json.schemas = require("schemastore").json.schemas()
  end
})

--- Editing --------------------------------------------------------------- {{{1
local npairs = require "nvim-autopairs"

npairs.setup { check_ts = true }
npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
npairs.add_rules(require "nvim-autopairs.rules.endwise-ruby")

local conform = require("conform")

conform.setup {
  formatters_by_ft = {
    c     = {"clang-format"}, cpp     = {"clang-format"},
    css   = {"prettier"},     d       = {"dfmt"},
    go    = {"gofmt"},        haskell = {"fourmolu"},
    html  = {"prettier"},     lua     = {"stylua"},
    ocaml = {"ocamlformat"},  python  = {"black"},
    rust  = {"rustfmt"},      scss    = {"prettier"},
    vue   = {"prettier"},     zig     = {"zigfmt"},

    javascript = {"dprint"}, javascriptreact = {"dprint"},
    typescript = {"dprint"}, typescriptreact = {"dprint"},
  }
}

conform.formatters.fourmolu = {
  prepend_args = { "--indentation=2", "--indent-wheres=true", "--haddock-style=single-line" },
}

vim.api.nvim_create_user_command("Conform", function (_)
  conform.format { async = true }
end, {})

vim.cmd [[
map <Space> za

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

map <Leader>f <Cmd>Conform<CR>
autocmd FileType javascript,javascriptreact,typescript,typescriptreact map <Leader>f <Cmd>silent! EslintFixAll<CR><Cmd>Conform<CR>

autocmd FileType cpp setlocal commentstring=//\ %s
]]

--- Completion ------------------------------------------------------------ {{{1
local cmp = require "cmp"
local luasnip = require "luasnip"

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

--- Other ----------------------------------------------------------------- {{{1
require("session_manager").setup {
  autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.b.buftype == "nofile" then
      return
    end

    require("session_manager").save_current_session()
  end
})
