myConfig:
{...}:
if myConfig ? useKitty && myConfig.useKitty then {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
        font_family = "Bitstream Wera";
        enable_audio_bell = "no";
        wheel_scroll_multiplier = "10.0";
        wheel_scroll_min_lines = "2";
        touch_scroll_multiplier = "10.0";
        kitty_mod = "ctrl+alt";
    };
    keybindings = {
        "kitty_mod+t" = "new_tab";
        "ctrl+shift+v" = "paste_from_clipboard";
        "ctrl+shift+c" = "copy_to_clipboard";
    };
  };
}
else {}
