if [ -z "$1" ] || [ ! -f "$1" ] || [ "$(basename "$1")" != "gaf-client.exe" ]; then
    yad --title="Gaf Client: Legacy" \
        --text="Исполняемый файл указан неверно. Проверьте параметры запуска." \
        --button="ОК:0" \
        --width=350 \
        --height=120 \
        --fixed \
        --center \
        --justify=center
    exit 1
fi