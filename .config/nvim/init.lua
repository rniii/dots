require "paq" {
  "paq-nvim",
  -- lsp
  "neovim/nvim-lspconfig",
  "b0o/schemastore.nvim",
  -- completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",
  -- highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "sheerun/vim-polyglot",
  "RRethy/vim-illuminate",
  "wuelnerdotexe/vim-astro",
  -- editing stuff
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "tpope/vim-repeat",
  "tpope/vim-commentary",
  "tpope/vim-rsi",
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  -- linting
  "dense-analysis/ale",
  -- theme stuff
  { "catppuccin/nvim", as = "catppuccin" },
  "nvim-lualine/lualine.nvim",
  "akinsho/bufferline.nvim",
  "Bekaboo/dropbar.nvim",
  "nvim-tree/nvim-web-devicons",
  "lewis6991/satellite.nvim",
  -- bloat
  "justinmk/vim-dirvish", -- I HATE NETRW I HATE NETRW I HATE
  "tpope/vim-fugitive",
  "tpope/vim-afterimage",
  "lewis6991/gitsigns.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
  { "j-hui/fidget.nvim", branch = "legacy" },
  "Shatur/neovim-session-manager",
}

vim.cmd[[
set scrolloff=2
set expandtab
set number relativenumber signcolumn=yes
set cursorline cursorlineopt=line
set smartcase ignorecase
set completeopt=menuone,longest
set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() nofoldenable
set noshowcmd
set undofile sessionoptions+=globals

let mapleader = ","
let filetype_i = "nasm"

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

autocmd FileType cpp setlocal commentstring=//\ %s

let g:ale_disable_lsp = 1
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_dprint_use_global = 1

let g:ale_fixers = {}
let g:ale_linters = {}

for [lang, fmt] in [
\   ['c', 'clang-format'],
\   ['cpp', 'clang-format'],
\   ['css', 'prettier'],
\   ['d', 'dfmt'],
\   ['elm', 'elm-format'],
\   ['go', 'gofmt'],
\   ['haskell', 'fourmolu'],
\   ['html', 'prettier'],
\   ['javascript', 'dprint'],
\   ['javascriptreact', 'dprint'],
\   ['lua', 'stylua'],
\   ['markdown', 'pandoc'],
\   ['ocaml', 'ocamlformat'],
\   ['reason', 'refmt'],
\   ['ruby', 'rubocop'],
\   ['rust', 'rustfmt'],
\   ['scss', 'prettier'],
\   ['typescript', 'dprint'],
\   ['typescriptreact', 'dprint'],
\   ['vue', 'prettier'],
\   ['yaml', 'prettier']
\ ]
    let g:ale_fixers[lang] = [fmt]
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

----- theme -------------------------------------------------------------------

require("nvim-web-devicons").setup {
  color_icons = false,
}

require("catppuccin").setup {
  color_overrides = {
    all = {
      base = "#121212",
      crust = "#181818",
      mantle = "#181818",

      surface0 = "#181818",
      surface1 = "#404040",
      surface2 = "#404040",
      overlay0 = "#909090",
      overlay1 = "#909090",
      overlay2 = "#909090",

      text = "#d8d0d5",
      subtext0 = "#d8d0d5",
      subtext1 = "#d8d0d5",

      blue = "#979ae8",
      green = "#9be099",
      yellow = "#e8d097",
      red = "#ee9598",
      pink = "#ee95d2",
      mauve = "#ca97e8",
      lavender = "#979ae8",
      sapphire = "#97d0e8",
      peach = "#ee95d2",
      rosewater = "#d895ee",
      maroon = "#ee9598",
      teal = "#97d0e8",
      sky = "#97d0e8",
      flamingo = "#e8d097",
    }
  },
}

local ff_symbols = { unix = "lf", dos = "crlf", mac = "cr" }

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
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

vim.cmd [[
colorscheme catppuccin

au TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Visual" }

hi IlluminatedWordText guibg=#303030
hi IlluminatedWordRead guibg=#303030
hi IlluminatedWordWrite guibg=#303030
]]

require("illuminate").configure {
  providers = {"lsp", "treesitter"}
}

----- lsp ---------------------------------------------------------------------

local servers = {
  "astro",                  -- Astro
  "ccls",                   -- C
  "clojure_lsp",            -- Clojure
  "crystalline",            -- Crystal
  "csharp_ls",              -- C#
  "elmls",                  -- Elm
  "emmet_language_server",  -- HTML (Emmet abbrevs)
  "erlangls",               -- Erlang
  "gleam",                  -- Gleam
  "gopls",                  -- Go
  "hls",                    -- Haskell
  "lua_ls",                 -- Lua
  "mesonlsp",               -- Meson
  "ocamllsp",               -- OCaml
  "purescriptls",           -- Purescript
  "qmlls",                  -- Qt QML
  "solargraph",             -- Ruby
  "rust_analyzer",          -- Rust
  "serve_d",                -- D
  "taplo",                  -- TOML
  "ts_ls",                  -- TS/JS
  "volar",                  -- Vue
  "wgsl_analyzer",          -- WGSL shaders
  "zls",                    -- Zig
  -- snitched from vscode
  "cssls",    -- CSS
  "eslint",   -- TS/JS (eslint)
  "jsonls",   -- JSON
  "html",     -- HTML
}

local settings = {
  ["haskell"] = {
    plugin = {
      -- stan = { globalOn = false }, -- SHUT UP
    }
  },
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

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    settings = settings,
  }
end

local function requests(name, get_params, cb)
  return function()
    vim.lsp.buf_request_all(0, name, get_params and get_params(), function(res)
      for _, r in ipairs(res) do
        if r ~= nil and r.result ~= nil then
          if cb then cb(r.result) end
          break
        end
      end
    end)
  end
end

vim.keymap.set("n", "<Leader>re", requests(
  "rust-analyzer/expandMacro", vim.lsp.util.make_position_params,
  function(r)
    local text = "// " .. r.name .. "\n" .. r.expansion
    vim.lsp.util.open_floating_preview(vim.split(text, "\n"), "rust")
  end
))

vim.api.nvim_create_user_command("ReloadWorkspace", requests(
  "rust-analyzer/reloadWorkspace"
), {})

vim.api.nvim_create_user_command("RebuildProcMacros", requests(
  "rust-analyzer/reloadWorkspace"
), {})

vim.keymap.set("n", "<Leader>gp", requests(
  "experimental/parentModule", vim.lsp.util.make_position_params,
  function(r)
    vim.lsp.util.jump_to_location(r[1], "utf-8", true)
  end
))

--- syntax --------------------------------------------------------------------

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

--- completion ----------------------------------------------------------------

local npairs = require "nvim-autopairs"

npairs.setup { check_ts = true }
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm(),
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

--- bloat ---------------------------------------------------------------------

require("gitsigns").setup {}

require("fidget").setup {
  text = { spinner = "noise" },
  window = { blend = 0 },
  fmt = { max_width = 32, max_messages = 5 },
}

local session_manager = require "session_manager"
session_manager.setup {
  autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
        return
      end
    end
    session_manager.save_current_session()
  end
})
