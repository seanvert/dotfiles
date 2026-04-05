module Layouts (myLayout) where

import XMonad
import XMonad.Layout.Grid
import XMonad.Layout.Mosaic
import XMonad.Layout.LayoutHints
import XMonad.Layout.Master
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.Drawer
--import XMonad.Layout.CircleEx 
import Layout.CircleEx
import XMonad.Layout.Reflect
import XMonad.Layout.ToggleLayouts (ToggleLayout, toggleLayouts)
import XMonad.Hooks.ManageDocks (avoidStruts)
import qualified XMonad.StackSet as W
import Workspaces (myWorkspaces)
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.ThreeColumns

import XMonad.Layout.PerWorkspace (onWorkspaces)
-- Defina seus conjuntos de layouts
-- layoutNotebook = Tall 1 (3/100) (1/2) ||| Full
-- layoutMonitor  = ThreeColMid 1 (3/100) (1/2) ||| Mirror Tall ||| Full

-- -- No seu myLayout:
-- myLayout = perScreen layoutMonitor layoutNotebook
-- myLayout = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True $ firstLayout

-- firstLayout =
--   avoidStruts $
--   onWorkspace (myWorkspaces !! 8) (renamed [Replace "Grade"] (magnifier Grid)) $
--   renamed [Replace "Principal"] (Tall 1 (3/100) (3/5))
--   ||| renamed [Replace "Três"] (ThreeColMid 1 (3/100) (1/2))
-- --  ||| drawer `onTop` (Tall 1 0.03 0.5)
-- --  ||| mosaic 2 [3,2]
--   ||| Mirror (Tall 1 (3/100) (3/5))
--   ||| renamed [Replace "Cheia"] noBordersLayout
--   ||| renamed [Replace "Círculo"] circleEx {
--   cNMaster = 1
--   , cMasterRatio = 8/10
--   , cStackRatio = 1/5
--   , cMultiplier = 3
--   , cDelta = -3*pi/4
--   }
--   where
--     drawer = simpleDrawer 0.01 0.3 (ClassName "Rhythmbox" `Or` ClassName "Gimp")
--     noBordersLayout = noBorders Full
-- No seu Layouts.hs

-- Adicione o import do spacing se for usar no final
import XMonad.Layout.Spacing (spacingRaw, Border(..))

-- Defina os layouts separadamente sem o avoidStruts interno para evitar duplicação de margens
monitorLayouts = 
      renamed [Replace "Três"] (ThreeColMid 1 (3/100) (1/2))
  ||| renamed [Replace "Principal"] (Tall 1 (3/100) (3/5))
  ||| renamed [Replace "Cheia"] (noBorders Full)

notebookLayouts = 
      renamed [Replace "Refletido"] (Mirror (Tall 1 (3/100) (3/5)))
  ||| renamed [Replace "Círculo"] circleEx { 
        cNMaster = 1, cMasterRatio = 8/10, cStackRatio = 1/5, 
        cMultiplier = 3, cDelta = -3*pi/4 
      }
  ||| renamed [Replace "Cheia"] (noBorders Full)

-- A lógica final
myLayout = avoidStruts 
         $ spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True
         $ onWorkspaces (take 5 myWorkspaces) monitorLayouts 
         $ onWorkspace (myWorkspaces !! 8) (renamed [Replace "Grade"] (magnifier Grid))
         $ notebookLayouts
