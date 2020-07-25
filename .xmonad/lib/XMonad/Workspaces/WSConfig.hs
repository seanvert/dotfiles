module XMonad.Workspaces.WSConfig where
-- nomes das workspaces
ws1 = "\xf109 "
ws2 = "\xf03a "
ws3 = "\xfa9e "
ws4 = "\xf5bc "
ws5 = "\xf07b "
ws6 = "\xf058 "
ws7 = "\xf09b "
ws8 = "\xf076 "
ws9 = "\xf0ad "

wss = [ ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9 ]

wssk = zipWith (++) kanji wss
  where
    kanji = map (\x -> " " ++ x) [ "一", "二",　"三",　"四",　"五",　"六",　"七",　"八",　"九" ]

wssi = zipWith (++) wss index 
  where
    index = map (\x -> " " ++ (show x) ++ " ") [1..9]
    
myWorkspaces = wssk
