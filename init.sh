export ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
readonly ROOT_DIR

export PATH="${ROOT_DIR}/bin:${PATH}"
readonly PATH

find "$ROOT_DIR" -type f -print0 | while IFS= read -r -d '' file; do
    filename=$(basename "$file")

    if [[ "$filename" == *.sh ]] || [[ "$filename" != *.* ]]; then
        [ ! -x "$file" ] && chmod +x "$file"
    fi
done

source "$ROOT_DIR/functions.sh"

find_client_dir "$1"
load_env_config

mkdir -p "$DATA_DIR"
if [ ! -e "$ROOT_DIR/data" ]; then
    ln -s "$DATA_DIR" "$ROOT_DIR/data"
fi

assert_single_instance

source "$ROOT_DIR/prepare.sh"
umu-run "$1"