import System.Exit
import System.IO

import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Actions.WindowNavigation
import XMonad.Layout.Gaps
import XMonad.Layout.FixedColumn
import XMonad.Layout.LimitWindows
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowNavigation
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Util.Run(spawnPipe)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- terminal
myTerminal :: [Char]
myTerminal = "urxvt"

-- whether focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- width of the window border in pixels
myBorderWidth :: Dimension
myBorderWidth = 2

-- mod key
myModMask = mod4Mask

-- workspaces
myWorkspaces = ["term", "web", "im", "rdp", "misc"]

-- border colors
myNormalBorderColor = "#1c2022"
myFocusedBorderColor = "#606060"

myGSConfig = defaultGSConfig { gs_font = "xft:monospace:size=8:bold" }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  -- launch terminal
  [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

  -- dmenu
  , ((modm, xK_r), spawn "/usr/bin/dmenu_run")

  -- close window
  , ((modm .|. shiftMask, xK_c), kill)

  -- rotate through available layout algorithms
  , ((modm, xK_space), sendMessage NextLayout)

  -- reset the layouts on the current workspace to default
  , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

  -- resize viewed windows to the correct size
  , ((modm, xK_n), refresh)

  -- move focus to the next window
  , ((modm, xK_Tab), windows W.focusDown)

  -- move focus to the master window
  , ((modm, xK_m), windows W.swapMaster)

  -- grid select
  , ((modm, xK_z), goToSelected $ myGSConfig)

  -- push window back to tiling
  , ((modm, xK_t), withFocused $ windows . W.sink)

  -- increment the number of windows in master area
  , ((modm, xK_comma), sendMessage (IncMasterN 1))

  -- deincrement the number of windows in master area
  , ((modm, xK_period), sendMessage (IncMasterN (-1)))

  -- lock screen
  , ((modm .|. shiftMask, xK_z), spawn "xtrlock")

  -- quit
  , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))

  -- browser
  , ((modm, xK_q), spawn "firefox")

  -- emacs
  , ((modm, xK_s), spawn "emacs")

  -- reload config
  , ((modm .|. controlMask, xK_r), spawn "xmonad --recompile; xmonad --restart") ]
  ++

  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster))
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                     >> windows W.shiftMaster)) ]

myGap = gaps [(U, 10), (D, 10), (L, 10), (R, 10)]

myLayout = Mirror fixed ||| tiled ||| Mirror tiled ||| full
   where
     tiled = myGap $ Tall nmaster delta ratio
     full = myGap $ Full
     nmaster = 1
     delta = 3/100
     ratio = 1/2
     fixed = myGap $ limitWindows 6 $ magnifiercz 1.1 $ spacing 10 $
             FixedColumn 3 20 80 10

myManageHook = composeAll
  [ className =? "Firefox" --> doFloat
  , className =? "Gimp" --> doFloat
  , className =? "Eclipse" --> doFloat
  , className =? "Pidgin" --> doFloat ]

myStartupHook :: X()
myStartupHook = do spawn "fcitx"
                   spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 --heighttype pixel --height 17"
                   spawn "feh --bg-fill ~/.awesomebg"

main :: IO()
main = do
  xmproc <- spawnPipe "xmobar"
  config <- withWindowNavigation (xK_k, xK_h, xK_j, xK_l)
            $ defaultConfig {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- keys bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = avoidStruts $ myLayout,
    manageHook         = manageDocks <+> myManageHook,
    startupHook        = myStartupHook,
    logHook            = dynamicLogWithPP xmobarPP
                         { ppOutput = hPutStrLn xmproc
                         , ppTitle = xmobarColor "green" "" . shorten 50
                         }
    }

  xmonad config
