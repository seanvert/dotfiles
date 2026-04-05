module Workspaces where

import XMonad

ws1 = "data "
ws2 = "pdf "
ws3 = "web "
ws4 = "emacs "
ws5 = "git "
ws6 = "var "
ws7 = "conf "
ws8 = "th "
ws9 = "grid "

wss = [ ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9 ]

wssk = zipWith (++) kanji wss
  where
    kanji = map (" " ++) [ "一", "二", "三", "四", "五", "六", "七", "八", "九" ]

kanji = [ "一", "二", "三", "四", "五", "六", "七", "八", "九" ]
wssi = zipWith (++) wss index
  where
    index = map (\x -> " " ++ show x ++ "") [1..9]

myWorkspaces :: [String]
myWorkspaces = kanji

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x    = [x]

clickableWorkspaces :: [String]
clickableWorkspaces = map xmobarEscape [" 1:\xf269 "," 2:\xf120 "," 3:\xf0e0 ", " 4:\xf07c "," 5:\xf1b6 "," 6:\xf281 ", " 7:\xf04b ", " 8:\xf167 "," 9 "]
