local cmp = require("cmp")
local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local caps = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local settings = {
    ['rust-analyzer'] = {
        check = { command = "clippy" },
        imports = { granularity = { enforce = true } },
    },
}

for _, server in ipairs {"ccls", "clojure_lsp", "rust_analyzer", "tsserver"} do
    lspconfig[server].setup { capabilities = caps, settings = settings }
end

local function requests(name, get_params, cb)
    return function()
        vim.lsp.buf_request_all(0, name, get_params(), function(res)
            for _, r in ipairs(res) do
                if r ~= nil and r.result ~= nil then
                    cb(r.result)
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
    indent = { enable = true },
    autotag = { enable = true },
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
        ['<CR>'] = cmp.mapping.confirm {
            behavior = "replace",
            select = false,
        },
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
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    },
}
