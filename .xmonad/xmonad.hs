import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
-- pedaço que faz o wmctrl funcionar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Prompt

import XMonad.Util.EZConfig
-- scratchpads :D
import XMonad.Util.NamedScratchpad
import XMonad.Actions.DynamicProjects -- faz as áreas de trabalho funcionarem com hooks e rodar as coisas
import XMonad.Layout.PerWorkspace

import XMonad.Actions.CopyWindow --copia as janelas para várias áreas de trabalho
-- Isso daqui que faz o mod + G funcionar com o emacs, smplayer e afins
import XMonad.Actions.SpawnOn --faz os programas aparecerem em determinadas áreas de trabalho

-- tree select
import Data.Tree
import XMonad.Actions.TreeSelect


-- Função main
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Comando que vai lançar a barra
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP =
  xmobarPP
    { ppCurrent = xmobarColor "#A6E22E" "" . wrap "\xf100" "\xf101"
    , ppOrder = \(ws:_:t:_) -> [ws]
    }


-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig =
  dynamicProjects projects $
  ewmh
    defaultConfig
      { modMask = mod4Mask -- Use Super instead of Alt
      , focusedBorderColor = "#F6AA29" --"#004cff",
      , normalBorderColor = "#000000" --"#a3beff",
      , borderWidth = border
      , workspaces = myWorkspaces
      , layoutHook =  myLayout
--      , handleEventHook = fullscreenEventHook -- fullscreen handle
      , manageHook = myManageHook <+> manageHook defaultConfig
      , keys = myKeys
      , startupHook = myStartupHook
      , terminal = myTerminal
      } `additionalKeys`
  [((mod4Mask, xK_p), spawn "rofi -show combi")]


nobordersLayout = noBorders $ Full

myLayout = onWorkspace ws9 Grid $ tiled ||| nobordersLayout
      -- default tiling algorithm partitions the screen into two panes
  where
    tiled = Tall nmaster delta ratio
      -- The default number of windows in the master pane
    nmaster = 1
      -- Default proportion of screen occupied by master pane
    ratio = 2 / 3 - 5 / 100
      -- Percent of screen to increment by when resizing panes
    delta = 5 / 100-- configurações

myTerminal = "urxvtc"

-- tamanho das bordas das janelas
border = 2

-- workspaces's numes
ws1 = "\xf109 "
ws2 = "\xf03a "
ws3 = "\xf268 "
ws4 = "\xf02d "
ws5 = "\xf07b "
ws6 = "\xf058 "
ws7 = "\xf09b "
ws8 = "\xf076 "
ws9 = "\xf0ad"

-- TODO adicionar um esquema pra mexer nas cores dos ícones das workspaces

myWorkspaces = zipWith (++) kanji [ ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9 ]
  where
    cor = "4682B4"
    kanji = map colorize [ "一", "二",　"三",　"四",　"五",　"六",　"七",　"八",　"九" ]
    -- função que adiciona as cores
    colorize x = "<fc=#" ++ cor ++ ">" ++ x ++ "</fc>"



-- FUNCIONANDO! :D TODO arrumar as cores dos temas pq elas estão horríveis
projects :: [Project]
projects =
  [ Project
    { projectName = ws1
    , projectDirectory = "~/Desktop"
    , projectStartHook =
        Just $ do
        spawn "urxvtc"
    }
  , Project
    { projectName = ws3
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "google-chrome-stable" --"firefox"
    }
  , Project
    { projectName = ws5
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "thunar"
    }
  , Project
    { projectName = "Torrent"
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn "transmission-qt"
    }
  , Project
    { projectName = ws9
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
        spawn "emacsclient -c -n ~/vest/vestibular.org -e '(switch-to-buffer nil)'"
        spawn "emacsclient ~/Desktop/newgtd.org"
        spawn "emacsclient ~/ossu/ossu.org"
        spawn "emacsclient ~/semana.org"
    }
  ]

-- comandos pra iniciar junto com o xmonad
myStartupHook = do
  spawn "xrdb -merge ~/.Xresources"
  setWMName "LG3D"


myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "smplayer" --> doFloat ]
--  , className =? "Emacs" --> doFloat ]
--  , className =? "firefox" --> doShift "www"]

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = defaultGSConfig

scratchpads =
  [ (NS
      "notes"
      "LC_CTYPE=jp_JP.utf-8 emacsclient -c -n -e"
      (className =? "Emacs")
      defaultFloating)
  , (NS
      "smplayer"
      "smplayer"
      (className =? "smplayer")
      -- TODO não está funcionando
      (customFloating $ W.RationalRect (1 / 6) (1 / 6) (2 / 3) (2 / 3)))
  ]

keysToAdd x =
  [ ((mod4Mask, xK_c), kill)
  , ((mod4Mask, xK_o), switchProjectPrompt warmPromptTheme)
  , ((mod4Mask, xK_i), shiftToProjectPrompt warmPromptTheme)
               -- TODO pensar numas coisas legais pra colocar nesse menu
               -- possibilidades: ver como que funciona o fcitx e colocar um seletor com o rofi ou o dmenu
               -- nmtui -(
  , ((mod4Mask, xK_y)
    , treeselectAction
        myTreeConf
        [ Node
            (TSNode
               "Desligar/Reiniciar"
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
            [ Node
                (TSNode
                   "Máximo"
                   "Meus olhos!11!!1!"
                   (spawn "xbacklight -set 100"))
                []
            , Node (TSNode "Normal" "50%" (spawn "xbacklight -set 50")) []
            , Node
                (TSNode "Fraquinho" "Bem escuro" (spawn "xbacklight -set 10"))
                []
            ]
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
            , Node
              (TSNode
              "1280x720 VGA1"
              "Monitor externo ou projetor"
              (spawn "xrandr --output VGA1 --primary --mode 1280x720"))
              []
            ]
        , Node
            (TSNode "Orgmode" "Arquivos de agenda, diário e afins" (return ()))
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
                   (spawn
                      "emacsclient -c /home/sean/emacs/org/agenda/tarefas.org"))
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
                   (spawn
                      "emacsclient -c /home/sean/emacs/org/agenda/notes_accomplished.org"))
                []
            ]
        ])
  , ((mod4Mask, xK_x), namedScratchpadAction scratchpads "smplayer")
  , ((mod4Mask, xK_v), toggleCopyToAll)
  , ((mod4Mask, xK_g), namedScratchpadAction scratchpads "notes")
  , ((mod4Mask, xK_u), spawn "emacsclient -c -n -e '(switch-to-buffer nil)'")
  , ((mod4Mask, xK_a), bringSelected defaultGSConfig)
  , ((mod4Mask, xK_d), spawn "rofi -show combi") -- goToSelected defaultGSConfig)
  , ((mod4Mask, xK_s)
    , spawnSelected'
        [ ("Firefox", "firefox")
        , ("Emacs", "emacsclient -c")
        , ("Tmux", "urxvtc -e bash -c 'tmuxinator start default'")
        , ("Anki", "anki")
        , ("PCManFM", "pcmanfm")
        ])
  , ((mod4Mask, xK_z), spawn "urxvtc")
  , ((mod4Mask, xK_f), spawn "scrot -s $HOME/Images/screenshots/%Y-%m-%d-%H:%M:%S.png")
  , ((0, xK_Print)
    , spawn "scrot -q 1 $HOME/Images/screenshots/%Y-%m-%d-%H:%M:%S.png")
  ]
  where
    toggleCopyToAll =
      wsContainingCopies >>= \ws ->
        case ws of
          [] -> windows copyToAll
          _ -> killAllOtherCopies

keysToDel x = [((mod4Mask .|. shiftMask), xK_c)]
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
    , ts_font = "xft:Sans-16"
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
    { font = "xft:Sans-10"
    , bgColor = base03
    , fgColor = active
    , fgHLight = base03
    , bgHLight = active
    , borderColor = base03
    , promptBorderWidth = 0
    , height = 20
    , position = Top
    }

warmPromptTheme =
  myPromptTheme {bgColor = yellow, fgColor = base03, position = Top}
