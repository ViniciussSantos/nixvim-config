{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          use_languagetree = true;
        };
        indent.enable = true;
      };
    };

    treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
        };
        move = {
          enable = true;
          set_jumps = true;
        };
      };
    };
  };
}
