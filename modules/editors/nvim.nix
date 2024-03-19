{ pkgs, ... }:

{
  programs = {
    nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      #vimdiffAlias = true;
      defaultEditor = true;

      options = {
        autoindent = true;
        backup = false;
        colorcolumn = "80";
        completeopt = [ "menu" "menuone" "noselect" ];
        conceallevel = 3;
        expandtab = true;
        fileencoding = "utf-8";
        fillchars = { eob = " "; };
        foldlevel = 99;

        guicursor = "";
        hidden = true;
        hlsearch = false;
        incsearch = true;
        list = true;
        # listchars = {
        #   space = ".";
        #   eol = "⏎";
        #   tab = "..";
        #   trail = "-";
        #   nbsp = "⎵";
        # };
        nu = true;
        number = true;
        pumheight = 15;
        relativenumber = true;
        scrolloff = 8;
        shiftwidth = 2;
        signcolumn = "yes";
        smartindent = true;
        smarttab = true;
        softtabstop = 2;
        swapfile = false;
        tabstop = 2;
        termguicolors = true;
        timeoutlen = 2500;
        updatetime = 50;
        wrap = false;
      };

      globals = { mapleader = " "; };

      colorschemes.nord = {
        enable = true;
        #settings = {
        borders = true;
        contrast = true;
        #};
      };

      # clipboard = {
      #   register = "unnamedplus";
      #   providers.wl-copy.enable = true;
      # };

      plugins = {
        auto-session = {
          enable = true;
          autoRestore.enabled = true;
          autoSave.enabled = true;
          autoSession = {
            enableLastSession = true;
            useGitBranch = true;
          };
        };
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp_luasnip.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
        cmp-nvim-lua.enable = true;
        comment-nvim.enable = true;
        fugitive = { enable = true; };
        gitblame.enable = true;
        gitsigns.enable = true;
        hardtime = {
          enable = true;
          disableMouse = true;
        };
        hmts = { enable = true; };
        harpoon = {
          enable = true;
          keymaps = {
            addFile = "<leader>a";
            toggleQuickMenu = "<C-e>";
            navFile = {
              "1" = "<C-j>";
              "2" = "<C-k>";
              "3" = "<C-l>";
              "4" = "<C-m>";
            };
            navNext = "<C-Tab>";
            navPrev = "<C-S-Tab>";
          };
        };
        illuminate.enable = true;
        inc-rename.enable = true;
        indent-blankline = { enable = true; };
        intellitab.enable = true;
        lastplace.enable = true;
        # lint = {
        #   enable = true;
        #   lintersByFt = {
        #     text = [ "vale" ];
        #     json = [ "jsonlint" ];
        #     markdown = [ "vale" ];
        #     rst = [ "vale" ];
        #     ruby = [ "ruby" ];
        #     janet = [ "janet" ];
        #     inko = [ "inko" ];
        #     clojure = [ "clj-kondo" ];
        #     dockerfile = [ "hadolint" ];
        #     terraform = [ "tflint" ];
        #     typscriptreact = [ "prettier_eslint" ];
        #   };
        # };
        lsp = {
          enable = true;
          servers = {
            clangd.enable = true;
            cmake.enable = true;
            # dockerls.enable = true;
            eslint.enable = true;
            gopls.enable = true;
            # graphql.enable = true;
            html.enable = true;
            jsonls.enable = true;
            lua-ls.enable = true;
            nil_ls.enable = true;
            pyright.enable = true;
            rust-analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            svelte.enable = true;
            # terraform-ls.enable = true;
            tsserver.enable = true;
            zls.enable = true;
          };
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              K = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";

            };
          };
        };
        lspkind = {
          enable = true;
          cmp.ellipsisChar = "...";
          cmp.menu = {
            buffer = "[Buffer]";
            nvim_lsp = "[LSP]";
            luasnip = "[LuaSnip]";
            nvim_lua = "[Lua]";
            latex_symbols = "[Latex]";
          };
          cmp.after = ''
            function(entry, vim_item, kind)
             local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. strings[1] .. " "
              kind.menu = "    " .. strings[2]
              return kind
             end
          '';
        };
        lspsaga.enable = true;
        lsp-format.enable = true;
        lsp-lines.enable = true;
        lualine = {
          enable = true;
          theme = "dracula";
          componentSeparators = {
            left = "";
            right = "";
          };
          sectionSeparators = {
            left = "";
            right = "";
          };
          inactiveSections = {
            lualine_a = null;
            lualine_b = null;
            lualine_c = null;
            lualine_x = null;
            lualine_y = null;
            lualine_z = null;
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "filename" "branch" ];
            lualine_c = [ "fileformat" ];
            lualine_x = [ "progress" ];
            lualine_y = [ "filetype" ];
            lualine_z = [ "location" ];
          };
        };
        luasnip.enable = true;
        markdown-preview.enable = true;
        nix.enable = true;
        nix-develop.enable = true;
        nvim-colorizer.enable = true;
        # nvim-cmp = {
        #   enable = true;
        #   autoEnableSources = true;
        #   sources = [{ name = "nvim_lsp"; }];
        #   mappingPresets = [ "insert" ];
        #   mapping = {
        #     "<C-Space>" = "cmp.mapping.complete()";
        #     "<CR>" = "cmp.mapping.confirm({ select = true })";
        #     "<C-p>" = "cmp.mapping.select_prev_item()";
        #     "<C-n>" = "cmp.mapping.select_next_item()";
        #   };
        #   formatting.fields = [ "kind" "abbr" "menu" ];
        # };
        nvim-autopairs.enable = true;
        # persistence.enable = true;
        project-nvim.enable = true;
        refactoring.enable = true;
        surround = {
          enable = true;
          package = pkgs.vimPlugins.nvim-surround;
        };
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<C-p>" = "git_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };
        # TODO: Use custom keymaps for tmux-navigator,
        #       so it does not clash with the harpoon keymaps.
        # tmux-navigator.enable = true;
        toggleterm.enable = true;
        treesitter = {
          enable = true;
          ensureInstalled = "all";
          nixGrammars = true;
        };
        treesitter-context.enable = true;
        trouble.enable = true;
        undotree = { enable = true; };
        which-key.enable = true;
        wilder.enable = true;
      };
      keymaps = [
        {
          key = "<Tab>";
          action = ":bnext<CR>";
          options = { silent = true; };
        }
        {
          key = "<S-Tab>";
          action = ":bprev<CR>";
          options = { silent = true; };
        }
        {
          key = "<C-s>";
          action = ":w<CR>";
          options = { silent = true; };
        }
        {
          key = "<C-q>";
          action = ":q<CR>";
          options = { silent = true; };
        }
        # {
        #   key = "<C-h>";
        #   action = "<C-w>h";
        #   options = { silent = true; };
        # }
        # {
        #   key = "<C-j>";
        #   action = "<C-w>j";
        #   options = { silent = true; };
        # }
        # {
        #   key = "<leader>x";
        #   action = ":bd<CR>";
        #   options = { silent = true; };
        # }
        {
          key = "<";
          action = "< gv";
          mode = [ "v" ];
          options = { silent = true; };
        }
        {
          key = ">";
          action = "> gv";
          mode = [ "v" ];
          options = { silent = true; };
        }
        {
          key = "<Esc>";
          action = ":noh<CR>";
          options = { silent = true; };
        }
        {
          key = "<leader>rn";
          action = ":IncRename ";
          # options = { silent = true; };
        }
        {
          key = "<leader>pv";
          action = ":Ex<CR>";
          options = { silent = true; };
        }
        {
          key = "<leader>u";
          action = ":UndotreeToggle<CR>";
          options = { silent = true; };
        }
        {
          key = "<leader>gs";
          action = ":Git<CR>";
          options = { silent = true; };
        }
        {
          key = "<leader>fp";
          action = ":Telescope projects<CR>";
          options = { silent = true; };
        }
        {
          key = "<leader>t";
          action = ":ToggleTerm<CR>";
          options = { silent = true; };
        }
      ];
    };
  };
}
