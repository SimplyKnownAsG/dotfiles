{
  description = "Home Manager configuration of G";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos2405 = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ion-cli = {
      url = "github:simplyknownasg/ion-cli";
    };
  };

  outputs = { nixpkgs, nixos2405, unstable, home-manager, nixgl, ion-cli, ... }:
    let
      lib = nixpkgs.lib;
    in
    {
      homeConfigurations =
        let
          genConfig = system:
            let
              isDarwin = lib.hasSuffix "darwin" system;
            in
            home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
                overlays = [
                  (_: _:
                    lib.optionalAttrs (builtins.hasAttr system ion-cli.packages && ion-cli.packages.${system} ? default) {
                      ion-cli = ion-cli.packages.${system}.default;
                    }
                  )
                ];
              };
              extraSpecialArgs = {
                nixgl = if isDarwin then null else nixgl;
                unstable = unstable;
                ion-cli = ion-cli;
                username = "g";
                homeDirectory = "/home/g";
              };
              modules = [
                ./personal
              ];
            };
        in {
          g = genConfig "x86_64-linux";
        };
    };
}
