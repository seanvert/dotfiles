import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.GridSelect
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
-- pedaço que faz o wmctrl funcionar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Master
import XMonad.Layout.StateFull (focusTracking)

import XMonad.Layout.FixedColumn
import XMonad.Prompt
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks (checkDock)

import XMonad.Util.EZConfig
-- scratchpads :D
import XMonad.Util.NamedScratchpad
import XMonad.Actions.DynamicProjects -- faz as áreas de trabalho funcionarem com hooks e rodar as coisas
import XMonad.Layout.PerWorkspace

import XMonad.Actions.CopyWindow --copia as janelas para várias áreas de trabalho
-- Isso daqui que faz o mod + G funcionar com o emacs, smplayer e afins
import XMonad.Actions.SpawnOn --faz os programas aparecerem em determinadas áreas de trabalho

-- meus imports
import XMonad.Workspaces.WSConfig
import XMonad.Colors.Colors
-- tree select
import Data.Tree
import XMonad.Actions.TreeSelect
-- dynamic workspaces
import XMonad.Actions.DynamicWorkspaces (addWorkspace)

-- Função main
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- TODO ver um jeito de lançar as duas barras sem ficar uma merda
-- Comando que vai lançar a barra
myBar = "xmobar /home/sean/.xmobar/xmobarrc1"
--myBar = "/home/sean/.xmobar/xmobarc.sh"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP =
  namedScratchpadFilterOutWorkspacePP xmobarPP
  -- a primeira cor é a do nome a segunda é o fundo, os outros dois delimitam a ws ativas
    { ppCurrent = xmobarColor light0_hard faded_orange . wrap (xmobarColor faded_orange faded_orange " ") (xmobarColor faded_orange light4 "\xe0b0")
      --"<fc=#076678> </fc>" "<fc=#076678>\xe0b1</fc>"
    , ppHidden = xmobarColor dark0 light4 . wrap "" "<fc=#282828,#a89984>\xe0b1</fc>"
    , ppOrder = \(ws:l:wn:_) -> map (\x -> "<fc=" ++ dark0 ++ "," ++ light4 ++">"++x ++ " "  ++ "</fc>") [ws,l] --  [xmobarColor "" "" l]
    , ppSep = xmobarColor faded_orange light1 ""
    , ppWsSep = xmobarColor light4 light4 " "
    , ppUrgent = xmobarColor bright_red light4
    , ppTitle = xmobarColor "#A6BBBB" "" . shorten 50
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
      , focusedBorderColor = neutral_orange --"#004cff",
      , normalBorderColor = "#000000" --"#a3beff",
      , borderWidth = border
      , workspaces = myWorkspaces
      , layoutHook =  myLayout
      , manageHook = myManageHook <+> manageHook defaultConfig
      , keys = myKeys
      , startupHook = myStartupHook
      , terminal = myTerminal
      } `additionalKeys`
      [ ((mod4Mask, xK_p), spawn "rofi -show combi"), ((mod4Mask, xK_z), spawn "sleep 0.3; scrot -o -s /tmp/screenshot.png && xclip -selection clipboard -t image/png -i /tmp/screenshot.png")]

-- tamanho das bordas das janelas
border = 2
nobordersLayout = noBorders $ Full

-- TODO adicionar tabs dentro dos layouts internos tipo aquele vídeo do yt

myLayout = onWorkspace (myWorkspaces !! 8) Grid $
           FixedColumn 1 20 90 10 |||
           tiled |||
--           nobordersLayout |||
           mastered (5/100) (2/3 - 5/100) (focusTracking tabs)
      -- default tiling algorithm partitions the screen into two panes
  where
    tabs = tabbed shrinkText myTabConfig
    tiled = Tall nmaster delta ratio
      -- The default number of windows in the master pane
    nmaster = 1
      -- Default proportion of screen occupied by master pane
    ratio = 2 / 3 - 5 / 100
      -- Percent of screen to increment by when resizing panes
    delta = 5 / 100-- configurações
    myTabConfig = def { inactiveBorderColor = "#FF0000"
                      , activeTextColor = "#00FF00"
                      , fontName = "xft:DroidSansMono Nerd Font:size=10"
                      , decoHeight = 20}

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
  , Project
    { projectName = myWorkspaces !! 4
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "pcmanfm"
    }
  , Project
    { projectName = myWorkspaces !! 7
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "qbittorrent"
    }
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
  setWMName "LG3D"
  spawn "sleep 0.3; xmobar ~/.xmobar/xmobarrc2"
