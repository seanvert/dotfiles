-- workspaces's names

module XMonad.Workspaces.WSConfig where
-- nomes das workspaces
ws1 = "\xf109 "
ws2 = "\xf03a "
ws3 = "\xf268 "
ws4 = "\xf5bc "
ws5 = "\xf07b "
ws6 = "\xf058 "
ws7 = "\xf09b "
ws8 = "\xf076 "
ws9 = "\xf0ad"

-- TODO adicionar um esquema pra mexer nas cores dos ícones das workspaces
cor = "4682B4"
myWorkspaces = zipWith (++) index [ ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9 ]
  where
    index = map show [1..9]
    junta x y = (x, y)
    --index = map (colorize "00aaff") $ map show [1..9]
      --map (colorize cor) $ map show [1..9]
    kanji = [ "一", "二",　"三",　"四",　"五",　"六",　"七",　"八",　"九" ]
    -- Argumentos: Cor em hex sem #, nome do workspace
    -- função que adiciona as cores
    colorize :: String -> String -> String
    colorize cor1 head =
      "<fc=#" ++ cor1 ++ ">" ++ head ++ "</fc>"
