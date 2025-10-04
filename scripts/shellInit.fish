function f --description 'Run command in foot and stay open'
    if test (count $argv) -eq 0
        # no args → just open foot with an interactive fish
        foot -e fish
    else
        # join all arguments into one string
        set cmd (string join ' ' $argv)
        # run the command, then drop into fish so the terminal stays open
        foot -e fish -C "$cmd; and exec fish"
    end
end

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

function blurredWallpapers --description "create Blurred Wallpapers"
    set -l dir "$HOME/.config/wallpapers"

    if not test -d $dir/blurred
        mkdir "$dir/blurred"
    end
    for file in $dir/*;
        if test -f $file
            set -l filename (basename $file)
            if not test -e $dir/blurred/$filename
                echo "$file"
                magick "$file" -filter Gaussian -blur 0x8 "$dir/blurred/$filename"
            end
        end
    end
end