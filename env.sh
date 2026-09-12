export DATA_DIR="$HOME/.local/share/gaf-client-legacy"

# ------------------------------------------------------------------------
# Internal paths changing may cause issues when running multiple instances
# We recommend changing only DATA_DIR path if you want to move data folders
export PROTONPATH="$DATA_DIR/proton"
export WINEPREFIX="$DATA_DIR/prefix"
export XDG_CACHE_HOME="$DATA_DIR/cache"
# ------------------------------------------------------------------------

export PROTON_LOG=0
export WINEDEBUG="-all"

export PROTON_NO_ESYNC=1
export PROTON_NO_FSYNC=1
export PROTON_NO_NTSYNC=1