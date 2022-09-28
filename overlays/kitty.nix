final: prev:
{
  kitty = final.stdenv.mkDerivation {
    inherit (prev.kitty) name version meta;
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      runHook preInstall

      set -x
      # make the bin directory so that we own it, and can delete bin/kitty
      mkdir -p $out/bin
      cp -r ${prev.kitty}/* $out/
      rm $out/bin/kitty
      echo "#! ${final.lib.getExe final.bash} -e" > $out/bin/kitty
      echo "${final.lib.getExe final.nixgl.nixGLIntel} ${prev.lib.getExe prev.kitty} \"\$@\"" >> $out/bin/kitty
      chmod +x $out/bin/kitty

      runHook postInstall
    '';
  };
}
