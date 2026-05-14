{
  plugins = {
    luasnip = {
      enable = true;
      settings = {
        history = true;
        update_events = [ "TextChanged" "TextChangedI" ];
      };
      fromVscode = [ { } ];
    };

    friendly-snippets.enable = true;

    cmp-nvim-lsp.enable = true;
    cmp-nvim-lua.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;

    nvim-autopairs = {
      enable = true;
      settings = {
        fast_wrap = { };
        disable_filetype = [ "TelescopePrompt" "vim" ];
      };
    };

    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        completion.completeopt = "menu,menuone";

        snippet.expand = ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';

        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "nvim_lua"; }
          { name = "path"; }
        ];

        mapping = {
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = ''
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            })
          '';
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };
      };
    };
  };

  # nvim-autopairs ↔ cmp integration
  extraConfigLua = ''
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- LuaSnip housekeeping: drop snippet sessions on InsertLeave
    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        local ls = require("luasnip")
        if
          ls.session.current_nodes[vim.api.nvim_get_current_buf()]
          and not ls.session.jump_active
        then
          ls.unlink_current()
        end
      end,
    })
  '';
}
