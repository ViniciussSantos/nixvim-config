{ pkgs, ... }:
{
  plugins = {
    nvim-surround.enable = true;
    crates.enable = true;
    spectre.enable = true;
    comment.enable = true;
  };

  # Plugins not (yet) covered by a first-class nixvim module.
  extraPlugins = with pkgs.vimPlugins; [
    telescope-git-conflicts-nvim
  ];
}
