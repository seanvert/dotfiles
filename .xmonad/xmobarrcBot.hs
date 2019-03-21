Config { font = "xft:lucy tewi:style=Regular:pixelsize=11,Efont Biwidth:pixelsize=12,Misc Fixed Wide:size=8"
       , additionalFonts = [ "xft:Wuncon Siji:style=Regular"
                           , "xft:lucy tewi:style=Bold:pixelsize=11"
                           ]
       , bgColor = "#0b0806"
       , fgColor = "#a19782"
       , alpha = 255
       , position = Static { xpos = 0
                           , ypos = 876
                           , width = 1600
                           , height = 24
                           }
       , textOffset = 16
       , iconOffset = -1
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , overrideRedirect = False
       , pickBroadest = False
       , persistent = False
       , border = FullBM 0
       , borderColor = "#2f2b2a"
       , borderWidth = 1
       , iconRoot = "."
       , commands = [ Run StdinReader
                    , Run Battery [ "-t", "<fn=1><acstatus></fn><left>%"
                                  , "--"
                                  , "-i", "\57914", "-O", "\57913" , "-o", "\57911"
                                  ] 10
                    , Run Cpu [ "-t", "<fn=1>\57381</fn><total>%" ] 10
                    , Run CoreTemp [ "-t", "<core0>°C / <core1>°C" ] 10
                    , Run Memory [ "-t", "<fn=1>\57384</fn><usedratio>%" ] 10
                    , Run ThermalZone 0 ["-t","<fn=1>\57371</fn><temp>°C"] 10
                    , Run ThermalZone 1 ["-t","<temp>°C"] 10
                    , Run Wireless "wlp3s0" [ "-t", "<fn=1>\57882</fn><essid> <quality>%" ] 10
                    , Run DynNetwork [ "-t", "<fn=1>\57760</fn><dev> <rx>|<tx>" ] 10
                    , Run Kbd [ ("us", "<fn=1>\57967</fn>English / <fn=1>\57898</fn>")
                              , ("ru", "<fn=1>\57967</fn>Russian / <fn=1>\57898</fn>")]
                    , Run Com "/home/free/.xmonad/scripts/xmobar/fcitx.sh" [] "fcitx" 3
                    , Run Locks
                    , Run MPD [ "-t", "<fn=1><statei></fn><artist> - <title> (<album>) <track>/<plength> [<length>]"
                              , "--"
                              , "-P", "\57498", "-Z", "\57499", "-S", "\57497"
                              ] 10
                    , Run Volume "default" "Master" [ "-t", "<fn=1><status></fn><volume>%" 
                                                    , "--"
                                                    , "--on"   , "\57427"
                                                    , "--off"  , "\57426"
                                                    , "--onc"  , "#a19782"
                                                    , "--offc" , "#a19782"
                                                    ] 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %battery%   %cpu% / %coretemp%   %memory%   %thermal0% / %thermal1%   %wlp3s0wi%   %dynnetwork%   %StdinReader%\
                    \}%kbd%%fcitx%{\
                    \%mpd%   %default:Master% "
       }
   
-- vim:filetype=haskell:expandtab:tabstop=4:shiftwidth=4
