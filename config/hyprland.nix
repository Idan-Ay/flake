{ config, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        settings = {

            input = {
                kb_layout = "us";
                follow_mouse = 1;
            };

            gestures = {
                workspace_swipe = true;
            };

            general = {
                gaps_in = 5;
                gaps_out = 15;
                border_size = 0;
                layout = "master";
            };

            decoration = {
                rounding = 10;
                blur = {
                enabled = true;
                size = 5;
                passes = 3;
                };
            };

            animations = {
                enabled = true;
                bezier = [
                "myBezier,0.05,0.9,0.1,1.0"
                ];
                animation = [
                "windows,1,7,myBezier"
                "fade,1,7,myBezier"
                "workspaces,1,7,myBezier"
                ];
            };

            bind = [
                "SUPER,RETURN,exec,kitty"
                "SUPER,N,exec,kitty -e nnn"
                "SUPER,B,exec,google-chrome"
                "SUPER,O,exec,obsidian"
                "SUPER,E,exec,blender"
                "SUPER,C,exec,code"
                "SUPER,G,exec,chatgpt"

                "PRINT,exec,grim -g \"$(slurp)\" - | swappy -f -"

                "SUPER,T,exec,google-chrome 'https://translate.google.com/details?sl=en&tl=de&op=translate'"
                "SUPER,Y,exec,google-chrome 'https://www.youtube.com'"
                "SUPER,M,exec,google-chrome 'https://mail.google.com'"
                "SUPER,R,exec,google-chrome 'https://www.desmos.com/calculator?lang=en'"
                "SUPER,D,exec,google-chrome 'https://discord.com/app'"

                "SUPER,Q,killactive,"
                "SUPER,F,fullscreen,"
                "SUPER,V,togglefloating,"

                "SUPER,1,workspace,1"
                "SUPER,2,workspace,2"
                "SUPER,3,workspace,3"
                "SUPER,4,workspace,4"
                "SUPERSHIFT,1,movetoworkspace,1"
                "SUPERSHIFT,2,movetoworkspace,2"
                "SUPERSHIFT,3,movetoworkspace,3"
                "SUPERSHIFT,4,movetoworkspace,4"
            ];
            
            bindm = [
                "SUPER,mouse:272,movewindow"     # left click drag
                "SUPER,mouse:273,resizewindow"   # right click drag
            ];
        };
    };
}