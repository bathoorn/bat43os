{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
    obs-studio
    orca-slicer
    vscode-fhs
    kicad
  ];
}
