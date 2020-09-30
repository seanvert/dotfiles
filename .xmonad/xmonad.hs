import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.DynamicLog
-- scratchpads
import qualified XMonad.StackSet as W
import XMonad.Util.NamedScratchpad

import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.ManageHook

-- keys
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.DynamicWorkspaces (addWorkspace)
import XMonad.Actions.DynamicProjects
import XMonad.Actions.TreeSelect
import XMonad.Actions.GridSelect
import XMonad.Prompt
import Data.Tree
import XMonad.Util.NamedScratchpad
-- lib que copia as janelas para outras áreas de trabalho
import XMonad.Actions.CopyWindow
import XMonad.Prompt.Shell

import XMonad.Layout.WindowNavigation
import XMonad.Actions.CycleWS
import XMonad.Layout.ComboP

--layout
import XMonad.Layout.Combo
import XMonad.Layout.FixedColumn
import XMonad.Layout.Grid
import XMonad.Layout.LayoutHints
import XMonad.Layout.Master
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.StateFull (focusTracking)
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane

-- TESTES
import XMonad.Layout.ComboP

-- esse daqui acho que é dependência pro combo funcioanr e eu conseguir mudar as janelas de lado
import XMonad.Layout.WindowNavigation

-- transparência
import XMonad.Hooks.FadeInactive


main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar /home/sean/.xmonad/xmobarrc1"

-- TODO colocar o resto das coisas;
-- urgent, title.
-- colors no .xmonad/lib/Colors/Colors.hs
currentFG = color0
currentBG = color4
currentLWrapper = " " --"\xe0d2"
currentLWrapperFG = color2
currentLWrapperBG = color4
currentRWrapper = " " --"\xe0d4"
currentRWrapperFG = color2
currentRWrapperBG = color4
hiddenFG = foreground -- color0
hiddenBG = background -- color2
hiddenLWrapper = ""
hiddenLWrapperFG = color8
hiddenLWrapperBG = color2
hiddenRWrapper = ""
hiddenRWrapperFG = color8
hiddenRWrapperBG = color2
sep = " " --"\xe0b0 "
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

myConfig = ewmh $ dynamicProjects projects def { modMask = mod4Mask -- Use Super instead of Alt
               , borderWidth = 4
               , focusedBorderColor = color14
               , normalBorderColor = color9
               , workspaces = myWorkspaces
               , layoutHook = myLayout
               , handleEventHook = hintsEventHook
               , logHook = myLogHook
               , manageHook = myManageHook <+> manageHook def
               , keys = myKeys
               , startupHook = myStartupHook
               , terminal = myTerminal
               } `additionalKeys` -- aqui vão os atalhos para sobrepor o padrão
  [ ((mod4Mask, xK_p), spawn "rofi -show combi")
  , ((mod4Mask, xK_z)
    , spawn
      "sleep 0.2; scrot -o -s /tmp/screenshot.png -e 'xclip -selection clipboard -t image/png -i $f'")
  , ((0, xK_Print)
    , spawn "scrot -q 1 $HOME/Images/screenshots/%Y-%m-%d-%H:%M:%S.png")
  ]

myPP = 
       namedScratchpadFilterOutWorkspacePP
       xmobarPP
      { ppCurrent =
          xmobarColor currentFG currentBG .
          wrap
            (xmobarColor currentLWrapperFG currentLWrapperBG currentLWrapper)
            (xmobarColor currentRWrapperFG currentRWrapperBG currentRWrapper)
      , ppHidden =
          xmobarColor hiddenFG hiddenBG .
          wrap
            (xmobarColor hiddenLWrapperFG hiddenLWrapperBG hiddenLWrapper)
            (xmobarColor hiddenRWrapperFG hiddenRWrapperBG hiddenRWrapper)
      -- ws -> workspace, l -> layout, wn -> window name
      , ppOrder = \(ws:l:wn:_) -> [ws, shorten 20 l]          
                     -- , xmobarColor layoutFG layoutBG $ shorten 20 l ++ " " ++
                                 -- xmobarColor separatorPPXmobarFG separatorPPXmobarBG separatorPPXmobar]
      , ppSep = xmobarColor sepFG sepBG sep
      , ppWsSep = xmobarColor wsSepFG wsSepBG wsSep
