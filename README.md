## Run

One-shot, no install:

```bash
nix run github:ViniciussSantos/nixvim-config
```

Or install into a profile:

```bash
nix profile install github:ViniciussSantos/nixvim-config
```

Or wire it into a NixOS / home-manager config:

```nix
# configuration.nix
environment.systemPackages = [ inputs.nixvim-config.packages.${pkgs.system}.default ];
```

## Layout

```
flake.nix                  # inputs (nixpkgs unstable + nixvim) + makeNixvim
config/
├── default.nix            # toolchain (extraPackages), colorscheme, globals
├── options.nix            # vim options
├── keymaps.nix            # all keymaps (incl. LSP-on-attach + treesitter-textobjects)
├── autocmds.nix           # autocommands
├── plugins/
│   ├── default.nix        # imports
│   ├── ui.nix             # lualine, bufferline, nvim-tree, indent-blankline, which-key, toggleterm
│   ├── treesitter.nix     # treesitter + textobjects
│   ├── telescope.nix      # telescope + fzf-native + undo + egrepify
│   ├── cmp.nix            # nvim-cmp + luasnip + autopairs
│   ├── lsp.nix            # nvim-lspconfig + rustaceanvim + haskell-tools + elixir-tools + conform
│   ├── git.nix            # fugitive + gitsigns
│   ├── misc.nix           # plenary, surround, crates, spectre, comment, telescope-git-conflicts
│   └── p9.nix             # workplace-specific p9 grammar wiring
└── lua/
    └── p9.lua             # filetype + tree-sitter highlight setup for the p9 lang
```

## Differences from the original NvChad config

NvChad's runtime (`base46` cache compilation, `nvchad/ui`, `nvchad.tabufline`,
`nvchad.term`) doesn't fit the nix-store model cleanly, so it was replaced
with the standard nixvim equivalents:

| NvChad piece          | Replacement              |
|-----------------------|--------------------------|
| `nvchad/ui` statusline| `lualine.nvim`           |
| `nvchad.tabufline`    | `bufferline.nvim`        |
| `nvchad.term`         | `toggleterm.nvim`        |
| `chadrc` theme        | `catppuccin.nvim` (mocha)|
| `nvchad.lsp.renamer`  | `vim.lsp.buf.rename`     |
| `mason` + tool installer | `extraPackages` in `default.nix` |
| `none-ls` (null-ls)   | `conform-nvim`           |
