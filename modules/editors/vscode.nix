{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions;
        [
          arcticicestudio.nord-visual-studio-code
          bbenoist.nix
          dracula-theme.theme-dracula
          eamodio.gitlens
          esbenp.prettier-vscode
          foxundermoon.shell-format
          jnoortheen.nix-ide
          ms-python.python
          naumovs.color-highlight
          waderyan.gitblame
          arrterian.nix-env-selector
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-todo-highlight";
            publisher = "wayou";
            version = "1.0.5";
            sha256 = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
          }
          {
            name = "material-icon-theme";
            publisher = "PKief";
            version = "4.34.0";
            sha256 = "sha256-xxOEUvMjqJbl8lONB/So2NoIAVPOxysTq2YQY3iHGqo=";
          }
          {
            name = "Go";
            publisher = "golang";
            version = "0.41.1";
            sha256 = "sha256-tSt0IqRuE3nJgMYvdYUz5QDtzOsKKQqyW2KD1FEhkEQ=";
          }
        ];
      userSettings = {
        # Settings
        "workbench.settings.editor" = "json";
        "workbench.colorTheme" = "Nord";
        "workbench.iconTheme" = "material-icon-theme";
        "explorer.confirmDragAndDrop" = true;
        "explorer.confirmDelete" = false;
        "window.titleBarStyle" = "custom";
        "update.mode" = "none";
        # Terminal
        "terminal.integrated.fontFamily" =
          "'FiraCode Nerd Font Mono', 'Fira Code', monospace";
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
        "editor.rulers" = [ 80 120 ];
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
          "nil" = { "formatting" = { "command" = [ "nixpkgs-fmt" ]; }; };
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
        "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        # "[svelte]" = {
        #   "editor.defaultFormatter" = "svelte.svelte-vscode";
        # };
        "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[jsonc]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[yaml]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnPaste" = true;
          "editor.formatOnType" = true;
          "editor.formatOnSave" = true;
        };
        "telemetry.telemetryLevel" = "off";
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
}