--  spawn "/home/sean/.xmobar/xmobarc.sh"


myManageHook :: ManageHook
myManageHook = composeAll
  [-- checkDock -?> doIgnore
  isDialog  --> doFloat
  , isFullscreen --> doFullFloat
  , className =? "vlc" --> doFloat
  , stringProperty "WM_NAME" =? "scratchemacs-frame" --> doFloat ]
--  , className =? "firefox" --> doShift "www"]

spawnSelected' :: [(String, String)] -> X ()

spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = defaultGSConfig { gs_navigate = navNSearch
                           , gs_cellheight = 40
                           , gs_cellwidth = 130
                           , gs_cellpadding = 30
                           , gs_originFractX = 0.01
                           , gs_rearranger = searchStringRearrangerGenerator id
                           }

spawnSelected'' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = defaultGSConfig { -- gs_navigate = defaultNavigation
                           gs_cellheight = 40
                           , gs_cellwidth = 130
                           , gs_cellpadding = 30
                           , gs_originFractX = 0.01
                           , gs_rearranger = searchStringRearrangerGenerator id
                           }

scratchpads =
  [ (NS
      "notes"
      emacs1   -- "LC_CTYPE=jp_JP.utf-8 emacsclient -c -n -e"
      (stringProperty "WM_NAME" =? "scratchemacs-frame")
      (doRectFloat $ W.RationalRect 0 0 1 1))
  , (NS
      "vlc"
      "vlc"
      (className =? "vlc")
      -- TODO não está funcionando
      (doRectFloat $ W.RationalRect 0 0 1 1)) -- (1.0 / 6) (1.0 / 6) (2.0 / 3) (2.0 / 3)))
  -- , (NS
  --     "qutebrowser"
  --     "qutebrowser"
  --     (className =? "qutebrowser")
  --     --(stringProperty "WM_NAME" =? "qutebrowser")
  --     (doRectFloat $ W.RationalRect 0 0 1 1))
  ] where
  emacs1 = "emacsclient --alternate-editor='' --no-wait --create-frame --frame-parameters='(quote (name . \"scratchemacs-frame\"))' --display $DISPLAY"

-- TODO tá saindo
-- mkTree str cdr = Node str TSNode "a" "b" (return ()) [(Node cdr)]
test a b trs = Node (TSNode a b (trs)) []


