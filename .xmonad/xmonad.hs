import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.GridSelect

import XMonad.Hooks.DynamicLog
-- pedaço que faz o wmctrl funcionar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks (checkDock)

import XMonad.Util.EZConfig
-- scratchpads :D
import XMonad.Util.NamedScratchpad
import XMonad.Actions.DynamicProjects -- faz as áreas de trabalho funcionarem com hooks e rodar as coisas


--import XMonad.Actions.CopyWindow --copia as janelas para várias áreas de trabalho
-- Isso daqui que faz o mod + G funcionar com o emacs, smplayer e afins
import XMonad.Actions.SpawnOn --faz os programas aparecerem em determinadas áreas de trabalho

-- meus imports
import XMonad.Workspaces.WSConfig
import XMonad.Colors.Colors
import XMonad.Keys.Keys
import XMonad.Scratchpads.Scratchpads


import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Master
import XMonad.Layout.LayoutHints
import XMonad.Layout.StateFull (focusTracking)
import XMonad.Layout.OneBig
import XMonad.Layout.Combo
import XMonad.Layout.TwoPane
import XMonad.Layout.Dishes

import XMonad.Layout.PerWorkspace
import XMonad.Layout.FixedColumn

-- dynamic workspaces
--import XMonad.Actions.DynamicWorkspaces (addWorkspace)

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar /home/sean/.xmobar/xmobarrc1"

-- TODO colocar o resto das coisas;
-- urgent, title.
-- colors no .xmonad/lib/Colors/Colors.hs
currentFG = color0
currentBG = color4
currentLWrapper = "\xe0d2"
currentLWrapperFG = color2
currentLWrapperBG = color4
currentRWrapper = "\xe0d4"
currentRWrapperFG = color2
currentRWrapperBG = color4
hiddenFG = color0
hiddenBG = color2
hiddenLWrapper = ""
hiddenLWrapperFG = color8
hiddenLWrapperBG = color2
hiddenRWrapper = " "
hiddenRWrapperFG = color8
hiddenRWrapperBG = color2
sep = " "
sepFG = color0
sepBG = color2
wsSep = ""
wsSepFG = color0
wsSepBG = color2
layoutFG = color0
layoutBG = color2
separatorPPXmobar = "\xe0b0"
separatorPPXmobarFG = color2
separatorPPXmobarBG = background


-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP =
  namedScratchpadFilterOutWorkspacePP xmobarPP
    { ppCurrent = xmobarColor currentFG currentBG .
                  wrap (xmobarColor currentLWrapperFG currentLWrapperBG currentLWrapper)
                  (xmobarColor currentRWrapperFG currentRWrapperBG currentRWrapper)
    , ppHidden = xmobarColor hiddenFG hiddenBG .
                 wrap (xmobarColor hiddenLWrapperFG hiddenLWrapperBG hiddenLWrapper) 
                 (xmobarColor hiddenRWrapperFG hiddenRWrapperBG hiddenRWrapper)
      -- ws -> workspace, l -> layout, wn -> window name
    , ppOrder = \(ws:l:_:_) -> [ws                               
                               , xmobarColor layoutFG layoutBG $ shorten 20 l ++ " " ++
                                 xmobarColor separatorPPXmobarFG separatorPPXmobarBG separatorPPXmobar]   
    , ppSep = xmobarColor sepFG sepBG sep
    , ppWsSep = xmobarColor wsSepFG wsSepBG wsSep
    , ppUrgent = xmobarColor color5 color2
    , ppTitle = xmobarColor color0 color2 . shorten 50
--    , ppOutput = hPutStrLn xmproc
    } 

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig =
  dynamicProjects projects $
  ewmh $
  withUrgencyHook NoUrgencyHook
    defaultConfig
      { modMask = mod4Mask -- Use Super instead of Alt
      , focusedBorderColor = color15
      , normalBorderColor = color11
      , borderWidth = border
      , workspaces = myWorkspaces
      , layoutHook =  myLayout
      , handleEventHook = hintsEventHook
--      , handleEventHook = fullscreenEventHook -- faz o fs funcionar
      , manageHook = myManageHook <+> manageHook def
      , keys = myKeys
      , startupHook = myStartupHook
      , terminal = myTerminal
      } `additionalKeys`
      [ ((mod4Mask, xK_p), spawn "rofi -show combi")
      , ((mod4Mask, xK_z), spawn "sleep 0.2; scrot -o -s /tmp/screenshot.png -e 'xclip -selection clipboard -t image/png -i $f'")
      , ((0, xK_Print), spawn "scrot -q 1 $HOME/Images/screenshots/%Y-%m-%d-%H:%M:%S.png") ]
                      
