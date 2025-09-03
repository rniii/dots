vim.o.termguicolors = true
vim.g.colors_name = "thorns"

local function hi(name, val)
  val.force = true
  val.cterm = val.cterm or {}
  vim.api.nvim_set_hl(0, name, val)
end

local c = {
  bg     = "#121212",
  bg1    = "#181818",
  bg2    = "#202020",
  bg3    = "#303030",

  fg     = "#d8d0d5",
  grey   = "#909090",

  pink   = "#ee95d2",
  red    = "#ee9598",
  orange = "#e8b197",
  yellow = "#e8d097",
  green  = "#9be099",
  cyan   = "#97d0e8",
  blue   = "#979ae8",
  purple = "#ca97e8",
}

vim.cmd [[hi clear]]
vim.cmd [[au TextYankPost * silent! lua vim.hl.on_yank { higroup = "Visual" }]]

hi("Normal",       { bg = c.bg  })
hi("WinBar",       { bg = c.bg1 })
hi("WinBarNC",     { bg = c.bg1 })
hi("StatusLine",   { bg = c.bg1 })
hi("StatusLineNC", { bg = c.bg1 })
hi("TabLine",      { bg = c.bg1 })
hi("TabLineSel",   { bg = c.bg1 })
hi("CursorLine",   { bg = c.bg1 })
hi("CursorColumn", { bg = c.bg1 })
hi("ColorColumn",  { bg = c.bg2 })
hi("Pmenu",        { bg = c.bg2 })
hi("Visual",       { bg = c.bg2 })
hi("Search",       { bg = c.bg3 })

hi("Number",     { fg = c.pink   })
hi("Boolean",    { fg = c.pink   })
hi("Error",      { fg = c.red    })
hi("Todo",       { fg = c.orange })
hi("Type",       { fg = c.yellow })
hi("String",     { fg = c.green  })
hi("Character",  { fg = c.cyan   })
hi("Operator",   { fg = c.cyan   })
hi("Special",    { fg = c.cyan   })
hi("Function",   { fg = c.blue   })
hi("Identifier", { fg = c.blue   })
hi("Keyword",    { fg = c.purple })
hi("PreProc",    { fg = c.purple })
hi("Statement",  { fg = c.purple })

hi("Comment",   { fg = c.grey })
hi("Delimiter", { fg = c.grey })

hi("Added",   { fg = c.green })
hi("Changed", { fg = c.yellow })
hi("Removed", { fg = c.red })

hi("Directory", { fg = c.blue })

hi("@type.builtin",        { fg = c.yellow })
hi("@constructor",         { fg = c.yellow })
hi("@function.builtin",    { fg = c.pink   })
hi("@constant",            { fg = c.pink   })
hi("@constant.builtin",    { fg = c.pink   })
hi("@punctuation.special", { fg = c.pink   })
hi("@string.escape",       { fg = c.pink   })
hi("@variable.member",     { fg = c.blue   })
hi("@lsp.type.parameter",  { fg = c.red    })

hi("@markup.heading.1", { fg = c.red    })
hi("@markup.heading.2", { fg = c.orange })
hi("@markup.heading.3", { fg = c.yellow })
hi("@markup.heading.4", { fg = c.green  })
hi("@markup.heading.5", { fg = c.cyan   })
hi("@markup.heading.6", { fg = c.blue   })

hi("@markup.link",     { fg = c.blue })
hi("@markup.link.url", { fg = c.cyan })

hi("@constructor.lua", { fg = c.grey })

hi("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
hi("@lsp.typemod.function.builtin",        { link = "@function.builtin" })

hi("IlluminatedWordRead",  { bg = c.bg3 })
hi("IlluminatedWordWrite", { bg = c.bg3 })
hi("IlluminatedWordText",  { bg = c.bg3 })
