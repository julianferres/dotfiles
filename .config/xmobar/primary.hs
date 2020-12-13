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
        Run Com "brightness" [] "brightness" 10,
        --Run Com "bash" ["-c", "apt list --upgradable | sed '1d' | wc -l"] "updates" 3000,
        Run Com "/home/julian/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 10,
        Run UnsafeStdinReader
    ],
    alignSep = "}{",
    template = "\
        \<action=`dmenu_run -p 'dmenu' -h 25 -sb '#4A4F68' -nf '#c792ea' -nb '#192d3e' -sf '#c3e88d' -fn 'UbuntuMono Nerd Font:weight=bold:pixelsize=16' -y 4 -x 4 -z 1358`><fc=#b303ff>   </fc></action>%UnsafeStdinReader% }{ \
        --\<action=`alacritty -e sudo apt upgrade` button=1><fc=#e1acff> %updates% </fc></action>\
        \<action=`alacritty -e htop` button=1><fc=#FF5555> %memory% </fc></action>\
        \<fc=#FFB86C> %cpu% </fc>\
        \<action=`light -A 5` button=14><action=`light -U 5` button=35><fc=#FDFD96> %brightness%</fc></action></action>\
        \<fc=#c3e88d> %battery%</fc>\
        \<fc=#82AAFF> %volume% </fc>\
        \<fc=#8BE9FD> %date% </fc>\
        \%trayerpad%"
}
