{
  description = "Moni's configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
        modules = [
	  ./configuration.nix
	  inputs.home-manager.nixosModules.home-manager
 	];
	specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = { 
      moni = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./home.nix ];
      };
    };

    packages.x86_64-linux = {
      homeManager = home-manager.defaultPackage.x86_64-linux;
    };
  };
}
