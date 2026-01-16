{pkgs, ...}: {
  programs = {
    nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      #vimdiffAlias = true;
      defaultEditor = true;

      opts = {
        autoindent = true;
        backup = false;
        colorcolumn = "80";
        completeopt = [
          "menu"
          "menuone"
          "noselect"
        ];
        conceallevel = 3;
        expandtab = true;
        fileencoding = "utf-8";
        fillchars = {
          eob = " ";
        };
        foldlevel = 99;
        guicursor = "";
        hidden = true;
        hlsearch = false;
        incsearch = true;
        # list = true;
        # listchars = {
        #   space = "·";
        #   eol = "⏎";
        #   tab = "␉·";
        #   trail = "·";
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

      globals = {
        mapleader = " ";
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
          borders = true;
          contrast = true;
        };
      };

      # clipboard = {
      #   register = "unnamedplus";
      #   providers.wl-copy.enable = true;
      # };

      plugins = {
        # auto-session = {
        #   enable = true;
        #   settings = {
        #     auto_restore = true;
        #     auto_save = true;
        #     auto_restore_last_session = true;
        #     use_git_branch = true;
        #   };
        # };
        cloak = {
          enable = true;
          settings = {
            enabled = true;
            cloak_character = "*";
            cloak_telescope = true;
            highlight_group = "Comment";
            patterns = [
              {
                cloak_pattern = "=.+";
                file_pattern = ".env*";
              }
            ];
          };
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
            sources = [
              {name = "nvim_lsp";}
              {name = "luasnip";}
              {name = "path";}
              {name = "buffer";}
            ];
            snippet.expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
        };
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp_luasnip.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
        cmp-nvim-lua.enable = true;
        colorizer.enable = true;
        comment.enable = true;
        fugitive.enable = true;
        gitblame.enable = true;
        gitsigns.enable = true;
        hardtime = {
          enable = true;
          settings = {
            disable_mouse = true;
          };
        };
        hmts = {
          enable = true;
        };
        harpoon = {
          enable = true;
          enableTelescope = true;
        };
        illuminate.enable = true;
        inc-rename.enable = true;
        indent-blankline.enable = true;
        lastplace.enable = true;
        lint = {
          enable = true;
          lintersByFt = {
            text = ["vale"];
            json = ["jsonlint"];
            markdown = ["vale"];
            rst = ["vale"];
            dockerfile = ["hadolint"];
            terraform = ["tflint"];
            typscriptreact = ["prettier_eslint"];
          };
        };
        lsp = {
          enable = true;
          servers = {
            dartls.enable = true;
            dockerls.enable = true;
            gopls.enable = true;
            html.enable = true;
            htmx.enable = true;
            jsonls.enable = true;
            lua_ls.enable = true;
            nil_ls = {
              enable = true;
              settings = {
                nix.flake.autoArchive = true;
              };
            };
            pyright.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
            templ.enable = true;
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
          settings = {
            cmp = {
              ellipsisChar = "...";
              menu = {
                buffer = "[Buffer]";
                nvim_lsp = "[LSP]";
                luasnip = "[LuaSnip]";
                nvim_lua = "[Lua]";
                latex_symbols = "[Latex]";
              };
              after = ''
                function(entry, vim_item, kind)
                 local strings = vim.split(kind.kind, "%s", { trimempty = true })
                  kind.kind = " " .. strings[1] .. " "
                  kind.menu = "    " .. strings[2]
                  return kind
                 end
              '';
            };
          };
        };
        lspsaga.enable = true;
        lsp-format.enable = true;
        lsp-lines.enable = true;
        lualine = {
          enable = true;
          settings = {
            options = {
              theme = "auto";
              component_separators = {
                left = "";
                right = "";
              };
              section_separators = {
                left = "";
                right = "";
              };
            };
            inactive_sections = {
              lualine_a = [];
              lualine_b = [];
              lualine_c = ["filename"];
              lualine_x = ["location"];
              lualine_y = [];
              lualine_z = [];
            };
            sections = {
              lualine_a = ["mode"];
              lualine_b = [
                "branch"
                "diff"
                "diagnostics"
              ];
              lualine_c = [
                {
                  __unkeyed = "filename";
                  path = 1;
                  newfile_status = true;
                }
              ];
              lualine_x = [
                # Show active language server
                {
                  __unkeyed.__raw = ''
                    function()
                        local msg = ""
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end
                  '';
                  icon = "";
                  color.fg = "#ffffff";
                }
                "encoding"
                "fileformat"
                "filetype"
              ];
              lualine_y = ["progress"];
              lualine_z = ["location"];
            };
          };
        };
        luasnip.enable = true;
        markdown-preview.enable = true;
        nix.enable = true;
        nvim-autopairs.enable = true;
        refactoring.enable = true;
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
          nixGrammars = true;
          settings = {
            highlight.enable = true;
          };
        };
        treesitter-context.enable = true;
        trouble.enable = true;
        undotree = {
          enable = true;
        };
        web-devicons.enable = true;
        which-key.enable = true;
        # wilder.enable = true;
        zig.enable = true;
      };

      extraPlugins = with pkgs.vimPlugins; [neoformat nvim-treesitter-parsers.templ];

      keymaps = [
        {
          key = "<C-s>";
          action = ":w<CR>";
          options.silent = true;
        }
        {
          key = "<C-q>";
          action = ":q<CR>";
          options.silent = true;
        }
        {
          key = "<";
          action = "< gv";
          mode = ["v"];
          options.silent = true;
        }
        {
          key = ">";
          action = "> gv";
          mode = ["v"];
          options.silent = true;
        }
        {
          key = "<Esc>";
          action = ":noh<CR>";
          options.silent = true;
        }
        {
          key = "<leader>rn";
          action = ":IncRename ";
        }
        {
          key = "<leader>pv";
          action = ":Ex<CR>";
          options.silent = true;
        }
        {
          key = "<leader>u";
          action = ":UndotreeToggle<CR>";
          options.silent = true;
        }
        {
          key = "<leader>gg";
          action = ":Git<CR>";
          options.silent = true;
        }
        # {
        #   key = "<leader>fp";
        #   action = ":Telescope projects<CR>";
        #   options.silent = true;
        # }
        {
          key = "<leader>t";
          action = ":ToggleTerm<CR>";
          options.silent = true;
        }
        {
          key = ''<leader>q"'';
          action = ''ciw""<Esc>P'';
          options.silent = true;
        }
        {
          key = "<leader>q'";
          action = "ciw''<Esc>P";
          options.silent = true;
        }
        {
          key = "<leader>q`";
          action = "ciw``<Esc>P";
          options.silent = true;
        }
        {
          key = "<A-j>";
          action = ":m .+1<CR>==";
          options.silent = true;
        }
        {
          key = "<A-k>";
          action = ":m .-2<CR>==";
          options.silent = true;
        }
        {
          key = "<A-j>";
          mode = ["v"];
          action = ":m '>+1<CR>gv=gv";
          options.silent = true;
        }
        {
          key = "<C-k>";
          mode = ["v"];
          action = ":m '<-2<CR>gv==gv";
          options.silent = true;
        }
        {
          key = "<leader>gs";
          action = ":Gitsigns stage_hunk<CR>";
          options.silent = true;
        }
        {
          key = "<leader>gr";
          action = ":Gitsigns reset_hunk<CR>";
          options.silent = true;
        }
        {
          key = "<leader>gu";
          action = ":Gitsigns undo_stage_hunk<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>a";
          action.__raw = "function() require'harpoon':list():add() end";
        }
        {
          mode = "n";
          key = "<C-e>";
          action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
        }
        {
          mode = "n";
          key = "<C-j>";
          action.__raw = "function() require'harpoon':list():select(1) end";
        }
        {
          mode = "n";
          key = "<C-k>";
          action.__raw = "function() require'harpoon':list():select(2) end";
        }
        {
          mode = "n";
          key = "<C-l>";
          action.__raw = "function() require'harpoon':list():select(3) end";
        }
        {
          mode = "n";
          key = "<C-;>";
          action.__raw = "function() require'harpoon':list():select(4) end";
        }
      ];
    };
  };
}
