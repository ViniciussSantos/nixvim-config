{
  plugins = {
    fugitive.enable = true;

    gitsigns = {
      enable = true;
      settings = {
        signs = {
          delete.text = "󰍵";
          changedelete.text = "󱕖";
        };
      };
    };
  };
}
