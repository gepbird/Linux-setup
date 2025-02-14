self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    cargo
    cargo-watch
    dotnet-sdk
    gcc
    gnumake
    nodejs
    php
    php83Packages.composer
    rustc
    sqlite
  ];

  hm-gep.home.sessionVariables = {
    DOTNET_ROOT = pkgs.dotnet-sdk;
  };
}
