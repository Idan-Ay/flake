function toggle_tiny-dfr
    if systemctl is-active "tiny-dfr"
         systemctl stop "tiny-dfr"
    else
         systemctl start "tiny-dfr"
    end
end
