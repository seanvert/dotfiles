
module XMonad.TreeMenu.TreeMenu where
import Data.Tree
menu =         -- TODO gerar um menu desses com um arquivo xml ou um arquivo do org mode, sei lá json  tanto faz
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
        ]