--      , ppUrgent = xmobarColor color5 color2
      , ppTitle = xmobarColor color0 color2 . shorten 50
       }

--    , ppOutput = hPutStrLn xmproc
-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myTerminal = "urxvtc"

myManageHook :: ManageHook
myManageHook =
  namedScratchpadManageHook scratchpads <+>
  composeAll
    [ isDialog --> doFloat
  -- TODO tentar fazer o popup do opera não ficar por baixo das outras janelas
    , stringProperty "_NET_WM_NAME" =? "Picture in Picture" --> doFloat
    , stringProperty "_NET_WM_NAME" =? "Picture-in-Picture" --> doFloat
    , className =? "vlc" --> doFloat
    , className =? "firefox" --> doShift (myWorkspaces !! 2)
    , className =? "mpv" --> doFloat
    , className =? "smplayer" --> doFloat
    , stringProperty "WM_NAME" =? "scratchemacs-frame" --> doFloat
    ]

scratchpads =
  [ (NS
      "notes"
      emacs1   -- "LC_CTYPE=jp_JP.utf-8 emacsclient -c -n -e"
      (stringProperty "WM_NAME" =? "scratchemacs-frame")
    -- rationalrect parameters
    -- screen width from the left, screen height from the top
    -- window width by height
      (customFloating $ W.RationalRect (1120/1920) (20/1080) (800/1920) (1060/1080)))
  , (NS
      "smplayer"
      "smplayer"
      (className =? "smplayer")
      (doRectFloat $ W.RationalRect (1280/1920) (580/1080) (640/1920) (480/1080))) -- (1.0 / 6) (1.0 / 6) (2.0 / 3) (2.0 / 3)))
  -- , (NS
  --     "qutebrowser"
  --     "qutebrowser"
  --     (className =? "qutebrowser")
  --     --(stringProperty "WM_NAME" =? "qutebrowser")
  --     (doRectFloat $ W.RationalRect 0 0 1 1))
  -- TODO está meio bugado, depois eu preciso ver isso melhor
  , (NS
    "gnome-terminal"
    "gnome-terminal -- /bin/bash -c 'tmuxinator desktop9; gnome-terminal --tab; exec bash';"
    (className =? "Gnome-terminal")
    (customFloating $ W.RationalRect (0/1920) (20/1080) (1920/1920) (1060/1080)))
  , (NS
    "mpv"
    "mpv"
    (className =? "mpv")
    (doRectFloat $ W.RationalRect (1280/1920) (580/1080) (640/1920) (380/1080)))
    
  , (NS
    "goldendict"
    "goldendict"
    (className =? "goldendict")
    (customFloating $ W.RationalRect (1/40) (1/40) (17/30) (14/15)))
  ] where
  emacs2 = "emacsclient -nc --alternate-editor='' --no-wait --create-frame --frame-parameters='(quote (name . \"scratchemacs-frame\"))' --display $DISPLAY" 
  emacs1 = "emacsclient --no-wait --create-frame --frame-parameters='(quote (name . \"scratchemacs-frame\"))' --display $DISPLAY"

-- nomes das workspaces
ws1 = "\xf109 "
ws2 = "\xf03a "
ws3 = "\xfa9e "
ws4 = "\xf5bc "
ws5 = "\xf07b "
ws6 = "\xf058 "
ws7 = "\xf09b "
ws8 = "\xf076 "
ws9 = "\xf0ad "

wss = [ ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9 ]

wssk = zipWith (++) kanji wss
  where
    kanji = map (\x -> " " ++ x) [ "一", "二",　"三",　"四",　"五",　"六",　"七",　"八",　"九" ]

wssi = zipWith (++) wss index 
  where
    index = map (\x -> " " ++ (show x) ++ " ") [1..9]
    
myWorkspaces = map (\x -> " " ++ (show x ) ++ " ") [1..9]
  

keysToAdd x =
  [((mod4Mask, xK_c), kill)
 , ((mod4Mask, xK_o), gridselectWorkspace' def
                         { gs_navigate   = navNSearch
                         , gs_rearranger = searchStringRearrangerGenerator id
                         , gs_font = "xft:DroidSansMono Nerd Font:size=15"
                         }
                     addWorkspace)--switchProjectPrompt warmPromptTheme)
  , ((mod4Mask, xK_i), shiftToProjectPrompt warmPromptTheme)
  , ((mod4Mask .|. shiftMask, xK_s    ), sendMessage $ SwapWindow)
