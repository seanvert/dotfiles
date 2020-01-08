module XMonad.Layout.Layout where
-- layouts
import XMonad
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Master
import XMonad.Layout.StateFull (focusTracking)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.FixedColumn
import XMonad.Layout.Simplest
import XMonad.Layout.Decoration

import XMonad.Workspaces.WSConfig

import XMonad.Colors.Colors

-- tamanho das bordas das janelas
border = 4
nobordersLayout = noBorders $ Full

myLayout = onWorkspace (myWorkspaces !! 8) Grid $
           FixedColumn 1 20 90 10 |||
           tabs |||
           tiled -- |||
--           nobordersLayout |||
--           mastered (5/100) (2/3 - 5/100) (focusTracking tabs)
      -- default tiling algorithm partitions the screen into two panes
  where
    tabs = tabbed shrinkText myTabConfig
    tiled = spacing 20 $ Tall nmaster delta ratio
      -- The default number of windows in the master pane
    nmaster = 1
      -- Default proportion of screen occupied by master pane
    ratio = 2 / 3 - 5 / 100
      -- Percent of screen to increment by when resizing panes
    delta = 5 / 100-- configurações
    -- TODO não está funcionando
    myTabConfig = def { inactiveBorderColor = "#0000FF"
                      , activeTextColor = color0
                      , inactiveTextColor = color1
                      , activeBorderColor = color3
--                      , inactiveTabColor = color4
                      , fontName = "xft:DroidSansMono Nerd Font:size=10"
                      , decoHeight = 40}
