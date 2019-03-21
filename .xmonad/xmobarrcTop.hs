Config { font = "xft:lucy tewi:style=Regular:pixelsize=11,Efont Biwidth:pixelsize=12,Misc Fixed Wide:size=8"
       , additionalFonts = [ "xft:Wuncon Siji"
                           , "xft:lucy tewi:style=Bold:pixelsize=11"
                           ]
       , bgColor = "#0b0806"
       , fgColor = "#a19782"
       , alpha = 255
       , position = Static { xpos = 0
                           , ypos = 0
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
                    , Run Date "<fn=1>\57893</fn>%d.%m.%y / %A / %H:%M" "date" 10
                    , Run Weather "UUWW" [ "-t", "<fn=1>\57550</fn><station><tempC>°C" ] 50000
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader%\
                    \}{\
                    \%UUWW%   %date% "
       }
   
-- vim:filetype=haskell:expandtab:tabstop=4:shiftwidth=4
