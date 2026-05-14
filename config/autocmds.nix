{
  autoCmd = [
    {
      event = [ "TextYankPost" ];
      group = "highlight_yank";
      callback.__raw = ''
        function()
          (vim.hl or vim.highlight).on_yank()
        end
      '';
    }
    {
      event = [ "FileType" ];
      group = "wrap_spell";
      pattern = [ "text" "plaintex" "typst" "gitcommit" ];
      callback.__raw = ''
        function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end
      '';
    }
    {
      # Defensive treesitter start — same as the original FileType * autocmd.
      event = [ "FileType" ];
      pattern = [ "*" ];
      callback.__raw = ''
        function()
          pcall(vim.treesitter.start)
        end
      '';
    }
  ];

  autoGroups = {
    highlight_yank = { clear = true; };
    wrap_spell = { clear = true; };
  };
}