--  , ((mod4Mask, xK_p), shellPrompt def)
               -- TODO pensar numas coisas legais pra colocar nesse menu
               -- possibilidades: ver como que funciona o fcitx e colocar um seletor com o rofi ou o dmenu
               -- nmtui -(
 , ((mod4Mask, xK_y) -- mod4Mask, xK_y xf86Display 
    , treeselectAction
        myTreeConf
        -- TODO gerar um menu desses com um arquivo xml ou um arquivo do org mode, sei lá json  tanto faz
        [ Node (TSNode "\xf5dd Brilho" "Muda o brilho da tela com o xbacklight" (return ()))
            [
              Node (TSNode "Máximo" "Meus olhos!11!!1!" (spawn "xbacklight -set 100")) []
            , Node (TSNode "Normal" "50%" (spawn "xbacklight -set 40")) []
            , Node (TSNode "Fraquinho" "Bem escuro" (spawn "xbacklight -set 10")) []
            ]
                                    -- TODO colocar uma opçao pra desativar o wifi
        , Node (TSNode "\xf109 Monitor" "Liga/desliga o monitor" (return ()))
          [
            Node (TSNode "Desliga o monitor" "Desliga o monitor do notebook" (spawn "xrandr --output LVDS1 --off")) []
          , Node (TSNode "Liga o monitor" "Liga o monitor do notebook" (spawn "xrandr --output LVDS1 --primary --mode 1280x720")) []
          ]
        , Node (TSNode "\xfa5d Scale" "Muda a proporção do monitor" (return ()))
          [ Node (TSNode "1.5" "Resolução pequena" (spawn "xrandr --output LVDS1 --scale 1.5x1.5")) []
          , Node (TSNode "1.0" "Resolução padrão" (spawn "xrandr --output LVDS1 --scale 1.0x1.0")) []
          ]
                                    -- TODO colocar uns atalhos para coisas de arquivos
        , Node (TSNode "\xf878 Resolução" "Troca a resolução da tela" (return ()))
            [ Node
              (TSNode
              "1920x1080 VGA1"
              "Monitor externo ou projetor"
              (spawn "xrandr --output VGA1 --primary --mode 1920x1080"))
              []
            , Node
              (TSNode
              "1280x720 LVDS1"
              "Resolução do monitor do notebook"
              (spawn "xrandr --output LVDS1 --primary --mode 1280x720"))
              []
            , Node (TSNode "1280x720 VGA1" "Monitor externo ou projetor" (spawn "xrandr --output VGA1 --primary --mode 1280x720"))
              []
            ]
        , Node (TSNode "\xf11c Remap" "Remapeamento do teclado para usar os números" (return ()))
          [
            Node (TSNode "Ativa o remap" "FnX -> X" (spawn "xmodmap ~/.Xmodmap &")) []
          , Node (TSNode "Desativa o remap" "Mapa de teclas padrão" (spawn "setxkbmap br &")) []
          ]
        ])
  , ((mod4Mask, xK_x), namedScratchpadAction scratchpads "smplayer")
  , ((mod4Mask, xK_v), toggleCopyToAll)
  , ((mod4Mask, xK_Right), sendMessage $ Move R)
  , ((mod4Mask, xK_Left ), sendMessage $ Move L)
  , ((mod4Mask, xK_Up   ), sendMessage $ Move U)
  , ((mod4Mask, xK_Down ), sendMessage $ Move D)
--  , ((mod4Mask, xK_g), namedScratchpadAction scratchpads "goldendict")
  , ((mod4Mask, xK_u), spawn "emacsclient -c -e '(switch-to-buffer nil)' --alternate-editor=''")
--  , ((mod4Mask, xK_a), bringSelected def)
  , ((mod4Mask, xK_a), toggleWS)

  -- , ((mod4Mask, xK_a), bringSelected def
  --                            { gs_navigate   = navNSearch
  --                            , gs_font = "xft:DroidSansMono Nerd Font:size=9"
  --                            })
--                       { gs_rearranger = searchStringRearrangerGenerator id })-- spawn "rofi -show windowcd")
  --, ((mod4Mask, xK_d), namedScratchpadAction scratchpads "qutebrowser")
     -- TODO treeselectAction myTreeConf [test "accomplished" "b" $ return ()]) -- spawn "rofi -show combi") -- TODO achar alguma outra coisa pra colocar aqui
     -- gerar esses menus proceduralmente a partir delistas
  , ((mod4Mask, xK_s) -- , spawn "rofi -show window")
    , spawnSelected'
        [ ("Chrome", "google-chrome-stable")
        , ("Emacs", "emacs")
        , ("Tmux", "urxvtc -e bash -c 'tmuxinator start default'")
        , ("Anki", "anki")
        , ("qBittorrent", "qbittorrent")
        , ("Nemo", "nemo")
        , ("Calibre", "calibre")
        , ("Gimp", "gimp")
        , ("VLC", "vlc")
        , ("FlameShot", "flameshot")
        , ("VSCode", "code")
--        , ("Thunar", "thunar")
        , ("SMplayer", "smplayer")
--        , ("Clementine", "clementine")
--        , ("Recoll", "recoll")
        , ("Libre Office", "libreoffice")
        , ("Zotero", "zotero")
        ])
  , ((mod4Mask, xK_z), spawn "sleep 0.2; scrot -s ~/foo.png && xclip -selection clipboard -t image/png -i ~/foo.png && rm ~/foo.png")
  --TODO: montar um scratchpad com o gnome-terminal, talvez com um auto launch do tmuxinator
  , ((mod4Mask, xK_apostrophe), namedScratchpadAction scratchpads "gnome-terminal")
  , ((0, xK_Print), spawn "scrot -q 1 $HOME/Images/screenshots/%Y-%m-%d-%H:%M:%S.png")
  , ((mod4Mask, xK_f), namedScratchpadAction scratchpads "notes")
