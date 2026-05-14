{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins
  ];

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      transparent_background = true;
      integrations = {
        cmp = true;
        gitsigns = true;
        nvimtree = true;
        telescope.enabled = true;
        treesitter = true;
        which_key = true;
        indent_blankline.enabled = true;
        mason = true;
        native_lsp.enabled = true;
        rainbow_delimiters = true;
      };
    };
  };

  globals = {
    mapleader = " ";
    maplocalleader = " ";

    loaded_node_provider = 0;
    loaded_python3_provider = 0;
    loaded_perl_provider = 0;
    loaded_ruby_provider = 0;

    rustfmt_autosave = 1;
  };

  # Toolchain — replaces what mason-tool-installer used to fetch.
  # On NixOS the right place to manage these is the nix store, not ~/.local/share/nvim/mason.
  extraPackages = with pkgs; [
    # lua
    lua-language-server
    stylua

    # web / json / yaml
    typescript-language-server
    prettierd
    vscode-langservers-extracted # html, css, json, eslint
    yamlfix

    # python
    pyright
    ruff
    mypy

    # rust
    rust-analyzer
    clippy
    rustfmt

    # go
    gopls
    gofumpt
    goimports-reviser

    # c / c++
    clang-tools

    # zig
    zls

    # clojure
    clojure-lsp
    clj-kondo

    # haskell
    haskell-language-server
    haskellPackages.fourmolu

    # erlang / elixir
    elixir-ls
    erlang-language-platform

    # shell
    bash-language-server
    shfmt

    # nix
    nil
    nixfmt-rfc-style

    # search
    ripgrep
    fd
  ];
}
