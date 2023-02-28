final: prev:
{
  wezterm = final.stdenv.mkDerivation {
    inherit (prev.wezterm) name version meta;
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      runHook preInstall

      set -x
      # make the bin directory so that we own it, and can delete bin/wezterm
      mkdir -p $out/bin
      cp -r ${prev.wezterm}/* $out/
      rm $out/bin/wezterm
      echo "#! ${final.lib.getExe final.bash} -e" > $out/bin/wezterm
      echo "${final.lib.getExe final.nixgl.nixGLIntel} ${prev.lib.getExe prev.wezterm} \"\$@\"" >> $out/bin/wezterm
      chmod +x $out/bin/wezterm

      runHook postInstall
    '';
  };
}
