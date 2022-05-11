-- http://projects.haskell.org/xmobar/

Config { 
    font = "xft:UbuntuMono Nerd Font:weight=bold:pixelsize=16:antialias=true:hinting=true",
    bgColor = "#292d3e",
    fgColor = "#f07178",
    position = Static { xpos = 4 , ypos = 4, width = 1358, height = 25 },
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    persistent = True,
    commands = [ 
        Run Date "  %d %b %Y %H:%M " "date" 600,
        Run Com "volume" [] "volume" 10,
        Run Com "battery" [] "battery" 600,
        Run Cpu ["-t", " (<total>%)","-H","50","--high","red"] 150,
        Run Memory ["-t", "  <used>M"] 150,
        Run Com "brightness" [] "brightness" 5,
        Run Com "bash" ["-c", "apt list --upgradable | sed '1d' | wc -l"] "updates" 3000,
        Run Com "/home/julian/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 10,
        Run UnsafeStdinReader
    ],
    alignSep = "}{",
    template = "\
        \<action=`rofi -show drun`><fc=#b303ff>   </fc></action>%UnsafeStdinReader% }{ \
        \<action=`alacritty -e sudo apt upgrade` button=1><fc=#e1acff> %updates% </fc></action>\
        \<action=`alacritty -e bpytop` button=1><fc=#FFB86C> %cpu% </fc></action>\
        \<action=`alacritty -e htop` button=1><fc=#FF5555> %memory% </fc></action>\
        \<fc=#FDFD96> %brightness%</fc>\
        \<fc=#c3e88d> %battery%</fc>\
        --\<action=`pavucontrol` button=1><fc=#82AAFF> %volume% </fc></action>\
        \<action=`gnome-calendar` button=1><fc=#8BE9FD> %date% </fc></action>\
        \%trayerpad%"
}
