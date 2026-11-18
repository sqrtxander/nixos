#!/usr/bin/bash
set -euo pipefail

s=$(date +%s)
colors=$(
    echo '{
        "background": "#16181a",
        "foreground": "#ffffff",
        "palette": [
            "#5ea1ff",
            "#5eff6c",
            "#5ef1ff",
            "#ff6e5e",
            "#f1ff5e",
            "#ff5ef1",
            "#ff5ea0",
            "#ffbd5e",
            "#bd5eff"
        ]
    }' | jq -c
)
output=$(niri msg --json focused-output)
monitor=$(echo "$output" | jq '.name' | tr -d '"')
width=$(echo "$output" | jq '.modes.[0].width')
height=$(echo "$output" | jq '.modes.[0].height')
scale=$(echo "$output" | jq '.logical.scale')
dims=$(
    jq -nc \
        --argjson width "$width" \
        --argjson height "$height" \
        --argjson scale "$scale" \
        '{"width": $width, "height": $height, "scale": $scale}'
)
cfg=$(
    jq -nc \
        --argjson dims "$dims" \
        --argjson colors "$colors" \
        '{"dimensions": $dims, "colors": $colors}'
)

paperdir="${HOME}/pictures/wallpapers/${monitor}"
paperpath="${paperdir}/${s}.png"
echo "$paperpath"
mkdir -p "$paperdir"
find "$paperdir" -type f -name "*.png" -mtime +1 -delete
wallpaper-generator -c "$cfg" -o "$paperpath"
echo "Wallpaper generated at $paperpath"
noctalia msg wallpaper-set "$monitor" "$paperpath"
