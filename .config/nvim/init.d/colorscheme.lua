require("catppuccin").setup {
    transparent_background = true,
    color_overrides = {
        all = {
              base = "#151515",

              crust = "#202020",
              mantle = "#202020",

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
vim.g.airline_theme = "monochrome"
