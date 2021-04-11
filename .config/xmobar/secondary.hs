-- http://projects.haskell.org/xmobar/

Config { 
    font = "xft:UbuntuMono Nerd Font:weight=bold:pixelsize=16:antialias=true:hinting=true",
    bgColor = "#292d3e",
    fgColor = "#f07178",
    position = Static { xpos = 1370 , ypos = 5, width = 1432, height = 25 },
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    persistent = True,
    commands = [ 
        Run Date "  %d %b %Y %H:%M " "date" 600,
        Run Network "wlp1s0" ["-t", " <tx>kb  <rx>kb"] 150,
        Run Cpu ["-t", " (<total>%)","-H","50","--high","red"] 150,
        Run Memory ["-t", "  <used>M (<usedratio>%)"] 150,
        Run Com "volume" [] "volume" 10,
        Run Com "bash" ["-c", "apt list --upgradable | sed '1d' | wc -l"] "updates" 3000,
        Run UnsafeStdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "<fc=#b303ff>   </fc> %UnsafeStdinReader% }{ \
        \<action=`alacritty -e sudo apt upgrade` button=1><fc=#e1acff> %updates% </fc></action>\
        --\<fc=#FFB86C> %cpu% </fc>\
        \<fc=#FF5555> %memory% </fc>\
        \<fc=#c3e88d> %wlp1s0% </fc>\
        --\<fc=#82AAFF> %volume% </fc>\
        \<fc=#8BE9FD> %date% </fc>"
}