keysToAdd x =
  [((mod4Mask, xK_c), kill)
  , ((mod4Mask, xK_o), gridselectWorkspace' defaultGSConfig
                         { gs_navigate   = navNSearch
                         , gs_rearranger = searchStringRearrangerGenerator id
                         , gs_font = "xft:DroidSansMono Nerd Font:size=15"
                         }
                     addWorkspace)--switchProjectPrompt warmPromptTheme)
  , ((mod4Mask, xK_i), shiftToProjectPrompt warmPromptTheme)
               -- TODO pensar numas coisas legais pra colocar nesse menu
               -- possibilidades: ver como que funciona o fcitx e colocar um seletor com o rofi ou o dmenu
               -- nmtui -(
  , ((mod4Mask, xK_y)
    , treeselectAction
        myTreeConf
        -- TODO gerar um menu desses com um arquivo xml ou um arquivo do org mode, sei lá json  tanto faz
        [ Node
            (TSNode
               "\xf011 "
               "Desligar/Reiniciar/Hibernar"
               (return ()))
            [ Node
                (TSNode
                   "Desligar"
                   "Desligar o computador"
                   (spawn "shutdown -h now"))
                []
            , Node
                (TSNode
                  "Reiniciar"
                  "Reinicia o computador"
                  (spawn "reboot"))
                []
            ]
        , Node
            (TSNode
               "Brilho"
               "Muda o brilho da tela com o xbacklight"
               (return ()))
            [ Node (TSNode "Máximo" "Meus olhos!11!!1!" (spawn "xbacklight -set 100")) []
            , Node (TSNode "Normal" "50%" (spawn "xbacklight -set 50")) []
            , Node (TSNode "Fraquinho" "Bem escuro" (spawn "xbacklight -set 10")) []]
                                    -- TODO colocar uma opçao pra desativar o wifi
        , Node
            (TSNode
               "Redes"
               "Seleciona redes cabeadas ou sem fio"
               (spawn "urxvtc -e nmtui"))
            []
                                    -- TODO colocar uns atalhos para coisas de arquivos
        , Node
            (TSNode
               "Resolução da tela"
               "Troca a resolução da tela"
               (return ()))
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
        , Node
            (TSNode "\x03be Orgmode" "Arquivos de agenda, diário e afins" (return ()))
            [ Node
                (TSNode
                   "learn"
                   "1 learn"
                   (spawn "emacsclient -c /home/sean/emacs/org/agenda/learn.org"))
                []
            , Node
                (TSNode
                   "tarefas"
                   "1 tarefas"
                   (spawn "emacsclient -c /home/sean/emacs/org/agenda/tarefas.org"))
                []
            , Node
                (TSNode
                   "notes"
                   "1 notes"
                   (spawn "emacsclient -c /home/sean/emacs/org/agenda/notes.org"))
                []
            , Node
                (TSNode
                   "accomplished"
                   "descrição"
                   (spawn "emacsclient -c /home/sean/emacs/org/agenda/notes_accomplished.org"))
                []
            ]
        ])
  , ((mod4Mask, xK_x), namedScratchpadAction scratchpads "vlc")
  , ((mod4Mask, xK_v), toggleCopyToAll)
  , ((mod4Mask, xK_g), namedScratchpadAction scratchpads "notes")
  , ((mod4Mask, xK_u), spawn "emacsclient -c -n -e '(switch-to-buffer nil)'")
  , ((mod4Mask, xK_a), bringSelected defaultGSConfig)
  --, ((mod4Mask, xK_d), namedScratchpadAction scratchpads "qutebrowser")
     -- TODO treeselectAction myTreeConf [test "accomplished" "b" $ return ()]) -- spawn "rofi -show combi") -- TODO achar alguma outra coisa pra colocar aqui
     -- gerar esses menus proceduralmente a partir delistas
  , ((mod4Mask, xK_s), spawn "rofi -show windowcd")
  -- , ((mod4Mask, xK_p), spawn "rofi -show combi")
    -- , spawnSelected'
    --     [ ("qutebrowser", "qutebrowser")
    --     , ("Emacs", "emacsclient -c")
    --     , ("Tmux", "urxvtc -e bash -c 'tmuxinator start default'")
    --     , ("Anki", "anki")
    --     , ("Thunar", "thunar")
    --     , ("VLC", "vlc")
    --     , ("Clementine", "clementine")
    --     , ("Recoll", "recoll")
    --     , ("Libre Office", "libreoffice")
    --     , ("Zotero", "zotero")
    --     ])
  , ((mod4Mask, xK_d), spawn "rofi -show window")
    -- , spawnSelected''
    --   [ ("Português", "fcitx-remote -s fcitx-keyboard-br")
    --   , ("Alemão", "fcitx-remote -s fcitx-keyboard-gr")
    --   , ("Russo", "fcitx-remote -s fcitx-keyboard-ru")
    --   , ("Japonês", "fcitx-remote -s mozc")
    --   , ("Coreano", "fcitx-remote -s hangul")])
--  , ((mod4Mask, xK_z), spawn "sleep 0.2; scrot -s ~/foo.png && xclip -selection clipboard -t image/png -i ~/foo.png && rm ~/foo.png")
  , ((0, xK_Print), spawn "scrot -q 1 $HOME/Images/screenshots/%Y-%m-%d-%H:%M:%S.png")
  , ((mod4Mask, xK_f), XMonad.windows W.focusDown)
  , ((mod4Mask, xK_n), XMonad.windows W.focusUp)
  ]
  where
    toggleCopyToAll =
      wsContainingCopies >>= \ws ->
        case ws of
          [] -> windows copyToAll
          _ -> killAllOtherCopies



keysToDel x = [ ((mod4Mask .|. shiftMask), xK_c)
              , ((mod4Mask, xK_n))]
              --((mod4Mask, xK_p))]

newKeys x = M.union (keys defaultConfig x) (M.fromList (keysToAdd x)) -- to include new keys to existing keys

myKeys x = foldr M.delete (newKeys x) (keysToDel x) -- to delete the unused keys


-- cores
base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green = "#859900"

active = blue
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
    , bgColor = base03
    , fgColor = active
    , fgHLight = base03
    , bgHLight = active
    , borderColor = base03
    , promptBorderWidth = 0
    , height = 20
    , position = Top
    }

warmPromptTheme = myPromptTheme {bgColor = yellow, fgColor = base03, position = Top}
