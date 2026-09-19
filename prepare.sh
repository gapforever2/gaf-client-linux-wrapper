mkdir -p "$PROTONPATH"
mkdir -p "$WINEPREFIX"
mkdir -p "$XDG_CACHE_HOME"

PROTON_URL="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton10-32/GE-Proton10-32.tar.gz"

PROTON_FILE="${PROTON_URL##*/}" 
PROTON_TMP="$XDG_CACHE_HOME/$PROTON_FILE"
if [ ! -f "$PROTONPATH/proton" ] || [ ! -f "$PROTONPATH/toolmanifest.vdf" ]; then
    aria2c -c -x 4 -s 4 "$PROTON_URL" -o "${PROTON_TMP##*/}" -d "${PROTON_TMP%/*}"

    rm -rf "$PROTONPATH"
    mkdir -p "$PROTONPATH"

    tar -xf "$PROTON_TMP" -C "$PROTONPATH" --strip-components=1
fi

# Copying the winetricks cache
mkdir -p "$XDG_CACHE_HOME/winetricks/"
cp -r "$ROOT_DIR/winetricks"/* "$XDG_CACHE_HOME/winetricks/"

umu-run winetricks -q vcrun2022
umu-run winetricks -q xact
umu-run winetricks -q d3dx9
umu-run winetricks -q d3dcompiler_43
umu-run winetricks -q d3dcompiler_47
umu-run winetricks -q corefonts fontsmooth=rgb

# Client updating folder fix
TARGET_LINK="$WINEPREFIX/drive_c/users/steamuser/AppData/Local/Programs/GAP Client"
mkdir -p "$(dirname "$TARGET_LINK")"
rm -rf "$TARGET_LINK"
ln -s "$CLIENT_DIR" "$TARGET_LINK"