{ pkgs ? import <nixpkgs> {} }:
let

  pico-sdk-version = "1.5.1";

  pico-sdk = pkgs.pico-sdk.overrideAttrs (old: {
    version = pico-sdk-version;
    src = pkgs.fetchFromGitHub {
      fetchSubmodules = true;
      owner = "raspberrypi";
      repo = "pico-sdk";
      rev = pico-sdk-version;
      hash = "sha256-GY5jjJzaENL3ftuU5KpEZAmEZgyFRtLwGVg3W1e/4Ho=";
    };
  });

 in pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ cmake pico-sdk gcc-arm-embedded ];
}
