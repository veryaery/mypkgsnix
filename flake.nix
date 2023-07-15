{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { nixpkgs, flake-utils, ... } @ inputs:
    let
        outputs = flake-utils.lib.eachDefaultSystem (system:
            let
                std = nixpkgs.lib;
                
                inherit (builtins)
                    mapAttrs
                    readDir;

                inherit (std.trivial)
                    const;

                inherit (std.attrsets)
                    filterAttrs;

                pkgs = nixpkgs.legacyPackages.${system};
                packageDirs =
                    filterAttrs
                    (const (fileType: fileType == "directory"))
                    (readDir ./.);
                legacyPackages =
                    mapAttrs
                    (name: const (import (./. + "/${name}") (pkgs // legacyPackages)))
                    packageDirs;
            in { inherit legacyPackages; }
        );
    in outputs;
}