-- tamanho das bordas das janelas
border = 4
nobordersLayout = noBorders $ Full

myLayout = onWorkspace (myWorkspaces !! 8) Grid $
           (tabs |||
            -- Dishes 2 (2/6) |||
            -- OneBig (2/3) (3/4) |||
            layoutHints (FixedColumn 1 20 90 10) |||
            -- layoutHints tiled |||
            nobordersLayout |||
            -- multiple |||
            mastered (5/100) (2/3 - 5/100) (focusTracking tabs)
           )

      -- default tiling algorithm partitions the screen into two panes
  where
    -- multiple = combineTwo (TwoPane 0.03 0.5) (tabbed shrinkText myTabConfig) (tabbed shrinkText myTabConfig)
    tabs = tabbed shrinkText myTabConfig
    tiled = spacing 40 $ Tall nmaster delta ratio
      -- The default number of windows in the master pane
    nmaster = 1
      -- Default proportion of screen occupied by master pane
    ratio = 2 / 3 - 5 / 100
      -- Percent of screen to increment by when resizing panes
    delta = 5 / 100-- configurações
    -- TODO não está funcionando
    myTabConfig = def { inactiveBorderColor = color15
                      , activeTextColor = color0
                      , inactiveTextColor = color0
                      , activeBorderColor = color3
                      , fontName = "xft:DroidSansMono Nerd Font:size=10"
                      , decoHeight = 20 }

myTerminal = "urxvtc"

-- TODO arrumar as cores dos temas pq elas estão horríveis
-- TODO adicoinar um projeto pra mexer no xmonad layout onebig
-- adicionar um outor pra escrever layout mastered tabbed
-- um pra ler também layout mastered tabbed
-- adicionar um para programar com o zeal, emacs, interpretador/terminal
projects :: [Project]
projects =
  [ Project
    { projectName = "desktop"
    , projectDirectory = "~/Desktop"
    , projectStartHook =
        Just $ do
        spawn "urxvtc"
    }
  , Project
    { projectName = "chrome"
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "google-chrome-stable"
    }
  , Project
    { projectName = "xmonad"
    , projectDirectory = "~/.xmonad"
    , projectStartHook =
        Just $ do
        spawn "emacs-client -c ~/.xmonad/xmonad.hs"
    }
  , Project
    { projectName = myWorkspaces !! 8
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn $ myTerminal ++ " -e alsamixer"
          spawn $ myTerminal ++ " -e htop"
          spawn $ myTerminal ++ " -e nmtui"
          spawn myTerminal
    }
    -- TODO arrumar umjeito de fazer essascoisas funcionarem com o emacs
  , Project
    { projectName = "org"
    , projectDirectory = "~/"
    , projectStartHook =
      Just $ do
        spawn "emacsclient -c -e '(filesets-open org)'"
        --spawn "emacsclient ~/Desktop/newgtd.org"
        --spawn "emacsclient ~/ossu/ossu.org"
        spawn "emacsclient ~/semana.org"
    }
  ]

-- comandos pra iniciar junto com o xmonad
myStartupHook = do
  spawn "xrdb -merge ~/.Xresources"
  spawn $ "DISPLAY=:0 feh --bg-scale " ++ wallpaper
  spawn "xmodmap ~/.Xmodmap"

myManageHook :: ManageHook
myManageHook = namedScratchpadManageHook scratchpads
  <+> composeAll
  [ isDialog  --> doFloat
  -- TODO tentar fazer o popup do opera não ficar por baixo das outras janelas
  , stringProperty "_NET_WM_NAME" =? "Picture in Picture" --> doFloat
  , stringProperty "_NET_WM_NAME" =? "Picture-in-Picture" --> doFloat
  , className =? "vlc" --> doFloat
  , className =? "firefox" --> doShift (myWorkspaces !! 2)
  , className =? "mpv" --> doFloat
  , className =? "smplayer" --> doFloat
--  , className =? "GoldenDict" --> doFloat
  , stringProperty "WM_NAME" =? "scratchemacs-frame" --> doFloat ]
