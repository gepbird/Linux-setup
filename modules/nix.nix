self:
{
  pkgs,
  nixpkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    nix-diff
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-update
    nixd
    nixpkgs-review
    nvd
  ];

  nix = {
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      trusted-users = [ "gep" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  hm-gep.home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
}
