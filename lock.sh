LOCKFILE="$DATA_DIR/gaf-client-legacy.lock"
if [ -e "$LOCKFILE" ]; then
    PID=$(cat "$LOCKFILE" 2>/dev/null)
    if [ -n "$PID" ] && kill -0 "$PID" 2>/dev/null; then
        yad --title="Gaf Client: Legacy" \
            --text="Приложение уже запущено! Повторный запуск невозможен.\nЧтобы запускать несколько экземпляров одновременно,\nзадайте другой DATA_DIR в user_env.sh скрипте." \
            --button="ОК:0" \
            --width=350 \
            --height=120 \
            --fixed \
            --center \
            --justify=center
        exit 1
    fi
fi
echo $$ > "$LOCKFILE"