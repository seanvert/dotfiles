module Scratchpads (scratchpads) where

import XMonad
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Hooks.ManageHelpers

import Settings (myTerminal)

scratchpads :: [NamedScratchpad]
scratchpads =
  [ (NS
      "notes"
      "emacsclient --no-wait --create-frame --frame-parameters='(quote (name . \"scratchemacs-frame\"))' --display $DISPLAY"
      (stringProperty "WM_NAME" =? "scratchemacs-frame")
      (customFloating $ W.RationalRect (20/1080) (1120/1920) (1060/1080) (800/1920)))
  , (NS "capture" "emacsclient -n -e '(make-capture-frame)'"
        (title =? "emacs-capture") -- O xmonad agora foca apenas no frame de captura
        (customFloating $ W.RationalRect (300/1920) (20/1080) (1300/1920) (1000/1080)))
  , (NS
      "nano-emacs"
      "emacsclient --no-wait --create-frame --frame-parameters='(quote (name . \"scratch-nano-emacs-frame\"))' --display $DISPLAY"
      (stringProperty "WM_NAME" =? "scratch-nano-emacs-frame")
      (customFloating $ W.RationalRect (10/1080) (20/1920) (940/1080) (1800/1920)))
   , (NS
     "edgeb"
     "microsoft-edge-stable https://chat.bing.com/ --user-data-dir=\"~/.config/microsoft-edge-bingchat\" --new-window --force-dark-mode --enable-features-WebUIDarkMode --class=\"binggpt\" --start-fullscreen"
     (className =? "binggpt")
     (customFloating $ W.RationalRect (960/1920) (10/1080) (960/1920) (1060/1080)))
  , (NS
      "smplayer"
      "smplayer"
      (className =? "smplayer")
      (doRectFloat $ W.RationalRect (1280/1920) (580/1080) (640/1920) (480/1080)))
  , (NS
     "gnome-terminal"
     (myTerminal ++ " -- /bin/bash -c 'tmuxinator desktop9; gnome-terminal --tab; exec bash';")
     (className =? "Gnome-terminal")
     (customFloating $ W.RationalRect (0/1080) (0/1920) (1080/1080) (960/1920)))
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
  ]