--     XMonad.windows W.focusDown)
  , ((mod4Mask, xK_d), XMonad.windows W.focusUp)
  ]
  where
    toggleCopyToAll =
      wsContainingCopies >>= \ws ->
        case ws of
          [] -> windows copyToAll
          _ -> killAllOtherCopies

keysToDel x = [ ((mod4Mask .|. shiftMask), xK_c)
              , ((mod4Mask, xK_p))]
              --((mod4Mask, xK_p))]

newKeys x = M.union (keys def x) (M.fromList (keysToAdd x)) -- to include new keys to existing keys

myKeys x = foldr M.delete (newKeys x) (keysToDel x) -- to delete the unused keys

-- configuração da aparência do menu de árvore
myTreeConf =
  TSConfig
    { ts_hidechildren = True
    , ts_background = 0x70707070--0xc0c0c0c0
    , ts_font = "xft:DroidSansMono Nerd Font:size=14"
    , ts_node = (0xff000000, 0xff50d0db)
    , ts_nodealt = (0xff000000, 0xff10b8d6)
    , ts_highlight = (0xffffffff, 0xffff0000)
    , ts_extra = 0xff000000
    , ts_node_width = 200
    , ts_node_height = 30
    , ts_originX = 0
    , ts_originY = 0
    , ts_indent = 60
    , ts_navigate = XMonad.Actions.TreeSelect.defaultNavigation
    }

myPromptTheme =
  def
    { font = "xft:DroidSansMono Nerd Font:size=10"
    , bgColor = color5
    , fgColor = color0
    , fgHLight = color15
    , bgHLight = color13
    , borderColor = color3
    , promptBorderWidth = 0
    , height = 20
    , position = Top
    }

warmPromptTheme = myPromptTheme -- {bgColor = yellow, fgColor = base03, position = Top}

spawnSelected' :: [(String, String)] -> X ()

spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = def { gs_navigate = navNSearch
               , gs_cellheight = 40
               , gs_cellwidth = 130
               , gs_cellpadding = 30
--               , gs_originFractX = 0.01
               , gs_rearranger = searchStringRearrangerGenerator id
               }    

