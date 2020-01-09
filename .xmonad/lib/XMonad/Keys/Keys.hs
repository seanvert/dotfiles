module XMonad.Keys.Keys where
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.DynamicWorkspaces (addWorkspace)
import XMonad.Actions.DynamicProjects
import XMonad.Actions.TreeSelect
import XMonad.Actions.GridSelect
import XMonad.Prompt
import Data.Tree
import XMonad.Util.NamedScratchpad
import XMonad.Scratchpads.Scratchpads
import XMonad.Actions.CopyWindow
import XMonad.Prompt.Shell

import XMonad.Colors.Colors
keysToAdd x =
  [((mod4Mask, xK_c), kill)
 , ((mod4Mask, xK_o), gridselectWorkspace' def
                         { gs_navigate   = navNSearch
                         , gs_rearranger = searchStringRearrangerGenerator id
                         , gs_font = "xft:DroidSansMono Nerd Font:size=15"
                         }
                     addWorkspace)--switchProjectPrompt warmPromptTheme)
  , ((mod4Mask, xK_i), shiftToProjectPrompt warmPromptTheme)

--  , ((mod4Mask, xK_p), shellPrompt def)
               -- TODO pensar numas coisas legais pra colocar nesse menu
               -- possibilidades: ver como que funciona o fcitx e colocar um seletor com o rofi ou o dmenu
               -- nmtui -(
 , ((mod4Mask, xK_y)--mod4Mask, xK_y) xf86Display 
    , treeselectAction
        myTreeConf
        -- TODO gerar um menu desses com um arquivo xml ou um arquivo do org mode, sei lá json  tanto faz
        [
          -- Node
          --   (TSNode
          --      "\xf011 "
          --      "Desligar/Reiniciar/Hibernar"
          --      (return ()))
          --   [ Node
          --       (TSNode
          --          "Desligar"
          --          "Desligar o computador"
          --          (spawn "shutdown -h now"))
          --       []
          --   , Node
          --       (TSNode
          --         "Reiniciar"
          --         "Reinicia o computador"
          --         (spawn "reboot"))
          --       []
          --   ],
          Node
            (TSNode
               "Brilho"
               "Muda o brilho da tela com o xbacklight"
               (return ()))
            [ Node (TSNode "Máximo" "Meus olhos!11!!1!" (spawn "xbacklight -set 100")) []
            , Node (TSNode "Normal" "50%" (spawn "xbacklight -set 40")) []
            , Node (TSNode "Fraquinho" "Bem escuro" (spawn "xbacklight -set 10")) []]
                                    -- TODO colocar uma opçao pra desativar o wifi
        , Node
            (TSNode
               "Desliga o monitor"
               "Desliga o monitor do notebook"
               (spawn "xrandr --output LVDS1 --off"))
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
        -- , Node
        --     (TSNode "\x03be Orgmode" "Arquivos de agenda, diário e afins" (return ()))
        --     [ Node
        --         (TSNode
        --            "learn"
        --            "1 learn"
        --            (spawn "emacsclient -c /home/sean/emacs/org/agenda/learn.org"))
        --         []
        --     , Node
        --         (TSNode
        --            "tarefas"
        --            "1 tarefas"
        --            (spawn "emacsclient -c /home/sean/emacs/org/agenda/tarefas.org"))
        --         []
        --     , Node
        --         (TSNode
        --            "notes"
        --            "1 notes"
        --            (spawn "emacsclient -c /home/sean/emacs/org/agenda/notes.org"))
        --         []
        --     , Node
        --         (TSNode
        --            "accomplished"
        --            "descrição"
        --            (spawn "emacsclient -c /home/sean/emacs/org/agenda/notes_accomplished.org"))
        --         []
        --     ]
        ])
  , ((mod4Mask, xK_x), namedScratchpadAction scratchpads "smplayer")
  , ((mod4Mask, xK_v), toggleCopyToAll)
--  , ((mod4Mask, xK_g), namedScratchpadAction scratchpads "goldendict")
  , ((mod4Mask, xK_u), spawn "emacsclient -c -e '(switch-to-buffer nil)' --alternate-editor=''")
--  , ((mod4Mask, xK_a), bringSelected def)
  , ((mod4Mask, xK_a), spawn "rofi -show windowcd")
  --, ((mod4Mask, xK_d), namedScratchpadAction scratchpads "qutebrowser")
     -- TODO treeselectAction myTreeConf [test "accomplished" "b" $ return ()]) -- spawn "rofi -show combi") -- TODO achar alguma outra coisa pra colocar aqui
     -- gerar esses menus proceduralmente a partir delistas
  , ((mod4Mask, xK_s), spawn "rofi -show window")
    -- , spawnSelected'
    --     [ ("qutebrowser", "qutebrowser")
    --     , ("Emacs", "emacsclient -c")
    --     , ("Tmux", "urxvtc -e bash -c 'tmuxinator start default'")
    --     , ("Anki", "anki")
    --     , ("Thunar", "thunar")
    --     , ("SMplayer", "smplayer")
    --     , ("Clementine", "clementine")
    --     , ("Recoll", "recoll")
    --     , ("Libre Office", "libreoffice")
    --     , ("Zotero", "zotero")
    --     ])
  , ((mod4Mask, xK_z), spawn "sleep 0.2; scrot -s ~/foo.png && xclip -selection clipboard -t image/png -i ~/foo.png && rm ~/foo.png")
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
               , gs_originFractX = 0.01
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


