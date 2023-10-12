require("catppuccin").setup {
    transparent_background = true,
    color_overrides = {
        all = {
              base = "#151515",
              crust = "#151515",
              mantle = "#151515",

              surface0 = "#404040",
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
    }
}

vim.cmd "colorscheme catppuccin"

vim.g.airline_theme = "catppuccin"
vim.g.airline_detect_spell = 0
vim.g.airline_symbols = {
    branch = "",
    linenr = " ",
    maxlinenr = "",
    colnr = ":"
}

vim.cmd [[
au TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Visual" }

hi IlluminatedWordText guibg=#303030
hi IlluminatedWordRead guibg=#303030
hi IlluminatedWordWrite guibg=#303030
]]

require("illuminate").configure {
    providers = {"lsp", "treesitter"}
}

local function button(sc, text, keybind, opts)
    return {
        type = "button",
        val = text,
        on_press = function()
            vim.api.nvim_feedkeys(sc, "t", false)
        end,
        opts = vim.tbl_extend("keep", opts or {}, {
            shortcut = "  [" .. sc .. "] ",
            cursor = 3,
            align_shortcut = "left",
            hl = hl,
            hl_shortcut = {{"Delimiter", 0, 3}, {"Macro", 3, #sc + 3}, {"Delimiter", #sc + 3, #sc + 4}},
            keymap = { "n", sc, keybind, { noremap = true, silent = true, nowait = true } },
        })
    }
end

local function file_button(fn, sc) 
    local dir = vim.fn.fnamemodify(fn, ":h")

    return button(sc, fn, "<cmd>e " .. vim.fn.fnameescape(fn) .. " <CR>", {
        hl = {{"Comment", 0, dir ~= "." and #dir + 1 or 0 }}
    })
end

local function mru(start, cwd)
    local elements = {}
    for _, v in pairs(vim.v.oldfiles) do
        if #elements == 5 then
            break
        end

        if not cwd or vim.startswith(v, cwd .. "/") and (vim.fn.filereadable(v) == 1) and not vim.endswith(v, "COMMIT_EDITMSG") then
            table.insert(
                elements,
                file_button(
                    vim.fn.fnamemodify(v, cwd and ":." or ":~"),
                    tostring(#elements + start)
                )
            )
        end
    end

    return elements
end

require("alpha").setup {
    layout = {
        { type = "padding", val = 1 },
        {
            type = "text",
            val = function()
                return {
                    "█",
                    "█ ♡ " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~"),
                    "█"
                }
            end,
            opts = {
                hl = {
                    {{"SpecialComment", 0, 4}},
                    {{"SpecialComment", 0, 4}},
                    {{"SpecialComment", 0, 4}},
                }
            },
        },
        { type = "padding", val = 1 },
        { type = "group", val = function() return mru(0, vim.fn.getcwd()) end },
        { type = "padding", val = 1 },
        { type = "text", val = "▒ recent files" },
        { type = "padding", val = 1 },
        { type = "group", val = function() return mru(5) end },
        { type = "padding", val = 1 },
        button("i", "new file", ":ene | star <CR>"),
        button("q", "quit", ":q"),
    },
    opts = {
        margin = 1,
        redraw_on_resize = false,
        setup = function()
            vim.api.nvim_create_autocmd('DirChanged', {
                pattern = '*',
                group = "alpha_temp",
                callback = function() require('alpha').redraw() end,
            })
        end,
    },
}
