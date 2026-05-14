-- p9: workplace-specific filetype + treesitter highlight wiring.
--
-- The grammar (p9.so) and query files (queries/p9/highlights.scm) are NOT
-- bundled in this flake — they live in the mixrank repo. On a dev machine
-- you symlink them into your nvim runtime path, e.g.
--
--   ln -s ~/Projects/mixrank/src/performant/highlighters/tree-sitter/parser.so \
--         ~/.config/nvim/parser/p9.so
--   ln -s ~/Projects/mixrank/src/performant/highlighters/tree-sitter/queries/neovim \
--         ~/.config/nvim/queries/p9
--
-- pcall() makes everything below a no-op when the files aren't present.

package.preload["p9"] = function()
  local M = {}

  function M.setup(hl_override)
    vim.filetype.add({
      extension = { p9 = "p9" },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "p9",
      callback = function(args)
        pcall(vim.treesitter.start, args.buf, "p9")
      end,
    })

    -- Catppuccin Mocha palette.
    local p9_highlights = {
      ["@p9.header.key"]    = { fg = "#a6adc8" },
      ["@p9.header.val"]    = { fg = "#cdd6f4" },
      ["@p9.header.sep"]    = { fg = "#cba6f7" },
      ["@p9.header.def"]    = { fg = "#bac2de" },
      ["@p9.section.name"]  = { fg = "#fab387" },
      ["@p9.section.def"]   = { fg = "#fab387" },
      ["@p9.state.open"]    = { fg = "#cdd6f4" },
      ["@p9.state.exec"]    = { fg = "#a6e3a1", bold = true },
      ["@p9.state.wait"]    = { fg = "#f9e2af", bold = true },
      ["@p9.state.park"]    = { fg = "#f5e0dc", bold = true },
      ["@p9.state.done"]    = { fg = "#6c7086" },
      ["@p9.state.void"]    = { fg = "#585b70" },
      ["@p9.state.copy"]    = { fg = "#b4befe" },
      ["@p9.pointer"]       = { fg = "#6c7086" },
      ["@p9.owner.prim"]    = { fg = "#89b4fa", bold = true },
      ["@p9.owner.sec"]     = { fg = "#74c7ec" },
      ["@p9.metric"]        = { fg = "#94e2d5" },
      ["@p9.tag"]           = { fg = "#f5c2e7", bold = true },
      ["@p9.comment"]       = { fg = "#7f849c" },
      ["@p9.text"]          = { fg = "#cdd6f4" },
    }
    if hl_override then
      for group, opts in next, hl_override do
        p9_highlights[group] = opts
      end
    end
    for group, opts in pairs(p9_highlights) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  return M
end
