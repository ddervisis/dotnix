{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = false;
      extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-docker
        dracula-theme.theme-dracula
        eamodio.gitlens
        bbenoist.nix
        esbenp.prettier-vscode
        ms-python.vscode-pylance
        # ms-python.python # attribute missing?
        # ms-vscode-remote.remote-containers # attribute missing?
        ms-vscode-remote.remote-ssh
        # ms-vscode-remote.remote-ssh-edit # attribute missing?
        # ms-vscode-remote.remote-wsl # attribute missing?
        # ms-vscode.vscode-typescript-tslint-plugin # attribute missing?
        redhat.vscode-yaml
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "sort-imports";
          publisher = "amatiasq";
          version = "6.2.6";
          sha256 = "1gcsvkpqvgr0dk4rl6h8n407g76hxhmm2awn982pkd2j27wdd1hk";
        }
        {
          name = "path-intellisense";
          publisher = "christian-kohler";
          version = "2.4.0";
          sha256 = "0fqfxhn5ap2lvwnx5spybj1k55nifqnpaqr3ki2wcrbb0hkmg1l4";
        }
        {
          name = "regex";
          publisher = "chrmarti";
          version = "0.4.0";
          sha256 = "0krmwwgi5wai5mx3jh45kdv8mblnn71cygasxh3rh0l86in9686p";
        }
        {
          name = "vscode-svgviewer";
          publisher = "cssho";
          version = "2.0.0";
          sha256 = "06swlqiv3gc7plcbmzz795y6zwpxsdhg79k1n3jj6qngfwnv2p6z";
        }
        {
          name = "vscode-faker";
          publisher = "deerawan";
          version = "1.5.0";
          sha256 = "0in9zmkvdsnqmvn79zywpxi1f336i3zk03vlrfqc1zffcf6wdyvp";
        }
        {
          name = "es7-react-js-snippets";
          publisher = "dsznajder";
          version = "3.1.1";
          sha256 = "1fs55yfp9ssz57szl10ymqnhfmm19nzh3y2zm3x48hbdcr28mzwp";
        }
        {
          name = "remote-containers";
          publisher = "ms-vscode-remote";
          version = "0.191.0";
          sha256 = "0zcvfv045k9v0ni7xd2kw3l0k2rw3177azmrx6yjs8iwh17q8jal";
        }
        {
          name = "remote-ssh";
          publisher = "ms-vscode-remote";
          version = "0.65.7";
          sha256 = "10ynl4pzlxy2k8f2zk3nfkp81br12a2aa6hzpd3zfnpwg6zc91mf";
        }
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.65.7";
          sha256 = "1q5x6ds2wlg3q98ybvic00j19l33pablx7wczywa7fc26f8h9xzj";
        }
        {
          name = "remote-wsl";
          publisher = "ms-vscode-remote";
          version = "0.58.2";
          sha256 = "0fa1j592z7p7zv4acwpy4fn5fdjb6lz2sajcl78rzdva35qynw3i";
        }
        {
          name = "vscode-typescript-tslint-plugin";
          publisher = "ms-vscode";
          version = "1.3.3";
          sha256 = "1xjspcmx5p9x8yq1hzjdkq3acq52nilpd9bm069nsvrzzdh0n891";
        }
        {
          name = "vscode-react-native";
          publisher = "msjsdiag";
          version = "1.6.0";
          sha256 = "1y7ingbsb6vz5jf1c697nw749lywprsz6ac6vvlj5q8qjki4vafh";
        }
        {
          name = "vscode-css-peek";
          publisher = "pranaygp";
          version = "4.2.0";
          sha256 = "0dpkp3xs8jd826h2aa9xlfilsj4yv8q6r9cs350ljrpcyj7wrlpq";
        }
        {
          name = "vscode-yaml";
          publisher = "redhat";
          version = "0.22.0";
          sha256 = "1ffsah3pwxfa8ya2c0a3q1wh5ngh621zgidfwl8iggnrl7nbwl3k";
        }
        {
          name = "vscode-sort-json";
          publisher = "richie5um2";
          version = "1.20.0";
          sha256 = "1zcbdzsv6vv3zwx5ddbarqizs8s9s57dnf328waq8jgqyzjg31i6";
        }
        {
          name = "LiveServer";
          publisher = "ritwickdey";
          version = "5.6.1";
          sha256 = "077arf3hsn1yb8xdhlrax5gf93ljww78irv4gm8ffmsqvcr1kws0";
        }
        {
          name = "gitblame";
          publisher = "waderyan";
          version = "8.1.0";
          sha256 = "06spyn8rpi28gf9h27zy19p41msl04nbs4ppgwdzshd6nvkjny2x";
        }
        {
          name = "quokka-vscode";
          publisher = "WallabyJs";
          version = "1.0.390";
          sha256 = "03w4p70b7wn6rlsmjr7jn5yasnbczgr22x92lgmi4v38aznayaym";
        }
        {
          name = "vscode-todo-highlight";
          publisher = "wayou";
          version = "1.0.4";
          sha256 = "0s925rb668spv602x6g7sld2cs5ayiq7273963v9prvgsr0drlrr";
        }
        {
          name = "change-case";
          publisher = "wmaurer";
          version = "1.0.0";
          sha256 = "0dxsdahyivx1ghxs6l9b93filfm8vl5q2sa4g21fiklgdnaf7pxl";
        }
      ];
      userSettings = {
        /* Settings */
        "workbench.settings.editor" = "json";
        "workbench.activityBar.visible" = true;
        "explorer.confirmDragAndDrop" = false;
        "files.eol" = "\n";
        /* Terminal */
        "terminal.integrated.defaultProfile.windows" = "C:\\Program Files\\Git\\bin\\bash.exe";
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono'; 'Fira Code'; Consolas; 'Courier New'; monospace";
        /* Font */
        "editor.fontFamily" = "'Fira Code'; Consolas; 'Courier New'; monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        /* Editor stuff */
        "editor.detectIndentation" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "files.insertFinalNewline" = true;
        "editor.renderWhitespace" = "all";
        "files.trimTrailingWhitespace" = true;
        # "editor.rulers" = [79, 100]; # TODO: need to find the correct syntax for "," in Nix
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
        "editor.formatOnType" = true;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "modifications";
        "editor.suggestSelection" = "first";
        /* Python */
        "python.defaultInterpreterPath" = "C:\\Python27\\python.exe";
        "python.pythonPath" = "C:\\Python27\\python.exe";
        "python.languageServer" = "Pylance";
        "python.formatting.provider" = "autopep8";
        /* Python Linting */
        "python.linting.enabled" = true;
        "python.linting.pycodestyleEnabled" = true;
        "python.linting.pycodestyleCategorySeverity.E" = "Warning";
        "python.linting.pydocstyleEnabled" = true;
        /* Other */
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
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "git.ignoreMissingGitWarning" = true;
        "explorer.confirmDelete" = false;
        "workbench.colorTheme" = "Dracula";
        "remote.SSH.remotePlatform" = {
          "ws-str-dl046" = "windows";
        };
        "remote.SSH.showLoginTerminal" = true;
        "remote.SSH.suppressWindowsSshWarning" = false;
        "security.workspace.trust.enabled" = false;
        "liveServer.settings.donotShowInfoMsg" = true;
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
        ];
    };
  };
}
