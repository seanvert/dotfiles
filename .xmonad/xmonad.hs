{-# OPTIONS_GHC -i. -i./Config #-}
{-# OPTIONS_GHC -i. -i./Config -i./lib #-}

import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
-- scratchpads
import           XMonad.Util.NamedScratchpad
import           Data.Text.Encoding
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageHelpers
import           XMonad.ManageHook
import           XMonad.Hooks.WindowSwallowing

import           XMonad.Hooks.ManageDocks (docks)
import XMonad.Util.Run (spawnPipe, hPutStrLn)

import           Colors
-- import           Colors
-- tree menu
-- TODO consertar este arquivo separado
-- import           TreeMenu
import           Data.Tree
import           XMonad.Actions.TreeSelect
-- keys
import qualified Data.Map as M
import           XMonad.Actions.DynamicWorkspaces (addWorkspace)
import           XMonad.Actions.DynamicProjects

import           XMonad.Actions.GridSelect
import           XMonad.Prompt

import           XMonad.Util.NamedScratchpad
-- lib que copia as janelas para outras áreas de trabalho
import           XMonad.Actions.CopyWindow
import           XMonad.Prompt.Shell

import           XMonad.Actions.CycleWS

--layout
import XMonad.Layout.Drawer
import           XMonad.Layout.Grid
import		 XMonad.Layout.CircleEx
import XMonad.Layout.Mosaic
import           XMonad.Layout.LayoutHints
import           XMonad.Layout.Master
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Spacing
-- import           XMonad.Layout.StateFull (focusTracking)
import           XMonad.Layout.Tabbed

import           XMonad.Layout.Reflect

-- TESTES
import           XMonad.Util.SpawnOnce

-- transparência
import           XMonad.Hooks.FadeInactive
import           Workspaces
import           Layouts (myLayout)
import           Scratchpads (scratchpads)
import           Projects (projects)
import           Settings (myTerminal, warmPromptTheme)

import XMonad.Util.Run (runProcessWithInput)
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import Control.Monad (when)
import Data.List (intercalate)
import Data.Char (isSpace)
-- Colors, workspaces, layouts, scratchpads and projects live in Config.* modules
main = statusBar myBar myPP toggleStrutsKey myConfig >>= xmonad

myBar = "xmobar /home/sean/.xmonad/xmobarrc1"

myConfig = ewmh $ dynamicProjects projects $ docks def {
  modMask = mod4Mask -- Use Super instead of Alt
  , borderWidth = 3
  , focusedBorderColor = color7
  , normalBorderColor = color0
  , workspaces = myWorkspaces
  , layoutHook = myLayout
  , handleEventHook = hintsEventHook
    -- swallowEventHook
    -- (className =? "urxvt" <||> className =? "URxvt")
    -- (return True)
    -- <>
  , logHook = myLogHook
  , manageHook = myManageHook <+> manageHook def
  , keys = myKeys
  , startupHook = myStartupHook
  , terminal = myTerminal
  } `additionalKeys` -- aqui vão os atalhos para sobrepor o padrão
  [ ((mod4Mask, xK_p), spawn "rofi -show combi")
  , ((mod4Mask, xK_F8), spawn "~/.config/picom/toggle-shader.sh")
  , (((mod4Mask .|. shiftMask), xK_s), namedScratchpadAction scratchpads "edgeb")
  , ((0, xK_Print)
    , spawn "flameshot gui")
  ]
-- `myTerminal` and `warmPromptTheme` are provided by `Config.Settings`

myPP = 
       filterOutWsPP ["NSP"]
       xmobarPP
      {
        ppCurrent =
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
      , ppOrder = \(ws:l:wn:_) -> [ws, shorten 40 l]
                     -- , xmobarColor layoutFG layoutBG $ shorten 20 l ++ " " ++
                                 -- xmobarColor separatorPPXmobarFG separatorPPXmobarBG separatorPPXmobar]
      , ppSep = xmobarColor sepFG sepBG sep
      , ppWsSep = xmobarColor wsSepFG wsSepBG wsSep
      , ppUrgent = xmobarColor color5 color2
      , ppTitle = xmobarColor color0 color2 . shorten 50
      }

-- -- TODO tá saindo
-- -- mkTree str cdr = Node str TSNode "a" "b" (return ()) [(Node cdr)]
-- test a b trs = Node (TSNode a b (trs)) []

-- transparência nas janelas inativas
-- myLogHook = fadeInactiveLogHook fadeAmount
--   where
--     fadeAmount = 0.8
myLogHook = dynamicLogWithPP $ def
  { ppOutput = \s -> writeFile "/tmp/xmonad-layout" ("<txt>" ++ s ++ "</txt>")
        , ppCurrent = \s -> "<span color='#5294e2' weight='bold'>[" ++ s ++ "]</span>"
        , ppVisible = \s -> "<span color='#ffffff'>(" ++ s ++ ")</span>"
        , ppHidden  = \s -> " " ++ s ++ " "
        , ppSep     = "  <span color='#444444'>|</span>  "
        , ppOrder   = \[ws, l, t] -> [ws, l] -- Mostra: [1] | Spacing Grade
        }
    -- { ppOutput = \s -> spawn $ "echo '" ++ s ++ "' > /tmp/xmonad-layout"
    -- , ppOrder  = \[_, l, _] -> [l] -- Pega apenas o nome do Layout
    -- }

-- Prompt theme moved to `Config.Colors.myPromptTheme`

myTreeConf =
  TSConfig
    { ts_hidechildren = True
    , ts_background = 0x70707070--0xc0c0c0c0
    , ts_font = "xft:FiraMono Nerd Font:size=14"
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

-- lista com a lista de teclas
-- https://hackage.haskell.org/package/X11-1.10.3/docs/Graphics-X11-Types.html#g:2
keysToAdd x =
  [ ((mod4Mask, xK_i), shiftToProjectPrompt warmPromptTheme)
  , ((mod4Mask, xK_o), gridselectWorkspace' def
                         { gs_navigate   = navNSearch
                         , gs_rearranger = searchStringRearrangerGenerator id
                         , gs_font = "xft:FiraMono Nerd Font:size=15"
                         }
                     addWorkspace)
  , ((mod4Mask, xK_c), spawn "emacsclient -c -F '(quote (name . \"emacs-capture\"))' -e '(my/quick-capture-inbox)'")
               -- TODO pensar numas coisas legais pra colocar nesse menu
               -- possibilidades: ver como que funciona o fcitx e colocar um seletor com o rofi ou o dmenu
               -- nmtui -(
 , ((mod4Mask, xK_y)
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
            Node (TSNode "Desliga o monitor" "Desliga o monitor do notebook" (spawn "xrandr --output LVDS-1 --off")) []
          , Node (TSNode "Liga o monitor" "Liga o monitor do notebook" (spawn "xrandr --output LVDS-1 --primary --mode 1280x720")) []
          , Node (TSNode "Monitor na vertical" "Monitor VGA na Vertical" (spawn "xrandr --output VGA-1 --primary --mode 1920x1080 --rotate right --output LVDS-1 --mode 1366x768 --right-of VGA-1")) []
          , Node (TSNode "Monitor na vertical" "Monitor VGA na Vertical" (spawn "xrandr --output VGA-1 --primary --mode 1920x1080 --rotate right --output LVDS-1")) []
          , Node (TSNode "Monitor na horizontal" "Monitor VGA na Horizontal" (do spawn "xrandr --output VGA-1 --primary --mode 1920x1080 --rotate normal --output LVDS-1 --mode 1366x768 --right-of VGA-1")) []
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
  , ((mod4Mask, xK_Insert), spawn "xdotool type $(grep -v '^#' ~/.local/share/bookmarks | dmenu -i -l 50 | cut -d' ' -f1)")

  -- , ((mod4Mask, xK_g), namedScratchpadAction scratchpads "goldendict")
  , ((mod4Mask, xK_u), spawn "emacsclient -c -e '(switch-to-buffer nil)' --alternate-editor=''")

  , ((mod4Mask, xK_a), toggleWS)
    -- TODO treeselectAction myTreeConf [test "accomplished" "b" $ return ()]) -- spawn "rofi -show combi")
    -- TODO achar alguma outra coisa pra colocar aqui
    -- gerar esses menus proceduralmente a partir delistas
  , ((mod4Mask, xK_s), namedScratchpadAction scratchpads "nano-emacs")
  , ((mod4Mask, xK_z), namedScratchpadAction scratchpads "edgeb")
  , ((mod4Mask, xK_g), namedScratchpadAction scratchpads "gnome-terminal")
  , ((mod4Mask, xK_f), namedScratchpadAction scratchpads "nano-emacs")
  , ((mod4Mask, xK_d), XMonad.windows W.focusUp)
  , (((mod4Mask .|. shiftMask), xK_b), spawn "/home/sean/.local/bin/bookmarks.sh")
  , ((mod4Mask, xK_backslash), chooseLayout)
  , ((mod4Mask .|. shiftMask, xK_y), sendMessage (JumpToLayout "Cheia"))
  ]
  where
    toggleCopyToAll =
      wsContainingCopies >>= \ws ->
        case ws of
          [] -> windows copyToAll
          _ -> killAllOtherCopies

chooseLayout :: X ()
chooseLayout = do
    let layouts = ["Principal", "Três", "Cheia", "Círculo", "Grade"]
    -- O 'unlines' monta a lista para o rofi
    selection <- runProcessWithInput "rofi" ["-dmenu", "-p", "Layout:", "-i"] (unlines layouts)
    
    -- O 'trim' remove espaços e o \n fatal do final
    let cleanedSelection = filter (not . isSpace) selection
    
    when (not $ null cleanedSelection) $ sendMessage (JumpToLayout cleanedSelection)


keysToDel x = [((mod4Mask, xK_p))]

newKeys x = M.union (keys def x) (M.fromList (keysToAdd x)) -- to include new keys to existing keys

myKeys x = foldr M.delete (newKeys x) (keysToDel x) -- to delete the unused keys

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = def { gs_navigate = navNSearch
               , gs_cellheight = 40
               , gs_cellwidth = 130
               , gs_cellpadding = 30
               , gs_rearranger = searchStringRearrangerGenerator id
               }    


-- nomes das workspaces
-- ws1 = "\xf109 "
-- ws2 = "\xf03a "
-- ws3 = "\xfa9e "
-- ws4 = "\xf5bc "
-- ws5 = "\xf07b "
-- ws6 = "\xf058 "
-- ws7 = "\xf09b "
-- ws8 = "\xf076 "
-- ws9 = "\xf0ad "
-- Workspaces, scratchpads, projects and layouts moved to `Config.*` modules

myStartupHook = do
--  spawn "xrdb -merge ~/.Xresources &"
--  spawnOnce "stalonetray &"
--  spawnOnce "lxpanel &"
--  spawnOnce "wal -R &"
  spawnOnce "fcitx5 -d"
  spawnOnce "nitrogen --restore"
  -- spawnOnce "conky &"
  -- TODO enfiar um script pra arrumar a parte do cabeçalho
  --  spawn "cp ~/.cache/wal/colors.hs ~/.xmonad/lib/XMonad/Colors/Colors.hs"
--  spawn "pkill -f xmobarrc2; sleep 10 ; xmobar /home/sean/.xmonad/xmobarrc2"
  spawn "wmname LG3D"
  spawnOnce "flameshot &"
  spawnOnce "xfce4-panel &"
  spawnOnce "variety &"
-- co  spawnOnce "eww daemon"
--  spawn "setxkbmap -option ctrl:nocaps &"
  spawn "killall xcape; xcape -e 'Control_L=Escape' -t 175 &"
  spawnOnce "redshift-gtk -t 6000:1500 &"
--  spawnOnce "~/projetos/input-leap/bin/input-leaps -c /home/sean/.config/barrier/barrier.conf -f -a 192.168.0.100:24800 -n arch --no-tray --disable-client-cert-checking -d INFO
--  spawnOnce "~/projetos/input-leap/bin/input-leapc -d DEBUG1 [192.168.0.200]:24800"
  spawn "numlockx"
  spawn "setxkbmap -option 'ctrl:rctrl_is_super'"
  spawn "setxkbmap -option caps:super"
  spawnOnce "urxvtd"
--  spawnOnce "emacs --init-directory=\"/home/sean/emacs.d\" --daemon"
  spawn "eval $(ssh-agent)"
  spawnOnce "udiskie --no-notify --use-udisks2 --tray"
  spawn "xsetroot -cursor_name left_ptr"
--  spawn "setxkbmap -model pc104 -layout us -variant intl"
  spawn "xrandr --output LVDS-1 --off"
  spawn "xrandr --output VGA-1 --primary --mode 1920x1080 --brightness 1"
-- TODO ver se é isso que está bugando o emacs
-- TODO ver o que está fazendo esse efeito bizarro no vídeo
--  spawn " compton --config ~/.config/compton.conf"

myManageHook :: ManageHook
myManageHook =
  namedScratchpadManageHook scratchpads <+>
  composeAll
    [ isDialog --> doFloat
  -- TODO tentar fazer o popup do opera não ficar por baixo das outras janelas
    , stringProperty "_NET_WM_NAME" =? "Picture in Picture" --> doFloat
    , stringProperty "WM_NAME" =? "Picture-in-picture" --> doFloat
    , className =? "vlc" --> doFloat
--    , className =? "firefox" --> doShift (myWorkspaces !! 2)
    , className =? "mpv" --> doFloat
    , className =? "smplayer" --> doFloat
    , stringProperty "WM_NAME" =? "scratchemacs-frame" --> doFloat
    , stringProperty "WM_NAME" =? "emacs-capture" --> doFloat
    ]



--    , ppOutput = hPutStrLn xmproc
-- Layout definitions moved to `Config.Layouts`

-- TODO arrumar as cores dos temas pq elas estão horríveis
-- TODO adicoinar um projeto pra mexer no xmonad layout onebig
-- adicionar um outor pra escrever layout mastered tabbed
-- um pra ler também layout mastered tabbed
-- adicionar um para programar com o zeal, emacs, interpretador/terminal
-- Projects moved to `Config.Projects`
