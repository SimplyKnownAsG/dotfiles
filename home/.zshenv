# this is rerun for non-interactive shells. My ~/.profile sets some environment variabels that I may
# not want to be re-written

if [ "${G_DOT_FILES}" != "loaded" ]
then
    export G_DOT_FILES="loaded"
    source ~/.config/shell/rc
fi
