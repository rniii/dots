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

vim.cmd "colorscheme catppuccin"

vim.cmd [[
au TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Visual" }

hi IlluminatedWordText guibg=#303030
hi IlluminatedWordRead guibg=#303030
hi IlluminatedWordWrite guibg=#303030
]]

require("illuminate").configure {
  providers = {"lsp", "treesitter"}
}
