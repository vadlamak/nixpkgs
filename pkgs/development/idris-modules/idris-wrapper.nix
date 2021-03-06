{ symlinkJoin, makeWrapper, stdenv }: idris: { path, lib }:

symlinkJoin {
  name = idris.name;
  src = idris.src;
  paths = [ idris ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/idris \
      --suffix PATH : ${ stdenv.lib.makeBinPath path } \
      --suffix LIBRARY_PATH : ${stdenv.lib.makeLibraryPath lib}

    mkdir -p $out/nix-support
    substituteAll ${./setup-hook.sh} $out/nix-support/setup-hook
      '';
  }

