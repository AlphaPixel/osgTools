{
  description = "A flake for building a sample cpp";

  inputs = {
    git-hooks.url = "github:cachix/git-hooks.nix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      git-hooks,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      # Run the hooks with `nix fmt`.
      formatter = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          config = self.checks.${system}.pre-commit-check.config;
          inherit (config) package configFile;
          script = ''
            ${pkgs.lib.getExe package} run --all-files --config ${configFile}
          '';
        in
        pkgs.writeShellScriptBin "pre-commit-run" script
      );

      # Run the hooks in a sandbox with `nix flake check`.
      # Read-only filesystem and no internet access.
      checks = forEachSystem (system: {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            clang-format = {
              enable = true;
              types_or = nixpkgs.lib.mkForce [
                "c"
                "c++"
              ];
            };
            #clang-tidy.enable = true;
            cmake-format.enable = true;
            flake-checker.enable = true;
            nixfmt.enable = true;
            trim-trailing-whitespace.enable = true;
          };
        };
      });

      # Enter a development shell with `nix develop`.
      # The hooks will be installed automatically.
      # Or run pre-commit manually with `nix develop -c pre-commit run --all-files`
      devShells = forEachSystem (system: {
        default =
          let
            pkgs = import nixpkgs {
              inherit system;
              config = {
                #allowUnfree = true;
              };
            };
            inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
          in
          pkgs.mkShell {
            inherit shellHook;

            nativeBuildInputs = with pkgs; [
              # Make sure this is first so clangd LSP works correctly
              clang-tools
              clang
              cmake
              cmake-format
              dlib
              gdb
              git
              git-lfs
              llvmPackages_18.libstdcxxClang
              ninja
              nix-index
              pkg-config
              pre-commit
            ];
            # Dependencies that only exist in the runtime environment
            buildInputs = with pkgs; [
              curl
              libGL
              libpng
              mesa-gl-headers
              openscenegraph
              zstd
            ];
          };
      });
    };
}
