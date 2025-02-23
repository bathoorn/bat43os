#{pkgs, ...}: {
#  programs.starship = {
#    enable = true;
#    package = pkgs.starship;
#    presets = ["gruvbox-rainbow"];
#  };
#}
{
  pkgs,
  lib,
  ...
}: {
  programs.starship = let
    getPreset = name: (with builtins; removeAttrs (fromTOML (readFile "${pkgs.starship}/share/starship/presets/${name}.toml")) ["\"$schema\""]);
  in {
    enable = true;
    settings =
      lib.recursiveUpdate
      (lib.mergeAttrsList [
        (getPreset "nerd-font-symbols")
        (getPreset "gruvbox-rainbow")
      ]) {
        username = {
          # Your settings here
          show_always = true;
        };
        time = {
          disabled = true;
          format = "[$time]($style)";
        };
      };
  };
}
