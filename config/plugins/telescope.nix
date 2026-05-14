{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;

    settings.defaults = {
      prompt_prefix = "   ";
      selection_caret = " ";
      entry_prefix = " ";
      sorting_strategy = "ascending";
      layout_config = {
        horizontal = {
          prompt_position = "top";
          preview_width = 0.55;
        };
        width = 0.87;
        height = 0.80;
      };
      mappings.n.q.__raw = ''require("telescope.actions").close'';
    };

    extensions = {
      fzf-native.enable = true;
      undo.enable = true;
    };
  };

  # Extensions not packaged in nixpkgs vimPlugins — fetch them directly.
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "telescope-egrepify.nvim";
      version = "2024-12-12";
      src = pkgs.fetchFromGitHub {
        owner = "fdschmidt93";
        repo = "telescope-egrepify.nvim";
        rev = "cd9342b95c1a8cff2e41ba5041ae3912f47595cc";
        hash = "sha256-jBKeAOKWlTaN11n8lfaxCdz5dXooy+bj//u6fPiTnKM=";
      };
    })
  ];

  extraConfigLua = ''
    require("telescope").load_extension("egrepify")
  '';
}
