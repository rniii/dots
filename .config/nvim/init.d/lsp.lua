require("faye").setup()

local servers = {
  "ccls",                   -- C
  "clojure_lsp",            -- Clojure
  "crystalline",            -- Crystal
  "faye_lsp",               -- Faye
  "elmls",                  -- Elm
  "emmet_language_server",  -- HTML (Emmet abbrevs)
  "erlangls",               -- Erlang
  "hls",                    -- Haskell
  "ocamllsp",               -- OCaml
  "purescriptls",           -- Purescript
  "solargraph",             -- Ruby
  -- "ruby_ls",
  "rust_analyzer",          -- Rust
  "taplo",                  -- TOML
  "tsserver",               -- TS/JS
  "wgsl_analyzer",          -- WGSL shaders
  "zls",                    -- Zig
  -- snitched from vscode
  "cssls",    -- CSS
  "eslint",   -- TS/JS (eslint)
  "jsonls",   -- JSON
  "html",     -- HTML
}

local settings = {
  haskell = {
    plugin = {
      stan = { globalOn = false }, -- SHUT UP
    }
  },
  json = {
    schemas = require("schemastore").json.schemas(),
    validate = { enable = true },
  },
  ["rust-analyzer"] = {
    check = { command = "clippy" },
    imports = {
      granularity = { group = "module", enforce = true },
    },
  },
}

local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
  lspconfig[server].setup { capabilities = caps, settings = settings }
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

vim.diagnostic.config {
  virtual_text = { prefix = "･" },
  float = { prefix = function (d) return d.source .. " " end },
  severity_sort = true,
}

require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  autotag = { enable = true },
}

local injection = [[
(call_expression
  function: ((identifier) @_name (#eq? @_name "re"))
  arguments: ((template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "javascript")))
]]

local query = require("vim.treesitter.query")
query.set("typescript", "injections", injection)
query.set("tsx", "injections", injection)

-- shut up
vim.api.nvim_create_autocmd("FileType", {
  pattern = "htmldjango",
  callback = function() vim.o.filetype = "html" end
})

vim.treesitter.language.register("ruby", "crystal")

local npairs = require("nvim-autopairs")

npairs.setup {}
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.event:on(
    "confirm_done",
    require("nvim-autopairs.completion.cmp").on_confirm_done()
)

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

require("gitsigns").setup {}

require("fidget").setup {
    text = { spinner = "noise" },
    window = { blend = 0 },
    fmt = { max_dith = 32 },
}
