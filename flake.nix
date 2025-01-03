{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      #url = "/home/gep/nixpkgs";
    };
    # TODO: remove after broken attr is removed from
    # https://github.com/nixos/nixpkgs/blob/master/pkgs/os-specific/linux/nvidia-x11/default.nix#L82 
    nixpkgs-nvidia = {
      url = "github:NixOS/nixpkgs/566e53c2ad750c84f6d31f9ccb9d00f823165550";
    };
    # TODO: remove after fixed: https://github.com/NixOS/nixpkgs/pull/366250#issuecomment-2557528916
    nixpkgs-anydesk = {
      url = "github:NixOS/nixpkgs/ccc4ef55e3a40f3bcd92396a8ba932a13071cfca";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwm-gep = {
      url = "github:gepbird/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
      inputs.darwin.follows = "";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
      inputs.flake-parts.follows = "flake-parts";
      inputs.hercules-ci-effects.follows = "hercules-ci-effects";
      inputs.git-hooks.follows = "git-hooks";
      inputs.treefmt-nix.follows = "";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # use newer main branch, see https://github.com/nvim-treesitter/nvim-treesitter-textobjects/pull/692
    nvim-treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects/main";
      flake = false;
    };
    # dependencies of the above modules
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
      inputs.gitignore.follows = "";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs: with inputs; {
      lib = import ./lib.nix { };
      nixosConfigurations =
        let
          mkSystem =
            host:
            nixpkgs.lib.nixosSystem {
              modules = [ host ];
              specialArgs = inputs;
            };
        in
        {
          geppc = mkSystem ./hosts/geppc;
          geptop = mkSystem ./hosts/geptop;
          gepvm = mkSystem ./hosts/gepvm;
        };
      nixosModules = import ./modules self;
    };
}
