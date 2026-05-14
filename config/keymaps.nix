{
  # Inline lua keymaps. Each entry: { mode, key, action, options.desc }.
  # `lua = true` means `action` is a lua expression (function value).
  keymaps =
    let
      n = key: action: desc: {
        mode = "n";
        inherit key action;
        options = { inherit desc; silent = true; };
      };
      i = key: action: desc: {
        mode = "i";
        inherit key action;
        options = { inherit desc; silent = true; };
      };
      v = key: action: desc: {
        mode = "v";
        inherit key action;
        options = { inherit desc; silent = true; };
      };
      t = key: action: desc: {
        mode = "t";
        inherit key action;
        options = { inherit desc; silent = true; };
      };
      luaN = key: action: desc: {
        mode = "n";
        inherit key action;
        lua = true;
        options = { inherit desc; silent = true; };
      };
      luaNT = key: action: desc: {
        mode = [ "n" "t" ];
        inherit key action;
        lua = true;
        options = { inherit desc; silent = true; };
      };
    in
    [
      # insert mode movement
      (i "<C-b>" "<ESC>^i" "move beginning of line")
      (i "<C-e>" "<End>" "move end of line")
      (i "<C-h>" "<Left>" "move left")
      (i "<C-l>" "<Right>" "move right")
      (i "<C-j>" "<Down>" "move down")
      (i "<C-k>" "<Up>" "move up")

      # window navigation
      (n "<C-h>" "<C-w>h" "switch window left")
      (n "<C-l>" "<C-w>l" "switch window right")
      (n "<C-j>" "<C-w>j" "switch window down")
      (n "<C-k>" "<C-w>k" "switch window up")

      # general
      (n "<Esc>" "<cmd>noh<CR>" "clear highlights")
      (n "<C-s>" "<cmd>w<CR>" "save file")
      (n "<C-c>" "<cmd>%y+<CR>" "copy whole file")
      (n "<leader>n" "<cmd>set nu!<CR>" "toggle line number")
      (n "<leader>rn" "<cmd>set rnu!<CR>" "toggle relative number")

      (luaN "<leader>fm" "function() vim.lsp.buf.format({ async = true }) end" "format file")
      (luaN "<leader>ds" "vim.diagnostic.setloclist" "diagnostic loclist")
      (luaN "<leader>lf" ''function() vim.diagnostic.open_float({ border = "rounded" }) end'' "floating diagnostic")

      # buffers (via bufferline)
      (n "<leader>b" "<cmd>enew<CR>" "buffer new")
      (n "<tab>" "<cmd>BufferLineCycleNext<CR>" "buffer next")
      (n "<S-tab>" "<cmd>BufferLineCyclePrev<CR>" "buffer prev")
      (n "<leader>x" "<cmd>bdelete<CR>" "buffer close")

      # comment (Comment.nvim provides gcc/gc)
      (n "<leader>/" "gcc" "toggle comment")
      (v "<leader>/" "gc" "toggle comment")

      # nvim-tree
      (n "<C-n>" "<cmd>NvimTreeToggle<CR>" "nvimtree toggle")
      (n "<leader>e" "<cmd>NvimTreeFocus<CR>" "nvimtree focus")

      # telescope
      (n "<leader>fw" "<cmd>Telescope egrepify<CR>" "telescope live grep")
      (n "<leader>fb" "<cmd>Telescope buffers<CR>" "telescope buffers")
      (n "<leader>fh" "<cmd>Telescope help_tags<CR>" "telescope help")
      (n "<leader>ma" "<cmd>Telescope marks<CR>" "telescope marks")
      (n "<leader>fo" "<cmd>Telescope oldfiles<CR>" "telescope oldfiles")
      (n "<leader>fz" "<cmd>Telescope current_buffer_fuzzy_find<CR>" "telescope fuzzy find buffer")
      (n "<leader>cm" "<cmd>Telescope git_commits<CR>" "telescope git commits")
      (n "<leader>cb" "<cmd>Telescope git_bcommits<CR>" "telescope git buffer commits")
      (n "<leader>gt" "<cmd>Telescope git_status<CR>" "telescope git status")
      (n "<leader>tc" "<cmd>Telescope conflicts<CR>" "telescope git conflicts")
      (n "<leader>ts" "<cmd>Telescope treesitter<CR>" "telescope treesitter")
      (n "<leader>u" "<cmd>Telescope undo<CR>" "telescope undo")
      (n "<leader>td" "<cmd>Telescope lsp_document_symbols<CR>" "telescope LSP symbols")
      (n "<leader>ff" "<cmd>Telescope find_files<cr>" "telescope find files")
      (n "<leader>fa" "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>" "telescope find all files")

      # terminal
      (t "<C-x>" "<C-\\><C-N>" "terminal escape")
      (luaN "<leader>h" ''function() require("toggleterm").exec("", nil, nil, nil, "horizontal") end'' "new horizontal terminal")
      (luaN "<leader>v" ''function() require("toggleterm").exec("", nil, nil, nil, "vertical") end'' "new vertical terminal")
      (luaNT "<A-v>" ''function() require("toggleterm").toggle(1, nil, nil, "vertical") end'' "toggle vertical terminal")
      (luaNT "<A-h>" ''function() require("toggleterm").toggle(2, nil, nil, "horizontal") end'' "toggle horizontal terminal")
      (luaNT "<A-i>" ''function() require("toggleterm").toggle(3, nil, nil, "float") end'' "toggle floating terminal")

      # which-key
      (n "<leader>wK" "<cmd>WhichKey <CR>" "whichkey all keymaps")
      (luaN "<leader>wk"
        ''function() vim.cmd("WhichKey " .. vim.fn.input("WhichKey: ")) end''
        "whichkey query lookup")

      # transparency toggle (catppuccin)
      (luaN "<leader>to"
        ''
        function()
          local cp = require("catppuccin")
          cp.options.transparent_background = not cp.options.transparent_background
          vim.cmd.colorscheme("catppuccin")
        end
        ''
        "toggle transparency")

      # fugitive
      (n "<leader>gsf" "<cmd>G add %<CR>" "git add file")
      (n "<leader>gst" "<cmd>G status<CR>" "git status")
      (n "<leader>gss" "<cmd>G stash<CR>" "git stash")
      (n "<leader>gsp" "<cmd>G stash pop<CR>" "git stash pop")
      (n "<leader>gmc" "<cmd>Gvdiffsplit!<CR>" "git 3-way merge diff")

      # crates.nvim
      (luaN "<leader>rcu" ''function() require("crates").update_all_crates() end'' "Crate update all")
      (luaN "<leader>rcr" ''function() require("crates").open_documentation() end'' "Crate open docs")
      (luaN "<leader>rcp" ''function() require("crates").show_features_popup() end'' "Crate features popup")

      # gitsigns
      (luaN "<leader>ghs" ''function() require("gitsigns").stage_hunk() end'' "Git stage hunk")
      {
        mode = "v";
        key = "<leader>ghs";
        action = ''function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end'';
        lua = true;
        options = { desc = "Git stage hunk"; silent = true; };
      }
      (luaN "<leader>gb" ''function() require("gitsigns").blame_line({ full = false }) end'' "git blame")
      (luaN "<leader>rh" ''function() require("gitsigns").reset_hunk() end'' "reset hunk")
      (luaN "<leader>ph" ''function() require("gitsigns").preview_hunk() end'' "preview hunk")

      # spectre
      (luaN "<leader>S" ''function() require("spectre").toggle() end'' "Spectre toggle")
      (luaN "<leader>sw" ''function() require("spectre").open_visual({ select_word = true }) end'' "Spectre word")
      (luaN "<leader>sp" ''function() require("spectre").open_file_search({ select_word = true }) end'' "Spectre file")
      {
        mode = "v";
        key = "<leader>sw";
        action = ''function() require("spectre").open_visual({ select_word = true }) end'';
        lua = true;
        options = { desc = "Spectre word"; silent = true; };
      }
    ];

  # treesitter-textobjects + LSP-on-attach keymaps go in extraConfigLua so they
  # can call `require()` and run inside an autocommand.
  extraConfigLua = ''
    -- LSP on-attach keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP " .. desc, silent = true })
        end
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders")
        map("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "<leader>ra", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "gr", vim.lsp.buf.references, "Show references")
        map("n", "gK", vim.lsp.buf.signature_help, "signature Help")
      end,
    })

    -- treesitter-textobjects: select / swap / move
    local ok_select, select = pcall(require, "nvim-treesitter-textobjects.select")
    local ok_swap,   swap   = pcall(require, "nvim-treesitter-textobjects.swap")
    local ok_move,   move   = pcall(require, "nvim-treesitter-textobjects.move")
    local ok_rep,    rep    = pcall(require, "nvim-treesitter-textobjects.repeatable_move")

    if ok_select then
      local pairs_ = {
        { "a=", "@assignment.outer", "outer assignment" },
        { "i=", "@assignment.inner", "inner assignment" },
        { "l=", "@assignment.lhs",   "assignment lhs" },
        { "r=", "@assignment.rhs",   "assignment rhs" },
        { "a:", "@property.outer",   "outer property" },
        { "i:", "@property.inner",   "inner property" },
        { "l:", "@property.lhs",     "property lhs" },
        { "r:", "@property.rhs",     "property rhs" },
        { "aa", "@parameter.outer",  "outer parameter" },
        { "ia", "@parameter.inner",  "inner parameter" },
        { "ai", "@conditional.outer","outer conditional" },
        { "ii", "@conditional.inner","inner conditional" },
        { "al", "@loop.outer",       "outer loop" },
        { "il", "@loop.inner",       "inner loop" },
        { "af", "@call.outer",       "outer call" },
        { "if", "@call.inner",       "inner call" },
        { "am", "@function.outer",   "outer function" },
        { "im", "@function.inner",   "inner function" },
        { "ac", "@class.outer",      "outer class" },
        { "ic", "@class.inner",      "inner class" },
      }
      for _, p in ipairs(pairs_) do
        vim.keymap.set({ "x", "o" }, p[1], function()
          select.select_textobject(p[2], "textobjects")
        end, { desc = "Select " .. p[3] })
      end
    end

    if ok_swap then
      vim.keymap.set("n", "<leader>a",  function() swap.swap_next("@parameter.inner")    end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>A",  function() swap.swap_previous("@parameter.inner") end, { desc = "Swap prev parameter" })
      vim.keymap.set("n", "<leader>pn", function() swap.swap_next("@function.outer")     end, { desc = "Swap next function" })
      vim.keymap.set("n", "<leader>pm", function() swap.swap_previous("@function.outer") end, { desc = "Swap prev function" })
    end

    if ok_move then
      local moves = {
        { "]f", "goto_next_start",     "@call.outer",        "Next call start" },
        { "]m", "goto_next_start",     "@function.outer",    "Next function start" },
        { "]c", "goto_next_start",     "@class.outer",       "Next class start" },
        { "]i", "goto_next_start",     "@conditional.outer", "Next conditional start" },
        { "]l", "goto_next_start",     "@loop.outer",        "Next loop start" },
        { "]F", "goto_next_end",       "@call.outer",        "Next call end" },
        { "]M", "goto_next_end",       "@function.outer",    "Next function end" },
        { "]C", "goto_next_end",       "@class.outer",       "Next class end" },
        { "]I", "goto_next_end",       "@conditional.outer", "Next conditional end" },
        { "]L", "goto_next_end",       "@loop.outer",        "Next loop end" },
        { "[f", "goto_previous_start", "@call.outer",        "Prev call start" },
        { "[m", "goto_previous_start", "@function.outer",    "Prev function start" },
        { "[c", "goto_previous_start", "@class.outer",       "Prev class start" },
        { "[i", "goto_previous_start", "@conditional.outer", "Prev conditional start" },
        { "[l", "goto_previous_start", "@loop.outer",        "Prev loop start" },
        { "[F", "goto_previous_end",   "@call.outer",        "Prev call end" },
        { "[M", "goto_previous_end",   "@function.outer",    "Prev function end" },
        { "[C", "goto_previous_end",   "@class.outer",       "Prev class end" },
        { "[I", "goto_previous_end",   "@conditional.outer", "Prev conditional end" },
        { "[L", "goto_previous_end",   "@loop.outer",        "Prev loop end" },
      }
      for _, m in ipairs(moves) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
          move[m[2]](m[3], "textobjects")
        end, { desc = m[4] })
      end
      vim.keymap.set({ "n", "x", "o" }, "]s", function() move.goto_next_start("@local.scope", "locals") end, { desc = "Next scope" })
      vim.keymap.set({ "n", "x", "o" }, "]z", function() move.goto_next_start("@fold", "folds") end,        { desc = "Next fold" })
    end

    if ok_rep then
      vim.keymap.set({ "n", "x", "o" }, ";", rep.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", rep.repeat_last_move_previous)
      vim.keymap.set({ "n", "x", "o" }, "f", rep.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", rep.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", rep.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", rep.builtin_T_expr, { expr = true })
    end
  '';
}
