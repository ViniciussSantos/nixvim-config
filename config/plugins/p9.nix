{
  extraConfigLua = builtins.readFile ../lua/p9.lua + ''

    require("p9").setup()
  '';
}
