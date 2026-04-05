module Colors where

import XMonad
import XMonad.Prompt

-- Special
background="#1c0d04"
foreground="#e0c8a3"
cursor="#e0c8a3"

-- Colors
color0="#1c0d04"
color1="#CF6B27"
color2="#7A8529"
color3="#A98F2D"
color4="#D89A2B"
color5="#E6C83D"
color6="#AE9057"
color7="#e0c8a3"
color8="#9c8c72"
color9="#CF6B27"
color10="#7A8529"
color11="#A98F2D"
color12="#D89A2B"
color13="#E6C83D"
color14="#AE9057"
color15="#e0c8a3"

currentFG = color0
currentBG = color4
currentLWrapper = "\xe0d2"
currentLWrapperFG = color2
currentLWrapperBG = color4
currentRWrapper = "\xe0d4"
currentRWrapperFG = color2
currentRWrapperBG = color4
hiddenFG = foreground
hiddenBG = background
hiddenLWrapper = ""
hiddenLWrapperFG = color8
hiddenLWrapperBG = color2
hiddenRWrapper = ""
hiddenRWrapperFG = color8
hiddenRWrapperBG = color2
sep = " "
sepFG = color2
sepBG = color0
wsSep = ""
wsSepFG = color0
wsSepBG = color2
layoutFG = foreground
layoutBG = color2
separatorPPXmobar = "\xe0b0"
separatorPPXmobarFG = color2
separatorPPXmobarBG = background

myPromptTheme :: XPConfig
myPromptTheme =
  def
    { font = "xft:FiraMono Nerd Font:size=10"
    , bgColor = color5
    , fgColor = color0
    , fgHLight = color15
    , bgHLight = color13
    , borderColor = color3
    , promptBorderWidth = 0
    , height = 20
    , position = Top
    }
