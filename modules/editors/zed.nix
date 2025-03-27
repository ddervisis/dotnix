{
  pkgs,
  lib,
  vars,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "basher"
      "catppuccin"
      "csv"
      "dart"
      "docker-compose"
      "dockerfile"
      "gdscript"
      "git-firefly"
      "graphql"
      "html"
      "ini"
      "less"
      "log"
      "lua"
      "make"
      "nix"
      "nginx"
      "scss"
      "snippets"
      "sql"
      "swift"
      "terraform"
      "toml"
      "xml"
      "zig"
    ];
    extraPackages = with pkgs; [
      alejandra
      dart
      go
      gopls
      nil
      nixd
      zig
      zls
    ];
    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          alt-up = "editor::MoveLineUp";
          alt-down = "editor::MoveLineDown";
          alt-shift-up = "editor::DuplicateLineUp";
          alt-shift-down = "editor::DuplicateLineDown";
        };
      }
    ];
    # NOTE: This includes the complete default settings of Zed.
    userSettings = {
      # The name of the Zed theme to use for the UI.
      #
      # `mode` is one of:
      # - "system": Use the theme that corresponds to the system's appearance
      # - "light": Use the theme indicated by the "light" field
      # - "dark": Use the theme indicated by the "dark" field
      theme = {
        mode = "system";
        light = "Catppuccin Macchiato";
        dark = "Catppuccin Macchiato";
      };
      # The name of a base set of key bindings to use.
      # This setting can take four values, each named after another
      # text editor:
      #
      # 1. "VSCode"
      # 2. "Atom"
      # 3. "JetBrains"
      # 4. "None"
      # 5. "SublimeText"
      # 6. "TextMate"
      base_keymap = "VSCode";
      # Features that can be globally enabled or disabled
      features = {
        # Which inline completion provider to use.
        inline_completion_provider = "supermaven";
        edit_prediction_provider = "zed";
      };
      edit_predictions = {
        mode = "auto";
      };
      # The name of a font to use for rendering text in the editor
      buffer_font_family = "Zed Plex Mono";
      # Set the buffer text's font fallbacks, this will be merged with
      # the platform's default fallbacks.
      buffer_font_fallbacks = null;
      # The OpenType features to enable for text in the editor.
      buffer_font_features = {
        # Font ligatures
        calt = true;
      };
      # The default font size for text in the editor
      buffer_font_size = 15;
      # The weight of the editor font in standard CSS units from 100 to 900.
      buffer_font_weight = 400;
      # Set the buffer's line height.
      # May take 3 values:
      #  1. Use a line height that's comfortable for reading (1.618)
      #         "buffer_line_height": "comfortable"
      #  2. Use a standard line height, (1.3)
      #         "buffer_line_height": "standard",
      #  3. Use a custom line height
      #         "buffer_line_height": {
      #           "custom": 2
      #         },
      buffer_line_height = "comfortable";
      # The name of a font to use for rendering text in the UI
      # You can set this to ".SystemUIFont" to use the system font
      ui_font_family = "Zed Plex Sans";
      # Set the UI's font fallbacks, this will be merged with the platform's
      # default font fallbacks.
      ui_font_fallbacks = null;
      # The OpenType features to enable for text in the UI
      ui_font_features = {
        # Font ligatures
        calt = true;
      };
      # The weight of the UI font in standard CSS units from 100 to 900.
      ui_font_weight = 400;
      # The default font size for text in the UI
      ui_font_size = 16;
      # How much to fade out unused code.
      unnecessary_code_fade = 0.3;
      # Active pane styling settings.
      active_pane_modifiers = {
        # The factor to grow the active pane by. Defaults to 1.0
        # which gives the same size as all other panes.
        magnification = 1.0;
        # Inset border size of the active pane, in pixels.
        border_size = 0.0;
        # Opacity of the inactive panes. 0 means transparent, 1 means opaque.
        # Values are clamped to the [0.0, 1.0] range.
        inactive_opacity = 1.0;
      };
      # The direction that you want to split panes horizontally. Defaults to "up"
      pane_split_direction_horizontal = "up";
      # The direction that you want to split panes horizontally. Defaults to "left"
      pane_split_direction_vertical = "left";
      # Centered layout related settings.
      centered_layout = {
        # The relative width of the left padding of the central pane from the
        # workspace when the centered layout is used.
        left_padding = 0.2;
        # The relative width of the right padding of the central pane from the
        # workspace when the centered layout is used.
        right_padding = 0.2;
      };
      # The key to use for adding multiple cursors
      # Currently "alt" or "cmd_or_ctrl"  (also aliased as
      # "cmd" and "ctrl") are supported.
      multi_cursor_modifier = "alt";
      # Whether to enable vim modes and key bindings.
      vim_mode = false;
      # Whether to show the informational hover box when moving the mouse
      # over symbols in the editor.
      hover_popover_enabled = true;
      # Whether to confirm before quitting Zed.
      confirm_quit = false;
      # Whether to restore last closed project when fresh Zed instance is opened.
      restore_on_startup = "last_session";
      # Size of the drop target in the editor.
      drop_target_size = 0.2;
      # Whether the window should be closed when using 'close active item' on a window with no tabs.
      # May take 3 values:
      #  1. Use the current platform's convention
      #         "when_closing_with_no_tabs": "platform_default"
      #  2. Always close the window:
      #         "when_closing_with_no_tabs": "close_window",
      #  3. Never close the window
      #         "when_closing_with_no_tabs": "keep_window_open",
      when_closing_with_no_tabs = "platform_default";
      # Whether to use the system provided dialogs for Open and Save As.
      # When set to false, Zed will use the built-in keyboard-first pickers.
      use_system_path_prompts = true;
      # Whether the cursor blinks in the editor.
      cursor_blink = true;
      # Cursor shape for the default editor.
      #  1. A vertical bar
      #     "bar"
      #  2. A block that surrounds the following character
      #     "block"
      #  3. An underline / underscore that runs along the following character
      #     "underline"
      #  4. A box drawn around the following character
      #     "hollow"
      #
      # Default: not set, defaults to "bar"
      cursor_shape = null;
      # How to highlight the current line in the editor.
      #
      # 1. Don't highlight the current line:
      #    "none"
      # 2. Highlight the gutter area:
      #    "gutter"
      # 3. Highlight the editor area:
      #    "line"
      # 4. Highlight the full line (default):
      #    "all"
      current_line_highlight = "all";
      # Whether to pop the completions menu while typing in an editor without
      # explicitly requesting it.
      show_completions_on_input = true;
      # Whether to display inline and alongside documentation for items in the
      # completions menu
      show_completion_documentation = true;
      # The debounce delay before re-querying the language server for completion
      # documentation when not included in original completion list.
      completion_documentation_secondary_query_debounce = 300;
      # Show method signatures in the editor, when inside parentheses.
      auto_signature_help = false;
      # Whether to show the signature help after completion or a bracket pair inserted.
      # If `auto_signature_help` is enabled, this setting will be treated as enabled also.
      show_signature_help_after_edits = false;
      # Whether to show wrap guides (vertical rulers) in the editor.
      # Setting this to true will show a guide at the 'preferred_line_length' value
      # if 'soft_wrap' is set to 'preferred_line_length', and will show any
      # additional guides as specified by the 'wrap_guides' setting.
      show_wrap_guides = true;
      # Character counts at which to show wrap guides in the editor.
      wrap_guides = [80 100 120];
      # Hide the values of in variables from visual display in private files
      redact_private_values = true;
      # The default number of lines to expand excerpts in the multibuffer by.
      expand_excerpt_lines = 3;
      # Globs to match against file paths to determine if a file is private.
      private_files = ["**/.env*" "**/*.pem" "**/*.key" "**/*.cert" "**/*.crt" "**/secrets.yml"];
      # Whether to use additional LSP queries to format (and amend) the code after
      # every "trigger" symbol input, defined by LSP server capabilities.
      use_on_type_format = true;
      # Whether to automatically add matching closing characters when typing
      # opening parenthesis, bracket, brace, single or double quote characters.
      # For example, when you type (, Zed will add a closing ) at the correct position.
      use_autoclose = true;
      # Whether to automatically surround selected text when typing opening parenthesis,
      # bracket, brace, single or double quote characters.
      # For example, when you select text and type (, Zed will surround the text with ().
      use_autosurround = true;
      # Whether indentation of pasted content should be adjusted based on the context.
      auto_indent_on_paste = true;
      # Controls how the editor handles the autoclosed characters.
      # When set to `false`(default), skipping over and auto-removing of the closing characters
      # happen only for auto-inserted characters.
      # Otherwise(when `true`), the closing characters are always skipped over and auto-removed
      # no matter how they were inserted.
      always_treat_brackets_as_autoclosed = false;
      # Controls whether inline completions are shown immediately (true)
      # or manually by triggering `editor::ShowInlineCompletion` (false).
      show_inline_completions = true;
      # Controls whether inline completions are shown in a given language scope.
      # Example: ["string", "comment"]
      inline_completions_disabled_in = [];
      # Whether to show tabs and spaces in the editor.
      # This setting can take three values:
      #
      # 1. Draw tabs and spaces only for the selected text (default):
      #    "selection"
      # 2. Do not draw any tabs or spaces:
      #    "none"
      # 3. Draw all invisible symbols:
      #    "all"
      # 4. Draw whitespaces at boundaries only:
      #    "boundary"
      # For a whitespace to be on a boundary, any of the following conditions need to be met:
      # - It is a tab
      # - It is adjacent to an edge (start or end)
      # - It is adjacent to a whitespace (left or right)
      show_whitespaces = "all";
      # Settings related to calls in Zed
      calls = {
        # Join calls with the microphone live by default
        mute_on_join = true;
        # Share your project when you are the first to join a channel
        share_on_join = false;
      };
      # Toolbar related settings
      toolbar = {
        # Whether to show breadcrumbs.
        breadcrumbs = true;
        # Whether to show quick action buttons.
        quick_actions = true;
        # Whether to show the Selections menu in the editor toolbar
        selections_menu = true;
      };
      # Scrollbar related settings
      scrollbar = {
        # When to show the scrollbar in the editor.
        # This setting can take four values:
        #
        # 1. Show the scrollbar if there's important information or
        #    follow the system's configured behavior (default):
        #   "auto"
        # 2. Match the system's configured behavior:
        #    "system"
        # 3. Always show the scrollbar:
        #    "always"
        # 4. Never show the scrollbar:
        #    "never"
        show = "auto";
        # Whether to show cursor positions in the scrollbar.
        cursors = true;
        # Whether to show git diff indicators in the scrollbar.
        git_diff = true;
        # Whether to show buffer search results in the scrollbar.
        search_results = true;
        # Whether to show selected symbol occurrences in the scrollbar.
        selected_symbol = true;
        # Whether to show diagnostic indicators in the scrollbar.
        diagnostics = "all";
      };
      # Enable middle-click paste on Linux.
      middle_click_paste = true;
      # What to do when multibuffer is double clicked in some of its excerpts
      # (parts of singleton buffers).
      # May take 2 values:
      #  1. Behave as a regular buffer and select the whole word (default).
      #         "double_click_in_multibuffer": "select"
      #  2. Open the excerpt clicked as a new buffer in the new tab.
      #         "double_click_in_multibuffer": "open",
      # For the case of "open", regular selection behavior can be achieved by holding `alt` when double clicking.
      double_click_in_multibuffer = "select";
      gutter = {
        # Whether to show line numbers in the gutter.
        line_numbers = true;
        # Whether to show code action buttons in the gutter.
        code_actions = true;
        # Whether to show runnables buttons in the gutter.
        runnables = true;
        # Whether to show fold buttons in the gutter.
        folds = true;
      };
      indent_guides = {
        # Whether to show indent guides in the editor.
        enabled = true;
        # The width of the indent guides in pixels, between 1 and 10.
        line_width = 1;
        # The width of the active indent guide in pixels, between 1 and 10.
        active_line_width = 1;
        # Determines how indent guides are colored.
        # This setting can take the following three values:
        #
        # 1. "disabled"
        # 2. "fixed"
        # 3. "indent_aware"
        coloring = "indent_aware";
        # Determines how indent guide backgrounds are colored.
        # This setting can take the following two values:
        #
        # 1. "disabled"
        # 2. "indent_aware"
        background_coloring = "disabled";
      };
      # Whether the editor will scroll beyond the last line.
      scroll_beyond_last_line = "one_page";
      # The number of lines to keep above/below the cursor when scrolling.
      vertical_scroll_margin = 3;
      # Scroll sensitivity multiplier. This multiplier is applied
      # to both the horizontal and vertical delta values while scrolling.
      scroll_sensitivity = 1.0;
      relative_line_numbers = false;
      # If 'search_wrap' is disabled, search result do not wrap around the end of the file.
      search_wrap = true;
      # Search options to enable by default when opening new project and buffer searches.
      search = {
        whole_word = false;
        case_sensitive = false;
        include_ignored = false;
        regex = false;
      };
      # When to populate a new search's query based on the text under the cursor.
      # This setting can take the following three values:
      #
      # 1. Always populate the search query with the word under the cursor (default).
      #    "always"
      # 2. Only populate the search query when there is text selected
      #    "selection"
      # 3. Never populate the search query
      #    "never"
      seed_search_query_from_cursor = "always";
      use_smartcase_search = false;
      # Inlay hint related settings
      inlay_hints = {
        # Global switch to toggle hints on and off, switched off by default.
        enabled = true;
        # Toggle certain types of hints on and off, all switched on by default.
        show_type_hints = true;
        show_parameter_hints = true;
        # Corresponds to null/None LSP hint type value.
        show_other_hints = true;
        # Whether to show a background for inlay hints.
        #
        # If set to `true`, the background will use the `hint.background` color from the current theme.
        show_background = false;
        # Time to wait after editing the buffer, before requesting the hints,
        # set to 0 to disable debouncing.
        edit_debounce_ms = 700;
        # Time to wait after scrolling the buffer, before requesting the hints,
        # set to 0 to disable debouncing.
        scroll_debounce_ms = 50;
      };
      project_panel = {
        # Whether to show the project panel button in the status bar
        button = true;
        # Default width of the project panel.
        default_width = 240;
        # Where to dock the project panel. Can be 'left' or 'right'.
        dock = "left";
        # Whether to show file icons in the project panel.
        file_icons = true;
        # Whether to show folder icons or chevrons for directories in the project panel.
        folder_icons = true;
        # Whether to show the git status in the project panel.
        git_status = true;
        # Amount of indentation for nested items.
        indent_size = 20;
        # Whether to reveal it in the project panel automatically,
        # when a corresponding project entry becomes active.
        # Gitignored entries are never auto revealed.
        auto_reveal_entries = true;
        # Whether to fold directories automatically and show compact folders
        # (e.g. "a/b/c" ) when a directory has only one subdirectory inside.
        auto_fold_dirs = true;
        # Scrollbar related settings
        scrollbar = {
          # When to show the scrollbar in the project panel.
          # This setting can take four values:
          #
          # 1. null (default): Inherit editor settings
          # 2. Show the scrollbar if there's important information or
          #    follow the system's configured behavior (default):
          #   "auto"
          # 3. Match the system's configured behavior:
          #    "system"
          # 4. Always show the scrollbar:
          #    "always"
          # 5. Never show the scrollbar:
          #    "never"
          show = null;
        };
        # Which files containing diagnostic errors/warnings to mark in the project panel.
        # This setting can take the following three values:
        #
        # 1. Do not mark any files:
        #    "off"
        # 2. Only mark files with errors:
        #    "errors"
        # 3. Mark files with errors and warnings:
        #    "all"
        show_diagnostics = "all";
        # Settings related to indent guides in the project panel.
        indent_guides = {
          # When to show indent guides in the project panel.
          # This setting can take two values:
          #
          # 1. Always show indent guides:
          #    "always"
          # 2. Never show indent guides:
          #    "never"
          show = "always";
        };
      };
      outline_panel = {
        # Whether to show the outline panel button in the status bar
        button = true;
        # Default width of the outline panel.
        default_width = 300;
        # Where to dock the outline panel. Can be 'left' or 'right'.
        dock = "left";
        # Whether to show file icons in the outline panel.
        file_icons = true;
        # Whether to show folder icons or chevrons for directories in the outline panel.
        folder_icons = true;
        # Whether to show the git status in the outline panel.
        git_status = true;
        # Amount of indentation for nested items.
        indent_size = 20;
        # Whether to reveal it in the outline panel automatically,
        # when a corresponding outline entry becomes active.
        # Gitignored entries are never auto revealed.
        auto_reveal_entries = true;
        # Whether to fold directories automatically
        # when a directory has only one directory inside.
        auto_fold_dirs = true;
        # Settings related to indent guides in the outline panel.
        indent_guides = {
          # When to show indent guides in the outline panel.
          # This setting can take two values:
          #
          # 1. Always show indent guides:
          #    "always"
          # 2. Never show indent guides:
          #    "never"
          show = "always";
        };
        # Scrollbar related settings
        scrollbar = {
          # When to show the scrollbar in the project panel.
          # This setting can take four values:
          #
          # 1. null (default): Inherit editor settings
          # 2. Show the scrollbar if there's important information or
          #    follow the system's configured behavior (default):
          #   "auto"
          # 3. Match the system's configured behavior:
          #    "system"
          # 4. Always show the scrollbar:
          #    "always"
          # 5. Never show the scrollbar:
          #    "never"
          show = null;
        };
      };
      collaboration_panel = {
        # Whether to show the collaboration panel button in the status bar.
        button = false;
        # Where to dock the collaboration panel. Can be 'left' or 'right'.
        dock = "left";
        # Default width of the collaboration panel.
        default_width = 240;
      };
      chat_panel = {
        # Whether to show the chat panel button in the status bar.
        button = "never";
        # Where to the chat panel. Can be 'left' or 'right'.
        dock = "right";
        # Default width of the chat panel.
        default_width = 240;
      };
      message_editor = {
        # Whether to automatically replace emoji shortcodes with emoji characters.
        # For example: typing `:wave:` gets replaced with `👋`.
        auto_replace_emoji_shortcode = true;
      };
      notification_panel = {
        # Whether to show the notification panel button in the status bar.
        button = true;
        # Where to dock the notification panel. Can be 'left' or 'right'.
        dock = "right";
        # Default width of the notification panel.
        default_width = 380;
      };
      assistant = {
        # Version of this setting.
        version = "2";
        # Whether the assistant is enabled
        enabled = true;
        # Whether to show the assistant panel button in the status bar.
        button = true;
        # Where to dock the assistant panel. Can be 'left', 'right' or 'bottom'.
        dock = "right";
        # Default width when the assistant is docked to the left or right.
        default_width = 640;
        # Default height when the assistant is docked to the bottom.
        default_height = 320;
        # The default model to use when creating new chats
        default_model = {
          # The provider to use.
          provider = "openai";
          # The model to use.
          model = "gpt-4o";
        };
      };
      # The settings for slash commands.
      slash_commands = {
        # Settings for the `/docs` slash command.
        docs = {
          # Whether `/docs` is enabled.
          enabled = false;
        };
        # Settings for the `/project` slash command.
        project = {
          # Whether `/project` is enabled.
          enabled = false;
        };
      };
      # Whether the screen sharing icon is shown in the os status bar.
      show_call_status_icon = true;
      # Whether to use language servers to provide code intelligence.
      enable_language_server = true;
      # Whether to perform linked edits of associated ranges, if the language server supports it.
      # For example, when editing opening <html> tag, the contents of the closing </html> tag will be edited as well.
      linked_edits = true;
      # The list of language servers to use (or disable) for all languages.
      #
      # This is typically customized on a per-language basis.
      language_servers = ["..."];
      # When to automatically save edited buffers. This setting can
      # take four values.
      #
      # 1. Never automatically save:
      #     "autosave": "off",
      # 2. Save when changing focus away from the Zed window:
      #     "autosave": "on_window_change",
      # 3. Save when changing focus away from a specific buffer:
      #     "autosave": "on_focus_change",
      # 4. Save when idle for a certain amount of time:
      #     "autosave": { "after_delay": {"milliseconds": 500} },
      autosave = "off";
      # Settings related to the editor's tab bar.
      tab_bar = {
        # Whether or not to show the tab bar in the editor
        show = true;
        # Whether or not to show the navigation history buttons.
        show_nav_history_buttons = true;
      };
      # Settings related to the editor's tabs
      tabs = {
        # Show git status colors in the editor tabs.
        git_status = true;
        # Position of the close button on the editor tabs.
        close_position = "right";
        # Whether to show the file icon for a tab.
        file_icons = true;
        # What to do after closing the current tab.
        #
        # 1. Activate the tab that was open previously (default)
        #     "History"
        # 2. Activate the neighbour tab (prefers the right one, if present)
        #     "Neighbour"
        activate_on_close = "history";
      };
      # Settings related to preview tabs.
      preview_tabs = {
        # Whether preview tabs should be enabled.
        # Preview tabs allow you to open files in preview mode, where they close automatically
        # when you switch to another file unless you explicitly pin them.
        # This is useful for quickly viewing files without cluttering your workspace.
        enabled = true;
        # Whether to open tabs in preview mode when selected from the file finder.
        enable_preview_from_file_finder = true;
        # Whether a preview tab gets replaced when code navigation is used to navigate away from the tab.
        enable_preview_from_code_navigation = true;
      };
      # Settings related to the file finder.
      file_finder = {
        # Whether to show file icons in the file finder.
        file_icons = true;
        # Determines how much space the file finder can take up in relation to the available window width.
        # There are 5 possible width values:
        #
        # 1. Small: This value is essentially a fixed width.
        #    "modal_width": "small"
        # 2. Medium:
        #    "modal_width": "medium"
        # 3. Large:
        #    "modal_width": "large"
        # 4. Extra Large:
        #    "modal_width": "xlarge"
        # 5. Fullscreen: This value removes any horizontal padding, as it consumes the whole viewport width.
        #    "modal_width": "full"
        #
        # Default: small
        modal_max_width = "small";
      };
      # Whether or not to remove any trailing whitespace from lines of a buffer
      # before saving it.
      remove_trailing_whitespace_on_save = true;
      # Whether to start a new line with a comment when a previous line is a comment as well.
      extend_comment_on_newline = true;
      # Whether or not to ensure there's a single newline at the end of a buffer
      # when saving it.
      ensure_final_newline_on_save = true;
      # Whether or not to perform a buffer format before saving
      #
      # Keep in mind, if the autosave with delay is enabled, format_on_save will be ignored
      format_on_save = "on";
      # How to perform a buffer format. This setting can take 4 values:
      #
      # 1. Format code using the current language server:
      #     "formatter": "language_server"
      # 2. Format code using an external command:
      #     "formatter": {
      #       "external": {
      #         "command": "prettier",
      #         "arguments": ["--stdin-filepath", "{buffer_path}"]
      #       }
      #     }
      # 3. Format code using Zed's Prettier integration:
      #     "formatter": "prettier"
      # 4. Default. Format files using Zed's Prettier integration (if applicable),
      #    or falling back to formatting via language server:
      #     "formatter": "auto"
      formatter = "language_server";
      # How to soft-wrap long lines of text.
      # Possible values:
      #
      # 1. Prefer a single line generally, unless an overly long line is encountered.
      #      "soft_wrap": "none",
      #      "soft_wrap": "prefer_line", (deprecated, same as "none")
      # 2. Soft wrap lines that overflow the editor.
      #      "soft_wrap": "editor_width",
      # 3. Soft wrap lines at the preferred line length.
      #      "soft_wrap": "preferred_line_length",
      # 4. Soft wrap lines at the preferred line length or the editor width (whichever is smaller).
      #      "soft_wrap": "bounded",
      soft_wrap = "editor_width";
      # The column at which to soft-wrap lines, for buffers where soft-wrap
      # is enabled.
      preferred_line_length = 80;
      # Whether to indent lines using tab characters, as opposed to multiple
      # spaces.
      hard_tabs = false;
      # How many columns a tab should occupy.
      tab_size = 4;
      # Control what info is collected by Zed.
      telemetry = {
        # Send debug info like crash reports.
        diagnostics = false;
        # Send anonymized usage data like what languages you're using Zed with.
        metrics = false;
      };
      # Automatically update Zed. This setting may be ignored on Linux if
      # installed through a package manager.
      auto_update = false;
      # Diagnostics configuration.
      diagnostics = {
        # Whether to show warnings or not by default.
        include_warnings = true;
      };
      # Add files or globs of files that will be excluded by Zed entirely:
      # they will be skipped during FS scan(s), file tree and file search
      # will lack the corresponding file entries. Overrides `file_scan_inclusions`.
      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
      ];
      # Add files or globs of files that will be included by Zed, even when
      # ignored by git. This is useful for files that are not tracked by git,
      # but are still important to your project. Note that globs that are
      # overly broad can slow down Zed's file scanning. Overridden by `file_scan_exclusions`.
      file_scan_inclusions = [".env*"];
      # Git gutter behavior configuration.
      git = {
        # Control whether the git gutter is shown. May take 2 values:
        # 1. Show the gutter
        #      "git_gutter": "tracked_files"
        # 2. Hide the gutter
        #      "git_gutter": "hide"
        git_gutter = "tracked_files";
        # Control whether the git blame information is shown inline,
        # in the currently focused line.
        inline_blame = {
          enabled = true;
          # Sets a delay after which the inline blame information is shown.
          # Delay is restarted with every cursor movement.
          delay_ms = 600;
          # Whether or not do display the git commit summary on the same line.
          show_commit_summary = true;
          # The minimum column number to show the inline blame information at
          min_column = 0;
        };
      };
      # Configuration for how direnv configuration should be loaded. May take 2 values:
      # 1. Load direnv configuration using `direnv export json` directly.
      #      "load_direnv": "direct"
      # 2. Load direnv configuration through the shell hook, works for POSIX shells and fish.
      #      "load_direnv": "shell_hook"
      load_direnv = "shell_hook";
      inline_completions = {
        # A list of globs representing files that inline completions should be disabled for.
        disabled_globs = [".env"];
      };
      # Settings specific to journaling
      journal = {
        # The path of the directory where journal entries are stored
        path = "~";
        # What format to display the hours in
        # May take 2 values:
        # 1. hour12
        # 2. hour24
        hour_format = "hour24";
      };
      # Settings specific to the terminal
      terminal = {
        # What shell to use when opening a terminal. May take 3 values:
        # 1. Use the system's default terminal configuration in /etc/passwd
        #      "shell": "system"
        # 2. A program:
        #      "shell": {
        #        "program": "sh"
        #      }
        # 3. A program with arguments:
        #     "shell": {
        #         "with_arguments": {
        #           "program": "/bin/bash",
        #           "args": ["--login"]
        #         }
        #     }
        shell = "system";
        # Where to dock terminals panel. Can be `left`, `right`, `bottom`.
        dock = "bottom";
        # Default width when the terminal is docked to the left or right.
        default_width = 640;
        # Default height when the terminal is docked to the bottom.
        default_height = 320;
        # What working directory to use when launching the terminal.
        # May take 4 values:
        # 1. Use the current file's project directory.  Will Fallback to the
        #    first project directory strategy if unsuccessful
        #      "working_directory": "current_project_directory"
        # 2. Use the first project in this workspace's directory
        #      "working_directory": "first_project_directory"
        # 3. Always use this platform's home directory (if we can find it)
        #     "working_directory": "always_home"
        # 4. Always use a specific directory. This value will be shell expanded.
        #    If this path is not a valid directory the terminal will default to
        #    this platform's home directory  (if we can find it)
        #      "working_directory": {
        #        "always": {
        #          "directory": "~/zed/projects/"
        #        }
        #      }
        working_directory = "current_project_directory";
        # Set the cursor blinking behavior in the terminal.
        # May take 3 values:
        #  1. Never blink the cursor, ignoring the terminal mode
        #         "blinking": "off",
        #  2. Default the cursor blink to off, but allow the terminal to
        #     set blinking
        #         "blinking": "terminal_controlled",
        #  3. Always blink the cursor, ignoring the terminal mode
        #         "blinking": "on",
        blinking = "off";
        # Default cursor shape for the terminal.
        #  1. A block that surrounds the following character
        #     "block"
        #  2. A vertical bar
        #     "bar"
        #  3. An underline / underscore that runs along the following character
        #     "underline"
        #  4. A box drawn around the following character
        #     "hollow"
        #
        # Default: not set, defaults to "block"
        cursor_shape = null;
        # Set whether Alternate Scroll mode (code: ?1007) is active by default.
        # Alternate Scroll mode converts mouse scroll events into up / down key
        # presses when in the alternate screen (e.g. when running applications
        # like vim or  less). The terminal can still set and unset this mode.
        # May take 2 values:
        #  1. Default alternate scroll mode to on
        #         "alternate_scroll": "on",
        #  2. Default alternate scroll mode to off
        #         "alternate_scroll": "off",
        alternate_scroll = "off";
        # Set whether the option key behaves as the meta key.
        # May take 2 values:
        #  1. Rely on default platform handling of option key, on macOS
        #     this means generating certain unicode characters
        #         "option_as_meta": false,
        #  2. Make the option keys behave as a 'meta' key, e.g. for emacs
        #         "option_as_meta": true,
        option_as_meta = false;
        # Whether or not selecting text in the terminal will automatically
        # copy to the system clipboard.
        copy_on_select = false;
        # Whether to show the terminal button in the status bar
        button = false;
        # Any key-value pairs added to this list will be added to the terminal's
        # environment. Use `:` to separate multiple values.
        env = {
          # "KEY": "value1:value2"
          TERM = vars.terminal;
        };
        # Set the terminal's line height.
        # May take 3 values:
        #  1. Use a line height that's comfortable for reading, 1.618
        #         "line_height": "comfortable"
        #  2. Use a standard line height, 1.3. This option is useful for TUIs,
        #      particularly if they use box characters
        #         "line_height": "standard",
        #  3. Use a custom line height.
        #         "line_height": {
        #           "custom": 2
        #         },
        line_height = "comfortable";
        # Activate the python virtual environment, if one is found, in the
        # terminal's working directory (as resolved by the working_directory
        # setting). Set this to "off" to disable this behavior.
        detect_venv = {
          on = {
            # Default directories to search for virtual environments, relative
            # to the current working directory. We recommend overriding this
            # in your project's settings, rather than globally.
            directories = [".env" "env" ".venv" "venv"];
            # Can also be `csh`, `fish`, `nushell` and `power_shell`
            activate_script = "default";
          };
        };
        toolbar = {
          # Whether to display the terminal title in its toolbar's breadcrumbs.
          # Only shown if the terminal title is not empty.
          #
          # The shell running in the terminal needs to be configured to emit the title.
          # Example: `echo -e "\e]2;New Title\007";`
          breadcrumbs = true;
        };
        # Set the terminal's font size. If this option is not included,
        # the terminal will default to matching the buffer's font size.
        # "font_size": 15,
        font_size = 12;
        # Set the terminal's font family. If this option is not included,
        # the terminal will default to matching the buffer's font family.
        # "font_family": "Zed Plex Mono",
        font_family = "FiraCode Nerd Font";
        # Set the terminal's font fallbacks. If this option is not included,
        # the terminal will default to matching the buffer's font fallbacks.
        # This will be merged with the platform's default font fallbacks
        # "font_fallbacks": ["FiraCode Nerd Fonts"],
        # Sets the maximum number of lines in the terminal's scrollback buffer.
        # Default: 10_000, maximum: 100_000 (all bigger values set will be treated as 100_000), 0 disables the scrolling.
        # Existing terminals will not pick up this change until they are recreated.
        # "max_scroll_history_lines": 10000,
        font_features = {
          calt = true;
        };
      };
      code_actions_on_format = {};
      # Settings related to running tasks.
      tasks = {
        variables = {};
      };
      # An object whose keys are language names, and whose values
      # are arrays of filenames or extensions of files that should
      # use those languages.
      #
      # For example, to treat files like `foo.notjs` as JavaScript,
      # and `Embargo.lock` as TOML:
      #
      # {
      #   "JavaScript": ["notjs"],
      #   "TOML": ["Embargo.lock"]
      # }
      #
      file_types = {
        "Plain Text" = ["txt"];
        "JSONC" = ["**/.zed/**/*.json" "**/zed/**/*.json" "**/Zed/**/*.json" "**/.vscode/**/*.json"];
        "Shell Script" = [".env.*"];
      };
      # By default use a recent system version of node, or install our own.
      # You can override this to use a version of node that is not in $PATH with:
      # {
      #   "node": {
      #     "path": "/path/to/node"
      #     "npm_path": "/path/to/npm" (defaults to node_path/../npm)
      #   }
      # }
      # or to ensure Zed always downloads and installs an isolated version of node:
      # {
      #   "node": {
      #     "ignore_system_version": true,
      #   }
      # NOTE: changing this setting currently requires restarting Zed.
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      # The extensions that Zed should automatically install on startup.
      #
      # If you don't want any of these extensions, add this field to your settings
      # and change the value to `false`.
      # NOTE: Extensions will be installed via the `zed-editor.extensions` list.
      # "auto_install_extensions": {
      #   "html": true
      # },
      # Different settings for specific languages.
      languages = {
        Astro = {
          language_servers = ["astro-language-server" "..."];
          prettier = {
            allowed = true;
            plugins = ["prettier-plugin-astro"];
          };
        };
        Blade = {
          prettier = {
            allowed = true;
          };
        };
        C = {
          format_on_save = "off";
          use_on_type_format = false;
        };
        "C++" = {
          format_on_save = "off";
          use_on_type_format = false;
        };
        CSS = {
          prettier = {
            allowed = true;
          };
        };
        Dart = {
          tab_size = 2;
        };
        Diff = {
          remove_trailing_whitespace_on_save = false;
          ensure_final_newline_on_save = false;
        };
        Elixir = {
          language_servers = ["elixir-ls" "!next-ls" "!lexical" "..."];
        };
        Erlang = {
          language_servers = ["erlang-ls" "!elp" "..."];
        };
        Go = {
          code_actions_on_format = {
            "source.organizeImports" = true;
          };
        };
        GraphQL = {
          prettier = {
            allowed = true;
          };
        };
        HEEX = {
          language_servers = ["elixir-ls" "!next-ls" "!lexical" "..."];
        };
        HTML = {
          prettier = {
            allowed = true;
          };
        };
        Java = {
          prettier = {
            allowed = true;
            plugins = ["prettier-plugin-java"];
          };
        };
        JavaScript = {
          language_servers = ["!typescript-language-server" "vtsls" "..."];
          prettier = {
            allowed = true;
          };
        };
        JSON = {
          prettier = {
            allowed = true;
          };
        };
        JSONC = {
          prettier = {
            allowed = true;
          };
        };
        Markdown = {
          format_on_save = "off";
          use_on_type_format = false;
          prettier = {
            allowed = true;
          };
        };
        PHP = {
          language_servers = ["phpactor" "!intelephense" "..."];
          prettier = {
            allowed = true;
            plugins = ["@prettier/plugin-php"];
            parser = "php";
          };
        };
        Ruby = {
          language_servers = ["solargraph" "!ruby-lsp" "!rubocop" "..."];
        };
        SCSS = {
          prettier = {
            allowed = true;
          };
        };
        SQL = {
          prettier = {
            allowed = true;
          };
        };
        Starlark = {
          language_servers = ["starpls" "!buck2-lsp" "..."];
        };
        Svelte = {
          language_servers = ["svelte-language-server" "..."];
          prettier = {
            allowed = true;
            plugins = ["prettier-plugin-svelte"];
          };
        };
        TSX = {
          language_servers = ["!typescript-language-server" "vtsls" "..."];
          prettier = {
            allowed = true;
          };
        };
        Twig = {
          prettier = {
            allowed = true;
          };
        };
        TypeScript = {
          language_servers = ["!typescript-language-server" "vtsls" "..."];
          prettier = {
            allowed = true;
          };
        };
        "Vue.js" = {
          language_servers = ["vue-language-server" "..."];
          prettier = {
            allowed = true;
          };
        };
        XML = {
          prettier = {
            allowed = true;
            plugins = ["@prettier/plugin-xml"];
          };
        };
        Nix = {
          language_servers = ["nil" "!nixd"];
          formatter = {
            external = {
              command = "alejandra";
            };
          };
        };
        pyright = {
          settings = {
            python.analysis = {
              diagnosticMode = "workspace";
              typeCheckingMode = "strict";
            };
          };
        };
        YAML = {
          tab_size = 2;
          prettier = {
            allowed = true;
          };
        };
        Zig = {
          format_on_save = "language_server";
          code_actions_on_format = {
            "source.fixAll" = true;
            "source.organizeImports" = true;
          };
        };
      };
      # Different settings for specific language models.
      language_models = {
        anthropic = {
          version = "1";
          api_url = "https://api.anthropic.com";
        };
        google = {
          api_url = "https://generativelanguage.googleapis.com";
        };
        ollama = {
          api_url = "http://localhost:11434";
        };
        openai = {
          version = "1";
          api_url = "https://api.openai.com/v1";
        };
      };
      # Zed's Prettier integration settings.
      # Allows to enable/disable formatting with Prettier
      # and configure default Prettier, used when no project-level Prettier installation is found.
      prettier = {
        # # Whether to consider prettier formatter or not when attempting to format a file.
        # "allowed": false,
        allowed = true;
        #
        # # Use regular Prettier json configuration.
        # # If Prettier is allowed, Zed will use this for its Prettier instance for any applicable file, if
        # # the project has no other Prettier installed.
        # "plugins": [],
        #
        # # Use regular Prettier json configuration.
        # # If Prettier is allowed, Zed will use this for its Prettier instance for any applicable file, if
        # # the project has no other Prettier installed.
        # "trailingComma": "es5",
        trailingComma = "es5";
        # "tabWidth": 4,
        # "semi": false,
        # "singleQuote": true
        singleQuote = false;
      };
      # LSP Specific settings.
      lsp = {
        # Specify the LSP name as a key here.
        # "rust-analyzer": {
        #     # These initialization options are merged into Zed's defaults
        #     "initialization_options": {
        #         "check": {
        #             "command": "clippy" # rust-analyzer.check.command (default: "check")
        #         }
        #     }
        # }
        dart = {
          binary = {
            path_lookup = true;
          };
        };
        nil = {
          initialization_options = {
            formatting = {
              command = ["alejandra"];
            };
          };
          settings = {
            diagnostics = {
              ignored = ["unused_binding"];
            };
          };
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };
        yaml-language-server = {
          settings = {
            yaml = {
              keyOrdering = false;
              editor.tabSize = 2;
              format = {
                enable = true;
                singleQuote = false;
                bracketSpacing = false;
                proseWrap = "always";
                # printWidth = 80;
              };
              schemas = {
                "Kubernetes" = "globPattern";
                "https://json.schemastore.org/kustomization" = "/kustomization.yaml";
                # "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/all.json" = ["/*" "!/kustomization.yaml" "!*.sops.yaml"];
              };
            };
          };
        };
        zls = {
          binary = {
            path = lib.getExe pkgs.zls;
          };
          initialization_options = {
            enable_build_on_save = true;
            zig_exe_path = lib.getExe pkgs.zig;
          };
        };
      };
      # Jupyter settings
      jupyter = {
        enabled = true;
        # Specify the language name as the key and the kernel name as the value.
        # "kernel_selections": {
        #    "python": "conda-base"
        #    "typescript": "deno"
        # }
      };
      # Vim settings
      vim = {
        # If `true`, line numbers are relative in normal mode and absolute
        # in insert mode, giving you the best of both options.
        toggle_relative_line_numbers = true;
        # Determines how system clipboard is used:
        #   "always": use for all operations
        #   "never": only use when explicitly specified
        #   "on_yank": use for yank operations
        use_system_clipboard = "always";
        # If `true`, `f` and `t` motions extend across multiple lines.
        use_multiline_find = false;
        # If `true`, `f` and `t` motions are case-insensitive when the target
        # letter is lowercase.
        use_smartcase_find = false;
        # An object that allows you to add custom digraphs.
        custom_digraphs = {
          fz = "🧟‍♀️";
        };
        # The duration of the highlight animation(in ms). Set to `0` to disable
        highlight_on_yank_duration = 200;
      };
      # The server to connect to. If the environment variable
      # ZED_SERVER_URL is set, it will override this setting.
      server_url = "https://zed.dev";
      # Task-related settings.
      task = {
        # Whether to show task status indicator in the status bar. Default: true
        show_status_indicator = true;
      };
      # Whether to show full labels in line indicator or short ones
      #
      # Values:
      #   - `short`: "2 s, 15 l, 32 c"
      #   - `long`: "2 selections, 15 lines, 32 characters"
      # Default: long
      line_indicator_format = "long";
      # Set a proxy to use. The proxy protocol is specified by the URI scheme.
      #
      # Supported URI scheme: `http`, `https`, `socks4`, `socks4a`, `socks5`,
      # `socks5h`. `http` will be used when no scheme is specified.
      #
      # By default no proxy will be used, or Zed will try get proxy settings from
      # environment variables.
      #
      # Examples:
      #   - "proxy": "socks5h://localhost:10808"
      #   - "proxy": "http://127.0.0.1:10809"
      proxy = null;
      # Set to configure aliases for the command palette.
      # When typing a query which is a key of this object, the value will be used instead.
      #
      # Examples:
      # {
      #   "W": "workspace::Save"
      # }
      command_aliases = {};
      # ssh_connections is an array of ssh connections.
      # You can configure these from `project: Open Remote` in the command palette.
      # Zed's ssh support will pull configuration from your ~/.ssh too.
      # Examples:
      # [
      #   {
      #     "host": "example-box",
      #     // "port": 22, "username": "test", "args": ["-i", "/home/user/.ssh/id_rsa"]
      #     "projects": [
      #       {
      #         "paths": ["/home/user/code/zed"]
      #       }
      #     ]
      #   }
      # ]
      ssh_connections = [];
      # Configures context servers for use in the Assistant.
      context_servers = {};
    };
  };
}
