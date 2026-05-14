{
  opts = {
    laststatus = 3;
    showmode = false;

    clipboard = "unnamedplus";
    cursorline = true;
    cursorlineopt = "number";

    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;

    fillchars = { eob = " "; };

    ignorecase = true;
    smartcase = true;
    mouse = "a";

    number = true;
    numberwidth = 2;
    ruler = false;

    signcolumn = "yes";
    splitbelow = true;
    splitright = true;
    timeoutlen = 400;
    undofile = true;

    spelllang = "en_us";
    updatetime = 250;
  };

  extraConfigLuaPre = ''
    vim.opt.shortmess:append("sI")
    vim.opt.whichwrap:append("<>[]hl")
  '';
}
