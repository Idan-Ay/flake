function randomWallpaper --description "Set a random wallpaper with swaybg"
    set -l dir "$HOME/.config/wallpapers"
    set -l imgs (command find -L "$dir" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    -print0 | string split0)
    
    if test (count $imgs) -eq 0
    echo "No images found in $dir"
    return 1
    end

    # pick one at random
    set -l n (count $imgs)
    set -l idx (random 1 1 $n)
    set -l img $imgs[$idx]

    # ensure only one swaybg instance
    pkill -x swaybg >/dev/null 2>&1

    # set wallpaper; modes: fill | fit | center | tile
    swaybg -m fill -i "$img" &
end