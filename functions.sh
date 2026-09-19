show_gui() 
{
    local script_path="$ROOT_DIR/ui/$1.tcl"
    shift

    tclexecomp "$script_path" "$@"
}
export -f show_gui

find_client_dir()
{
    local target_file="$1"
    if [ -z "$target_file" ] || [ ! -f "$target_file" ] || [ "$(basename "$target_file")" != "gaf-client.exe" ]; then
        show_gui "message" "Исполняемый файл указан неверно.\nПроверьте параметры запуска."
        exit 1
    fi

    export CLIENT_DIR="$(cd "$(dirname "$target_file")" && pwd)"
    readonly CLIENT_DIR
}
export -f find_client_dir

load_env_config()
{
    local script_env="$ROOT_DIR/env.sh"
    local user_env="$CLIENT_DIR/user_env.sh"
    local user_default="$CLIENT_DIR/user_env.default"

    cp "$script_env" "$user_default"
    chmod -x "$user_default"

    source "$script_env"
    if [ -e "$user_env" ]; then
        source "$user_env"
    else
		cat <<- 'EOF' > "$user_env"
			# This is your custom configuration file.
			# You can override any environment variables here.
			# For examples, defaults, and available variables, check the 'user_env.default' file in this folder.
		EOF
    fi

    export PROTONPATH="$DATA_DIR/proton"
    export WINEPREFIX="$DATA_DIR/prefix"
    export XDG_CACHE_HOME="$DATA_DIR/cache"
}
export -f load_env_config

assert_single_instance()
{
    local lockfile="$DATA_DIR/gaf.lock"
    if [ -e "$lockfile" ]; then
        PID=$(cat "$lockfile" 2>/dev/null)
        if [ -n "$PID" ] && kill -0 "$PID" 2>/dev/null; then
            show_gui "message" "Приложение уже запущено! Повторный запуск невозможен."
            exit 1
        fi
    fi
    echo $$ > "$lockfile"
    trap 'rm -f "$lockfile"' EXIT INT TERM
}
export -f assert_single_instance