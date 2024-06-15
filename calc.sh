#!/bin/bash

# Process CLI parameters
for var in "$@"
do
    case $var in
        -h|--help) usage ;;
        -d=*|--dmenu=*)
            menu=$(echo $var | cut -d'=' -f 2);
            ;;
        --) break ;;
    esac
done

# Grab the answer
if [ -n "$1" ]; then
    answer=$(echo "$1" | qalc +u8 -color=never -terse | awk '!/^>/ && !/^$/ {gsub(/^[ \t]+|[ \t]+$/, "", $0); print}')
fi

# Path to menu application
if [ -z "${menu+1}" ]; then
    if [[ -n $(command -v rofi) ]]; then
        menu="$(command -v rofi)"
    elif [[ -n $(command -v dmenu) ]]; then
        menu=$(command -v dmenu)
    else
        >&2 echo "Rofi or dmenu not found"
        exit
    fi
fi

# If using rofi, add the necessary parameters
if [[ $menu == "rofi" || $menu == $(command -v rofi) ]]; then
    menu="$menu -dmenu -lines 3"
elif [[ $menu == "dmenu" || $menu == $(command -v dmenu) ]]; then
    menu="$menu ""$DMENU_OPTIONS"
fi

# Determine args to pass to dmenu/rofi
while [[ $# -gt 0 && $1 != "--" ]]; do
    shift
done
[[ $1 == "--" ]] && shift

action=$(echo -e "Limpar\nFechar" | $menu "$@" -p "= $answer")

case $action in
    "Limpar") $0 ;;
    "Fechar") ;;
    "") ;;
    *) $0 "$answer $action" "--dmenu=$menu" "--" "$@" ;;
esac
