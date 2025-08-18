set -U fish_greeting

if status --is-login
  if test (tty) = "/dev/tty1"
    exec Hyprland
  end
end