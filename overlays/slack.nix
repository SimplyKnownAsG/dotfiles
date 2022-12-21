final: prev:
{
  slack = final.stdenv.mkDerivation {
    inherit (prev.slack) name version meta;
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      runHook preInstall

      set -x
      # make the bin directory so that we own it, and can delete bin/slack
      mkdir -p $out/bin
      cp -r --no-preserve=all ${prev.slack}/* $out/

      rm $out/bin/slack

      echo "#! ${final.lib.getExe final.bash} -e" > $out/bin/slack
      echo "${prev.lib.getExe prev.slack} --enable-features=WebRTCPipeWireCapturer \"\$@\"" >> $out/bin/slack
      chmod +x $out/bin/slack

      # ls -l $out/
      # ls -l $out/share/
      ls -l $out/share/
      ls -l $out/share/applications/slack.desktop
      # chown -R $USER $out/share/applications
      chmod +w $out/share/applications/slack.desktop
      # ls -l $out/share/
      # ls -l $out/share/applications/slack.desktop
      rm -f $out/share/applications/slack.desktop

      sed 's/^Exec=.*slack\>/Exec=slack/g' \
         ${prev.slack}/share/applications/slack.desktop \
         > $out/share/applications/slack.desktop

      runHook postInstall
    '';
  };
}
