module TreeMenu
    ( teste
    , teste1
    ) where
import           Data.Tree
import           XMonad.Actions.TreeSelect
import           XMonad
import           XMonad.ManageHook
import           XMonad.Util.Run


teste1="adf"
teste = [ Node (TSNode
                "\xf5dd Brilho"
                "Muda o brilho da tela com o xbacklight" (return ()))
            [
              Node (TSNode
                    "Máximo"
                    "Meus olhos!11!!1!" (spawn "xbacklight -set 100")) []
            , Node (TSNode
                    "Normal"
                    "50%" (spawn "xbacklight -set 40")) []
            , Node (TSNode
                    "Fraquinho"
                    "Bem escuro" (spawn "xbacklight -set 10")) []
            ]
                                    -- TODO colocar uma opçao pra desativar o wifi
        , Node (TSNode
                "\xf109 Monitor"
                "Liga/desliga o monitor" (return ()))
          [
            Node (TSNode
                  "Desliga o monitor"
                  "Desliga o monitor do notebook" (spawn "xrandr --output LVDS-1 --off")) []
          , Node (TSNode
                  "Liga o monitor"
                  "Liga o monitor do notebook" (spawn "xrandr --output LVDS-1 --primary --mode 1280x720")) []
          , Node (TSNode
                  "Monitor na vertical"
                  "Monitor VGA na Vertical" (spawn "xrandr --output VGA-1 --primary --mode 1920x1080 --rotate right --output LVDS-1 --mode 1366x768 --right-of VGA-1")) []
          , Node (TSNode
                  "Monitor na horizontal"
                  "Monitor VGA na Horizontal" (do spawn "xrandr --output VGA-1 --primary --mode 1920x1080 --rotate normal --output LVDS-1 --mode 1366x768 --right-of VGA-1")) []
          ]
        , Node (TSNode
                "\xfa5d Scale"
                "Muda a proporção do monitor" (return ()))
          [ Node (TSNode
                  "1.5"
                  "Resolução pequena" (spawn "xrandr --output LVDS1 --scale 1.5x1.5")) []
          , Node (TSNode
                  "1.0"
                  "Resolução padrão" (spawn "xrandr --output LVDS1 --scale 1.0x1.0")) []
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
            , Node (TSNode
                    "1280x720 VGA1"
                    "Monitor externo ou projetor" (spawn "xrandr --output VGA1 --primary --mode 1280x720"))
              []
            ]
        , Node (TSNode
                "\xf11c Remap"
                "Remapeamento do teclado para usar os números" (return ()))
          [
            Node (TSNode
                  "Ativa o remap"
                  "FnX -> X" (spawn "xmodmap ~/.Xmodmap &")) []
          , Node (TSNode
                  "Desativa o remap"
                  "Mapa de teclas padrão" (spawn "setxkbmap br &")) []
          ]
        ]
