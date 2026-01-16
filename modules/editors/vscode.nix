{ pkgs, ... }:
{
  programs = {
    vscode = {
      enable = true;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions =
          with pkgs.vscode-extensions;
          [
            bbenoist.nix
            # catppuccin.catppuccin-vsc
            # catppuccin.catppuccin-vsc-icons
            dart-code.flutter
            eamodio.gitlens
            esbenp.prettier-vscode
            foxundermoon.shell-format
            golang.go
            jnoortheen.nix-ide
            mkhl.direnv
            ms-python.python
            naumovs.color-highlight
            waderyan.gitblame
            sumneko.lua
            vscodevim.vim
            tamasfe.even-better-toml
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-todo-highlight";
              publisher = "wayou";
              version = "1.0.5";
              sha256 = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
            }
            {
              name = "arb-editor";
              publisher = "google";
              version = "0.2.1";
              sha256 = "sha256-uHdQeW9ZXYg6+VnD6cb5CU10/xV5hCtxt5K+j0qb7as=";
            }
            {
              name = "tabletopsimulator-lua";
              publisher = "rolandostar";
              version = "1.1.3";
              sha256 = "sha256-3ulgyicmHdjJDrnV4mPse0QfkgSeC9oN9l+aa99lc1w=";
            }
          ];
        userSettings = {
          # Settings
          "workbench.settings.editor" = "json";
          "workbench.colorTheme" = "Catppuccin Macchiato";
          "workbench.iconTheme" = "catppuccin-macchiato";
          "explorer.confirmDragAndDrop" = true;
          "explorer.confirmDelete" = false;
          "window.titleBarStyle" = "custom";
          "update.mode" = "none";
          # Terminal
          "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono', 'Fira Code', monospace";
          # Font
          "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 15;
          # File stuff
          "files.eol" = "\n";
          "files.insertFinalNewline" = true;
          "files.trimTrailingWhitespace" = true;
          "files.exclude" = {
            "**/.git" = true;
            "**/.svn" = true;
            "**/.hg" = true;
            "**/CVS" = true;
            "**/.DS_Store" = true;
            "**/*.aux" = true;
            "**/*.fdb_latexmk" = true;
            "**/*.fls" = true;
            "**/*.lof" = true;
            "**/*.log" = true;
            "**/*.lot" = true;
            "**/*.out" = true;
            "**/*.synctex.gz" = true;
            "**/*.toc" = true;
          };
          "files.watcherExclude" = {
            "**/.git/objects/**" = true;
            "**/.git/subtree-cache/**" = true;
            "**/node_modules/*/**" = true;
            "**/.hg/store/**" = true;
          };
          # Editor stuff
          "editor.detectIndentation" = true;
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
          "editor.renderWhitespace" = "all";
          "editor.rulers" = [
            80
            120
          ];
          "editor.formatOnType" = true;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnSaveMode" = "modifications";
          "editor.suggestSelection" = "recentlyUsedByPrefix";
          "editor.emptySelectionClipboard" = true;
          # Nix
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.formatterPath" = "nixpkgs-fmt";
          "nix.serverSettings" = {
            "nil" = {
              "formatting" = {
                "command" = [ "nixpkgs-fmt" ];
              };
            };
          };
          # Python
          "[python]" = {
            "diffEditor.ignoreTrimWhitespace" = false;
            "gitlens.codeLens.symbolScopes" = [ "!Module" ];
            "editor.formatOnPaste" = true;
            "editor.formatOnType" = true;
            "editor.formatOnSave" = true;
            "editor.formatOnSaveMode" = "modificationsIfAvailable";
            "editor.wordBasedSuggestions" = "off";
            "editor.defaultFormatter" = "ms-python.python";
          };
          # Other
          "typescript.updateImportsOnFileMove.enabled" = "always";
          "[html]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          # "[svelte]" = {
          #   "editor.defaultFormatter" = "svelte.svelte-vscode";
          # };
          "[css]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[json]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[yaml]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnPaste" = true;
            "editor.formatOnType" = true;
            "editor.formatOnSave" = true;
          };
          "[dart]" = {
            "editor.formatOnSave" = true;
            "editor.formatOnType" = true;
            "editor.rulers" = [ 80 ];
            "editor.selectionHighlight" = false;
            "editor.suggestSelection" = "first";
            "editor.tabCompletion" = "onlySnippets";
            "editor.wordBasedSuggestions" = "off";
          };
          "dart.checkForSdkUpdates" = false;
          "telemetry.telemetryLevel" = "off";
          "extensions.ignoreRecommendations" = true;
          "git.openRepositoryInParentFolders" = "never";
          "vim.easymotion" = true;
          "vim.incsearch" = true;
          "vim.useSystemClipboard" = true;
          "vim.useCtrlKeys" = true;
          "vim.hlsearch" = true;
          "vim.insertModeKeyBindings" = [
            {
              "before" = [
                "j"
                "j"
              ];
              "after" = [ "<Esc>" ];
            }
          ];
          "vim.normalModeKeyBindingsNonRecursive" = [
            {
              "before" = [
                "<leader>"
                "p"
                "v"
              ];
              "after" = [
                ":"
                "E"
                "x"
                "<enter>"
              ];
            }
            {
              "before" = [
                "<leader>"
                "d"
              ];
              "after" = [
                "d"
                "d"
              ];
            }
            {
              "before" = [ "<C-n" ];
              "after" = [ ":nohl" ];
            }
            {
              "before" = [ "K" ];
              "commands" = [ "lineBreakInsert" ];
              "silent" = true;
            }
          ];
          "vim.leader" = "<space>";
          "vim.handleKeys" = {
            "<C-a" = false;
            "<C-s>" = false;
            "<C-w>" = false;
            "<C-f>" = false;
            "<C-p>" = false;
          };
          "vim.smartRelativeLine" = true;
          "vim.changeWordIncludesWhitespace" = false;
          "extensions.experimental.affinity" = {
            "vscodevim.vim" = 1;
          };
        };
        keybindings = [
          {
            "key" = "ctrl+shift+u";
            "command" = "editor.action.transformToUppercase";
          }
          {
            "key" = "ctrl+shift+l";
            "command" = "editor.action.transformToLowercase";
          }
          {
            "key" = "cmd+y";
            "command" = "redo";
            "when" = "textInputFocus && !editorReadonly";
          }
          {
            "key" = "shift+cmd+z";
            "command" = "-redo";
            "when" = "textInputFocus && !editorReadonly";
          }
          {
            "key" = "shift+alt+s";
            "command" = "workbench.userDataSync.actions.syncNow";
          }
          {
            "key" = "alt+cmd+o";
            "command" = "python.sortImports";
          }
          {
            "key" = "alt+down";
            "command" = "editor.action.moveLinesDownAction";
          }
          {
            "key" = "alt+up";
            "command" = "editor.action.moveLinesUpAction";
          }
          {
            "key" = "shift+alt+down";
            "command" = "editor.action.copyLinesDownAction";
          }
          {
            "key" = "shift+alt+up";
            "command" = "editor.action.copyLinesUpAction";
          }
        ];
      };
    };
  };
}