-- spawnSelected'' lst = gridselect conf lst >>= flip whenJust spawn
--   where
--     conf = defaultGSConfig { -- gs_navigate = defaultNavigation
--                            gs_cellheight = 40
--                            , gs_cellwidth = 130
--                            , gs_cellpadding = 30
--                            , gs_originFractX = 0.01
--                            , gs_rearranger = searchStringRearrangerGenerator id
--                            }

-- -- TODO tá saindo
-- -- mkTree str cdr = Node str TSNode "a" "b" (return ()) [(Node cdr)]
-- test a b trs = Node (TSNode a b (trs)) []


-- colors
-- Shell variables
-- Generated by 'wal'
wallpaper="/home/sean/Images/wallpaper/wallhaven-301875.jpg"

-- Special
background="#190f0b"
foreground="#b4b4b9"
cursor="#b4b4b9"

-- Colors
color0="#190f0b"
color1="#884519"
color2="#89441B"
color3="#8A542C"
color4="#9B6537"
color5="#9B704E"
color6="#AB8767"
color7="#b4b4b9"
color8="#7d7d81"
color9="#884519"
color10="#89441B"
color11="#8A542C"
color12="#9B6537"
color13="#9B704E"
color14="#AB8767"
color15="#b4b4b9"

myLayout =
  onWorkspace (myWorkspaces !! 8) Grid $
  (layoutHints (FixedColumn 1 20 90 10) |||
   noBordersLayout |||
   mastered (5 / 100) (2 / 3 - 5 / 100) (focusTracking tabs) |||
   windowNavigation
     (combineTwoP
        (TwoPane 0.03 0.5)
        (tabbed shrinkText myTabConfig)
        (tabbed shrinkText myTabConfig)
        (Role "browser")))
      -- default tiling algorithm partitions the screen into two panes
  where
    -- multiple = combineTwo (TwoPane 0.03 0.5) (tabbed shrinkText myTabConfig) (tabbed shrinkText myTabConfig)
    tabs = tabbed shrinkText myTabConfig
    noBordersLayout = noBorders Full
    tiled = spacing 40 $ Tall nmaster delta ratio
      -- The default number of windows in the master pane
    nmaster = 1
      -- Default proportion of screen occupied by master pane
    ratio = 2 / 3 - 5 / 100
      -- Percent of screen to increment by when resizing panes
    delta = 5 / 100 -- configurações
    -- TODO não está funcionando
    myTabConfig =
      def
      -- inactiveBorderColor = color15
      --                 , activeTextColor = color0
      --                 , inactiveTextColor = color0
      --                 , activeBorderColor = color3
        { fontName = "xft:DroidSansMono Nerd Font:size=10"
        , activeColor = color14 -- "#999999"
        , inactiveColor = color10 -- "#666666"
        , urgentColor = "#FFFF00"
        , activeBorderColor = color15 --"#FFFFFF"
        , inactiveBorderColor = color8 -- "#BBBBBB"
        , urgentBorderColor = "##00FF00"
        , activeBorderWidth = 1
        , inactiveBorderWidth = 1
        , urgentBorderWidth = 1
        , activeTextColor = "#FFFFFF"
        , inactiveTextColor = "#BFBFBF"
        , urgentTextColor = "#FF0000"
        , decoWidth = 200
        , decoHeight = 25
        , windowTitleAddons = []
        , windowTitleIcons = []
        }

-- comandos pra iniciar junto com o xmonad
myStartupHook = do
  spawn "xrdb -merge ~/.Xresources &"
  spawn "killall stalonetray &"
  spawn "stalonetray &"
  spawn "wal -R &"
  -- TODO enfiar um script pra arrumar a parte do cabeçalho
  --  spawn "cp ~/.cache/wal/colors.hs ~/.xmonad/lib/XMonad/Colors/Colors.hs"
  spawn "pkill -f xmobarrx2 &"
  spawn "xmobar /home/sean/.xmonad/xmobarrc2 &"
  setWMName "LG3D"

-- TODO ver se éisso que está bugando o emacs
-- TODO ver o que está fazendo esse efeito bizarro no vídeo
--  spawn " compton --config ~/.config/compton.conf"

-- transparência nas janelas inativas
myLogHook = fadeInactiveLogHook fadeAmount
  where
    fadeAmount = 0.95

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
