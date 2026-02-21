# gruvcat

A Neovim colorscheme that marries the **Gruvbox Medium** palette with
[catppuccin/nvim](https://github.com/catppuccin/nvim)'s comprehensive highlight system —
100+ plugin integrations, compilation cache, transparent background, `dim_inactive`, and more.

## Requirements

- Neovim 0.8+
- [catppuccin/nvim](https://github.com/catppuccin/nvim) installed as a dependency

## Installation

### lazy.nvim

```lua
{
  "saumyajyoti/gruvcat",
  dependencies = { "catppuccin/nvim" },
  config = function()
    require("gruvcat").setup({
      variant = "dark", -- "dark" | "light" | "auto"
    })
    vim.cmd.colorscheme("gruvcat")
  end,
}
```

### packer.nvim

```lua
use {
  "saumyajyoti/gruvcat",
  requires = { "catppuccin/nvim" },
  config = function()
    require("gruvcat").setup({ variant = "dark" })
    vim.cmd.colorscheme("gruvcat")
  end,
}
```

## Usage

```lua
-- Minimal (uses defaults: variant="auto", background follows vim.o.background)
vim.cmd.colorscheme("gruvcat")

-- With options
require("gruvcat").setup({
  variant = "dark",           -- force dark regardless of vim.o.background
  catppuccin = {
    transparent_background = true,
    no_italic = true,
    integrations = {
      nvimtree = true,
      telescope = { enabled = true },
      indent_blankline = { enabled = true },
    },
  },
})
vim.cmd.colorscheme("gruvcat")
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `variant` | `"auto"` | `"dark"`, `"light"`, or `"auto"` (follows `vim.o.background`) |
| `catppuccin.*` | see below | All catppuccin options, forwarded directly to `catppuccin.setup()` |

### catppuccin passthrough options (nested under `catppuccin = { ... }`)

| Option | Default |
|--------|---------|
| `default_integrations` | `true` |
| `transparent_background` | `false` |
| `show_end_of_buffer` | `false` |
| `term_colors` | `false` |
| `dim_inactive.enabled` | `false` |
| `no_italic` | `false` |
| `no_bold` | `false` |
| `no_underline` | `false` |
| `styles` | catppuccin defaults |
| `integrations` | `{}` (catppuccin auto-detects) |

See [catppuccin/nvim docs](https://github.com/catppuccin/nvim#configuration) for the full list.

## Palette

### Dark (`variant = "dark"`)

Maps catppuccin's palette keys to **Gruvbox Medium Dark** colors.

| Role | Catppuccin key | Hex | Gruvbox source |
|------|----------------|-----|----------------|
| Hardest bg | `crust` | `#1d2021` | bg0_hard |
| Dark bg | `mantle` / `base` | `#282828` | bg0 |
| Soft bg | `surface0` | `#32302f` | bg0_soft |
| Bg highlight | `surface1` | `#3c3836` | bg1 |
| Selection | `surface2` | `#504945` | bg2 |
| Comment | `overlay0` | `#665c54` | bg3 |
| Line no | `overlay1` | `#7c6f64` | bg4 |
| Indent | `overlay2` | `#928374` | gray |
| Subtext | `subtext0` | `#a89984` | fg4 |
| Subtext | `subtext1` | `#bdae93` | fg3 |
| Foreground | `text` | `#ebdbb2` | fg1 |
| Cream | `rosewater` | `#d5c4a1` | fg2 |
| Coral | `flamingo` | `#e78a4e` | earthy blend |
| Purple | `pink` / `mauve` | `#d3869b` | bright_purple |
| Red | `red` | `#fb4934` | bright_red |
| Dark red | `maroon` | `#cc241d` | neutral_red |
| Orange | `peach` | `#fe8019` | bright_orange |
| Yellow | `yellow` | `#fabd2f` | bright_yellow |
| Green | `green` | `#b8bb26` | bright_green |
| Aqua | `teal` | `#8ec07c` | bright_aqua |
| Blue | `sky` / `blue` | `#83a598` | bright_blue |
| Dark blue | `sapphire` | `#458588` | neutral_blue |
| Dark purple | `lavender` | `#b16286` | neutral_purple |

### Light (`variant = "light"`)

Maps catppuccin's palette keys to **Gruvbox Medium Light** colors.
Accents use **neutral/faded** variants — brights are unreadable on cream backgrounds.

| Role | Catppuccin key | Hex | Gruvbox source |
|------|----------------|-----|----------------|
| Lightest bg | `base` | `#fbf1c7` | light0 |
| Soft bg | `mantle` | `#f2e5bc` | light0_soft |
| Hard bg | `crust` | `#ebdbb2` | light1 |
| Bg tints | `surface0–2` | `#ebdbb2`–`#bdae93` | light1–light3 |
| Overlays | `overlay0–2` | `#665c54`–`#928374` | dark3–gray |
| Foreground | `text` | `#282828` | dark0 |
| Dark red | `rosewater` | `#cc241d` | neutral_red |
| Orange | `flamingo` | `#d65d0e` | neutral_orange |
| Purple | `pink` | `#b16286` | neutral_purple |
| Faded purple | `mauve` | `#8f3f71` | faded_purple |
| Faded red | `red` | `#9d0006` | faded_red |
| Faded orange | `peach` | `#af3a03` | faded_orange |
| Faded yellow | `yellow` | `#b57614` | faded_yellow |
| Faded green | `green` | `#79740e` | faded_green |
| Faded aqua | `teal` | `#427b58` | faded_aqua |
| Neutral aqua | `sky` | `#689d6a` | neutral_aqua |
| Faded blue | `sapphire` | `#076678` | faded_blue |
| Neutral blue | `blue` | `#458588` | neutral_blue |

## Design Notes

- Uses catppuccin's official `color_overrides` API — no internal hacking.
- Dark uses `mocha` as the base flavor; light uses `latte`.
- `variant = "auto"` respects `vim.o.background`, enabling integration with
  plugins that toggle the background (lualine auto-theme, f-string toggles, etc.).
- `flamingo = #e78a4e` is the only non-canonical Gruvbox color; Gruvbox has no
  true coral, so this earthy orange-red fills catppuccin's flamingo slot naturally.

## License

MIT
