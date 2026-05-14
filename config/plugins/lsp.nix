{
  plugins.lsp = {
    enable = true;

    inlayHints = true;

    servers = {
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            runtime.version = "LuaJIT";
            workspace.checkThirdParty = false;
          };
        };
      };

      ts_ls.enable = true;

      eslint.enable = true;

      clangd.enable = true;

      gopls.enable = true;

      bashls = {
        enable = true;
        filetypes = [ "sh" ];
        settings.bashIde.globPattern = "*@(.sh|.inc|.bash|.command)";
      };

      clojure_lsp.enable = true;

      zls = {
        enable = true;
        # Format-on-save handled by the autocommand below.
      };

      pyright = {
        enable = true;
        filetypes = [ "python" ];
      };

      ruff = {
        enable = true;
        cmd = [ "ruff" "server" ];
        filetypes = [ "python" ];
        extraOptions.init_options.settings.configuration.format = {
          "quote-style" = "preserve";
        };
      };

      elp.enable = true;

      elixirls = {
        enable = true;
        extraOptions.settings = {
          dialyzerEnabled = false;
          enableTestLenses = false;
        };
      };

      nil_ls.enable = true;

      html.enable = true;
    };
  };

  plugins.rustaceanvim = {
    enable = true;
    settings.server.default_settings.rust-analyzer = {
      check = {
        command = "clippy";
        extraArgs = [ "--all" "--" "-W" "clippy::all" ];
      };
    };
  };

  plugins.haskell-tools = {
    enable = true;
    settings.hls.default_settings.haskell.formattingProvider = "fourmolu";
  };

  # elixir-tools.nvim has no nixvim module; we just enable the elixirls
  # language server above (see plugins.lsp.servers.elixirls).

  # conform-nvim handles the formatters that null-ls/none-ls used to run.
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        python = [ "ruff_format" "ruff_organize_imports" ];
        javascript = [ "prettierd" ];
        typescript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        yaml = [ "yamlfix" ];
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        go = [ "gofumpt" "goimports" ];
        haskell = [ "fourmolu" ];
        nix = [ "nixfmt" ];
      };
      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 500;
      };
    };
  };

  # Format-on-save for languages whose LSP owns formatting (zig).
  extraConfigLua = ''
    local zig_format_group = vim.api.nvim_create_augroup("ZigFormatOnSave", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = zig_format_group,
      pattern = "*.zig",
      callback = function() vim.lsp.buf.format() end,
    })
  '';
}
