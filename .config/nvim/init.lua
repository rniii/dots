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
set undofile sessionoptions+=globals
]]

vim.g.mapleader = ","

--- Plugins --------------------------------------------------------------- {{{1
require "paq" {
  "nvim-tree/nvim-web-devicons",

  "nvim-lualine/lualine.nvim", "Bekaboo/dropbar.nvim",
  "lewis6991/satellite.nvim",  "lewis6991/gitsigns.nvim",
  "j-hui/fidget.nvim",         "chrisgrieser/nvim-origami",

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "RRethy/vim-illuminate", "brenoprata10/nvim-highlight-colors",

  "neovim/nvim-lspconfig", "b0o/schemastore.nvim",
  "marilari88/twoslash-queries.nvim",

  "windwp/nvim-autopairs", "windwp/nvim-ts-autotag",
  "tpope/vim-repeat",      "tpope/vim-commentary",
  "tpope/vim-rsi",         "tpope/vim-surround",
  "tpope/vim-sleuth",      "tpope/vim-fugitive",
  "tpope/vim-afterimage",  "junegunn/vim-easy-align",

  "stevearc/conform.nvim",

  "hrsh7th/nvim-cmp",         "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip",

  "andweeb/presence.nvim",
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
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", { "diff", source = diff_source } },
    lualine_c = { { "filename", path = 1, newfile_status = true }, "diagnostics" },
    lualine_x = { { "filetype", icons_enabled = false } },
    lualine_y = { "encoding", { "fileformat", symbols = ff_symbols } },
    lualine_z = { "progress", "location" },
  },
  tabline = {
    lualine_c = {
      {
        "buffers",
        symbols = { alternate_file = "" },
        max_length = function () return vim.o.columns end,
        padding = 4,
      },
    },
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

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

require("origami").setup {
  autoFold = {
    enabled = true,
    kinds = { "imports" },
  },
}

--- Highlighting ---------------------------------------------------------- {{{1
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "javascript", "typescript", "tsx", "jsdoc", "html", "css", "vue",
    "json", "jsonc", "yaml", "toml", "markdown", "markdown_inline",
    "c", "cpp", "doxygen", "d", "go", "glsl", "haskell", "ocaml", "rust",
    "lua", "bash", "ruby", "python", "tcl", "vim", "vimdoc",
    "java", "kotlin",
  },
  highlight = { enable = true },
  autotag = { enable = true },
  indent = { enable = true },
}

require("illuminate").configure {
  providers = {"lsp", "treesitter"}
}

require("nvim-highlight-colors").setup {}

--- LSP ------------------------------------------------------------------- {{{1
require("twoslash-queries").setup {
  highlight = "Special"
}

vim.lsp.enable {
  "ts_ls", "eslint", "html", "emmet_language_server", "cssls", "jsonls",
  "ccls", "mesonlsp", "gopls", "hls", "ocamllsp", "rust_analyzer", "zls",
  "lua_ls", "efm", "pylsp", "uiua", "kotlin_lsp",
}

vim.lsp.config("ccls", { settings = { ccls = { diagnostics = { onOpen = 100 } } } })

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

vim.lsp.config("ts_ls", {
  on_attach = function (client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
  end
})

vim.lsp.config("eslint", {
  settings = {
    rulesCustomizations = {
      { rule = "@stylistic/*", severity = "off", fixable = true },
    },
  },
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

map <C-k> <Cmd>bprev<CR>
map <C-j> <Cmd>bnext<CR>

nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-N><C-w>h
tnoremap <C-w>j <C-\><C-N><C-w>j
tnoremap <C-w>k <C-\><C-N><C-w>k
tnoremap <C-w>l <C-\><C-N><C-w>l

map <Leader>f <Cmd>Conform<CR>
autocmd FileType javascript,javascriptreact,typescript,typescriptreact map <Leader>f <Cmd>silent! LspEslintFixAll<CR><Cmd>Conform<CR>

autocmd FileType cpp setlocal commentstring=//\ %s
]]

vim.api.nvim_create_user_command("LazyGit", function ()
  vim.system({"alacritty", "-e", "zsh", "-c", "bspc node -z top 0 70 && lazygit"})
end, { nargs = 0 })

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

local presence_url = "https://raw.githubusercontent.com/iCrawl/discord-vscode/refs/heads/master/assets/icons/"

local presence_assets = {}

for key, value in pairs({
  js    = "JavaScript", ts   = "TypeScript",
  jsx   = "JSX",        tsx  = "TSX",
  html  = "HTML",       css  = "CSS",
  vue   = "Vue",        json = "JSON",
  jsonc = "JSON",       yaml = "YAML",
  toml  = "TOML",       md   = { "Markdown", "markdown" },
  c     = "C",          cxx  = { "C++", "cpp" },
  cpp   = "C++",        cc   = { "C++", "cpp" },
  d     = "D",          go   = "Go",
  glsl  = "GLSL",       hs   = { "Haskell", "haskell" },
  rs    = "Rust",       ml   = { "OCaml", "ocaml" },
  lua   = "Lua",        bash = "Bash",
  ruby  = "Ruby",       py   = { "Python", "python" },
  tcl   = "TCL",
}) do
  local name, file
  if type(value) == "string" then
    name, file = value, key
  else
    name, file = value[1], value[2]
  end

  presence_assets[key] = { name, presence_url .. file .. ".png" }
end

require("presence").setup {
  main_image = "file",
  file_assets = presence_assets,
  buttons = function (_, repo_url)
    if not repo_url then return end

    repo_url = string.gsub(repo_url, "^(.+)@(.+):(.+)$", "https://%2/%3")
    repo_url = string.gsub(repo_url, ".git$", "")

    return {
      { label = "View Repository", url = repo_url }
    }
  end
}
