{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { nixpkgs, flake-utils, ... } @ inputs:
    let
        outputs = flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
                legacyPackages = {
                    fontfreeze-cli = import ./fontfreeze-cli (pkgs // legacyPackages);
                    labwc = import ./labwc (pkgs // legacyPackages);
                    pastel = import ./pastel (pkgs // legacyPackages);
                    fundle = import ./fundle (pkgs // legacyPackages);
                    fira-code-with-features = import ./fira-code-with-features (pkgs // legacyPackages);
                    zrythm = import ./zrythm (pkgs // legacyPackages);
                    cardinal = import ./cardinal (pkgs // legacyPackages);
                };
            in { inherit legacyPackages; }
        );
    in outputs;
}
