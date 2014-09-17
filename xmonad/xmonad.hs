import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run(spawnPipe)
import Data.Monoid
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- terminal
myTerminal = "urxvt"

-- whether focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- width of the window border in pixels
myBorderWidth = 2

-- mod key
myModMask = mod4Mask

-- workspaces
myWorkspaces = ["term", "web", "im", "rdp", "misc"]

-- border colors
myNormalBorderColor = "#1c2022"
myFocusedBorderColor = "#606060"

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

  -- move focus to the next window
  , ((modm, xK_j), windows W.focusDown)

  -- move focus to the previous window
  , ((modm, xK_k), windows W.focusUp)

  -- move focus to the master window
  , ((modm, xK_m), windows W.swapMaster)

  -- swap the focused window with the next window
  , ((modm .|. shiftMask, xK_j), windows W.swapDown)

  -- swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k), windows W.swapUp)

  -- shrink the master area
  , ((modm, xK_h), sendMessage Shrink)

  -- swap the focused window with the previous window
  , ((modm, xK_l), sendMessage Expand)

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

  , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart") ]
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

myLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100

myManageHook = composeAll
  [ className =? "Firefox" --> doFloat
  , className =? "Gimp" --> doFloat
  , className =? "Eclipse" --> doFloat
  , className =? "Pidgin" --> doFloat ]

myStartupHook = do spawn "fcitx"
                   spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 --heighttype pixel --height 17"

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig {
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
