{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations =
      let
        mkSystem = host: nixpkgs.lib.nixosSystem {
          modules = [
            home-manager.nixosModule
            host
            ./configuration.nix
          ];
          specialArgs = inputs;
        };
      in
      {
        geppc = mkSystem ./hosts/geppc;
        geptop = mkSystem ./hosts/geptop;
        gepvm = mkSystem ./hosts/gepvm;
      };
  };
}
