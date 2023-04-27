local cmp = require("cmp")
local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local caps = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs {"clojure_lsp", "rust_analyzer", "tsserver", "typeprof"} do
    lspconfig[server].setup { capabilities = caps }
end

require('nvim-treesitter.configs').setup {
    highlight = { enable = true },
    indent = { enable = true },
}

require("nvim-autopairs").setup {}

cmp.event:on(
    "confirm_done",
    require("nvim-autopairs.completion.cmp").on_confirm_done()
)

cmp.setup {
    snippet = { expand = function(args) luasnip.expand(args.body) end },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback) 
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
}
