module XMonad.Scratchpads.Scratchpads where
import qualified XMonad.StackSet as W
import XMonad.Util.NamedScratchpad
--import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.SetWMName
--import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.ManageHook
import XMonad

scratchpads :: [NamedScratchpad]
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