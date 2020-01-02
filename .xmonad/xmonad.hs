import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.GridSelect

import XMonad.Hooks.DynamicLog
-- pedaço que faz o wmctrl funcionar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

import XMonad.Hooks.UrgencyHook
--import XMonad.Prompt
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

import XMonad.Layout.PerWorkspace
import XMonad.Layout.FixedColumn

--import Data.Tree
--import XMonad.Actions.TreeSelect
-- dynamic workspaces
--import XMonad.Actions.DynamicWorkspaces (addWorkspace)

-- Função main
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- TODO ver um jeito de lançar as duas barras sem ficar uma merda
-- Comando que vai lançar a barra
myBar = "xmobar /home/sean/.xmobar/xmobarrc1"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP =
  namedScratchpadFilterOutWorkspacePP xmobarPP
  -- a primeira cor é a do nome a segunda é o fundo, os outros dois delimitam a ws ativas
    { ppCurrent = xmobarColor color0 color4 .
                  wrap (xmobarColor color2 color4 "\xe0b0 ") (xmobarColor color4 color2 "\xe0b0")
      --"<fc=#076678> </fc>" "<fc=#076678>\xe0b1</fc>"
    , ppHidden = xmobarColor color0 color2 . wrap " " (xmobarColor color0 color2 "\xe0b1")-- "\xe0b1")
    , ppOrder = \(ws:l:_:_) ->
                  map (\x -> xmobarColor color0 color2 x)
                  [ws, shorten 20 l ++ " " ++ xmobarColor color2 "#222222" "\xe0b0"]   -- ws -> workspace, l -> layout, wn -> window name
    , ppSep = xmobarColor color0 color2 " "-- "\xe0b1"
    , ppWsSep = xmobarColor color2 color2 ""
    , ppUrgent = xmobarColor color5 color2
    , ppTitle = xmobarColor color0 color2 . shorten 50 -- "#A6BBBB" "" . shorten 50
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
      , focusedBorderColor = color15 --"#004cff",
      , normalBorderColor = "#000000"-- color12 -- "#000000" --"#a3beff",
      , borderWidth = border
      , workspaces = myWorkspaces
      , layoutHook =  myLayout
      , handleEventHook = hintsEventHook
--      , handleEventHook = fullscreenEventHook -- faz o fs funcionar
      , manageHook = myManageHook <+> manageHook defaultConfig
      , keys = myKeys
      , startupHook = myStartupHook
      , terminal = myTerminal
      } `additionalKeys`
      [ ((mod4Mask, xK_p), spawn "rofi -show combi")
      , ((mod4Mask, xK_z), spawn "sleep 0.3; scrot -o -s /tmp/screenshot.png && xclip -selection clipboard -t image/png -i /tmp/screenshot.png")]
                      
-- tamanho das bordas das janelas
border = 4
nobordersLayout = noBorders $ Full

myLayout = onWorkspace (myWorkspaces !! 8) Grid $
           (tabs |||
           layoutHints (FixedColumn 1 20 90 10) |||
           layoutHints tiled |||
--           nobordersLayout |||
           mastered (5/100) (2/3 - 5/100) (focusTracking tabs))

      -- default tiling algorithm partitions the screen into two panes
  where
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

-- FUNCIONANDO! :D TODO arrumar as cores dos temas pq elas estão horríveis
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
          spawn "google-chrome-stable" --"firefox"
    }
  -- , Project
  --   { projectName = myWorkspaces !! 4
  --   , projectDirectory = "~/"
  --   , projectStartHook =
  --       Just $ do
  --         spawn "pcmanfm"
  --   }
  -- , Project
  --   { projectName = myWorkspaces !! 7
  --   , projectDirectory = "~/"
  --   , projectStartHook =
  --       Just $ do
  --         spawn "qbittorrent"
  --   }
  , Project
    { projectName = myWorkspaces !! 8
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "urxvtc -e alsamixer"
          spawn "urxvtc -e htop"
          spawn "urxvtc -e nmtui"
          spawn "urxvtc"
    }
    -- TODO arrumar umjeito de fazer essascoisas funcionarem com o emacs
  , Project
    { projectName = "org"
    , projectDirectory = "~/"
    , projectStartHook =
      Just $ do
        spawn "emacsclient -c -n -e '(filesets-open org)'"
        --spawn "emacsclient ~/Desktop/newgtd.org"
        --spawn "emacsclient ~/ossu/ossu.org"
        spawn "emacsclient ~/semana.org"
    }
  ]

-- comandos pra iniciar junto com o xmonad
myStartupHook = do
  spawn "xrdb -merge ~/.Xresources"
  spawn "xmodmap ~/.Xmodmap"
--  spawn "pcmanfm --desktop &"
--  spawn "sleep 0.3; xmobar ~/.xmobar/xmobarrc2"
--  spawn "/home/sean/.xmobar/xmobarc.sh"


myManageHook :: ManageHook
myManageHook = namedScratchpadManageHook scratchpads
  <+> composeAll
--  composeAll
  [-- checkDock -?> doIgnore
  isDialog  --> doFloat
--  , isFullscreen --> -- doSideFloat NW -- doFullFloat
  -- TODO tentar fazer o popup do opera não ficar por baixo das outras janelas
  , stringProperty "WM_WINDOW_ROLE" =? "popup" --> doFloat
  , className =? "vlc" --> doFloat
  , className =? "smplayer" --> doFloat
  , className =? "GoldenDict" --> doFloat
--  , className =? "google-chrome" --> doShift (myWorkspaces !! 2) ]
  , stringProperty "WM_NAME" =? "scratchemacs-frame" --> doFloat ]
--  , className =? "firefox" --> doShift "www"]
