export COMPDATA_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
export CLIENT_DIR="$(cd "$(dirname "$1")" && pwd)"
export PATH="${COMPDATA_DIR}/bin:${PATH}"

find "$COMPDATA_DIR" -type f -print0 | while IFS= read -r -d '' file; do
    filename=$(basename "$file")

    if [[ "$filename" == *.sh ]] || [[ "$filename" != *.* ]]; then
        [ ! -x "$file" ] && chmod +x "$file"
    fi
done

source "$COMPDATA_DIR/args.sh"

USER_ENV="$CLIENT_DIR/user_env.sh"
USER_DEFAULT="$CLIENT_DIR/user_env.default"

cp "$COMPDATA_DIR/env.sh" "$USER_DEFAULT"
chmod -x "$USER_DEFAULT"

source "$COMPDATA_DIR/env.sh"
if [ -e "$USER_ENV" ]; then
    chmod +x "$USER_ENV"
    source "$USER_ENV"
else
    cat << 'EOF' > "$USER_ENV"
# This is your custom configuration file.
# You can override any environment variables here.
# For examples, defaults, and available variables, check the 'user_env.default' file in this folder.
EOF
fi

source "$COMPDATA_DIR/lock.sh"

mkdir -p "$DATA_DIR"
if [ ! -e "$COMPDATA_DIR/data" ]; then
    ln -s "$DATA_DIR" "$COMPDATA_DIR/data"
fi

source "$COMPDATA_DIR/prepare.sh"
umu-run "$1"