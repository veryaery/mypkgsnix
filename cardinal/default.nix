pkgs:

let
    version = "22.12";
in
pkgs.stdenv.mkDerivation {
    inherit version;
    pname = "cardinal";

    src = pkgs.fetchFromGitHub {
        owner = "DISTRHO";
        repo = "cardinal";
        rev = version;
        sha256 = "sha256-ebKGsa6PIkUVUjaaXSkwl2CNGGEktSjg6x2rLT2AYag=";
        fetchSubmodules = true;
    };

    prePatch = ''
        patchShebangs dpf/utils/generate-ttl.sh
    '';

    makeFlags = [ "SYSDEPS=true" "PREFIX=$(out)" ];

    nativeBuildInputs = with pkgs; [ pkg-config cmake ];
    #                                           ^^^^^
    #  One of Cardinal's submodules depends on cmake.

    dontUseCmakeConfigure = true;

    buildInputs = with pkgs; [
        jansson
        libarchive
        libsamplerate
        speexdsp
        libGL
        mesa
        xorg.libX11
        xorg.libXcursor
        xorg.libXext
        xorg.xrandr
        python3
    ];
}
