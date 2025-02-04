let
  rust-overlay =
    import (builtins.fetchGit {
      url = "https://github.com/oxalica/rust-overlay.git";
      rev = "84c58400556c1c5fa796cbc3215ba5bbd3bd848f";
    });
  nixpkgs = import <nixpkgs> { overlays = [ rust-overlay ]; };
  rust-nightly = with nixpkgs; rust-bin.nightly."2021-12-03".minimal.override {
    extensions = [ "rust-src" ];
    targets = [ "wasm32-unknown-unknown" ];
  };
in
with nixpkgs; pkgs.mkShell {
  nativeBuildInputs = [
	rust-nightly
  ];

  shellHook =
  ''
    cd $PROJECT_ROOT
  '';

  RUST_SRC_PATH="${rust-nightly}/lib/rustlib/src/rust/src";
  PROJECT_ROOT = builtins.toString ./.;
}
