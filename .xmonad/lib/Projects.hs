module Projects (projects) where

import XMonad
import XMonad.Actions.DynamicProjects
import Settings (myTerminal)

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
    { projectName = "grid"
    , projectDirectory = "~/"
    , projectStartHook =
        Just $ do
          spawn $ myTerminal ++ " -e alsamixer"
          spawn $ myTerminal ++ " -e htop"
          spawn $ myTerminal ++ " -e nmtui"
          spawn myTerminal
    }
  , Project
    { projectName = "org"
    , projectDirectory = "~/"
    , projectStartHook =
      Just $ do
        spawn "emacsclient -c -e '(filesets-open org)'"
        spawn "emacsclient ~/semana.org"
    }
  ]
