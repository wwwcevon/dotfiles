import Data.Ratio ((%))
import System.Exit
import System.IO



import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Actions.WindowNavigation
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Drawer
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.FixedColumn
import XMonad.Layout.IM
import XMonad.Layout.LimitWindows
import XMonad.Layout.MagicFocus
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Prompt(defaultXPConfig)
import XMonad.Prompt.Ssh
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Themes (ThemeInfo(..))


import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.MultiToggle as MToggle
import qualified XMonad.Layout.Magnifier as Magnifier

-- terminal
myTerminal :: [Char]
myTerminal = "urxvt"

-- whether focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- width of the window border in pixels
myBorderWidth :: Dimension
myBorderWidth = 3

-- mod key
myModMask = mod4Mask

-- workspaces
myWorkspaces = ["term", "web", "im", "rdp", "misc"]

-- border colors
myNormalBorderColor = "#1c2022"
myFocusedBorderColor = "#1fe0c7"

myGSConfig = defaultGSConfig { gs_font = "xft:monospace:size=8:bold" }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  -- launch terminal
  [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

  -- dmenu
  , ((modm, xK_r), spawn "/usr/bin/dmenu_run -fn DejaVuSansMono")

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

  -- toggle fullscreen
  , ((modm, xK_f), sendMessage $ MToggle.Toggle FULL)

  -- grid select
  , ((modm, xK_z), goToSelected $ myGSConfig)

  -- toggle window magnifier
  , ((modm, xK_o), sendMessage Magnifier.Toggle)

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

  -- ssh
  , ((modm .|. controlMask, xK_s), sshPrompt defaultXPConfig)

  -- browser
  , ((modm, xK_q), spawn "firefox")

  -- emacs
  , ((modm, xK_s), spawn "emacs")

  -- pidgin
  , ((modm, xK_c), spawn "pidgin")

  -- pidgin
  , ((modm, xK_k), spawn "/bin/bash -l -c 'mikutter'")

  -- reload config
  , ((modm .|. controlMask, xK_r), spawn "killall -9 trayer-srg; killall -9 xwrits; xmonad --recompile; xmonad --restart") ]
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


---
--- {{ Theme
---

tangoTheme :: ThemeInfo
tangoTheme = TI { themeName = "Tango!"
                , theme = defaultTheme { activeColor         = "#3465a4"
                                       , activeTextColor     = "#eeeeec"
                                       , activeBorderColor   = "#204a87"
                                       , inactiveColor       = "#2e3436"
                                       , inactiveTextColor   = "#d3d7cf"
                                       , inactiveBorderColor = "#2e3436"
                                       , urgentColor         = "#2e3436"
                                       , urgentTextColor     = "#f57900"
                                       , urgentBorderColor   = "#ce5c00"
                                       , decoHeight          = 16
                                       }
                }

myTheme :: Theme
myTheme = (theme tangoTheme) { fontName = "xft:monospace:size=10:bold" }

---
--- Theme }}
---

---
--- {{ Layouts
---

myLayout = avoidStruts $ smartBorders $ gap $ toggleFull
           $ onWorkspaces ["term"] (term)
           $ onWorkspaces ["web"] (web)
           $ onWorkspaces ["im"] (chat)
           $ onWorkspaces ["rdp"] (float)
           $ (float ||| tileTall ||| tileWide ||| max)
  where

    nmaster  = 1
    delta    = 3/100
    vhalf    = 1/2
    thirds   = 1/3
    ratio    = 7/10

    float    = renamed [Replace "[float]"] $ simplestFloat
    tileTall = renamed [Replace "[tile tall]"]
               $ withTitles (Tall nmaster delta ratio)

    tileWide = renamed [Replace "[tile wide]"] $ Mirror $ Tall nmaster delta thirds
    max      = renamed [Replace "[max]"] $ Full

    term     = renamed [Replace "[term]"] $ reflectVert $ reflectHoriz $
               limitWindows 6 $ spacing 10 $ magnifiercz' 1.2
               $ Mirror $ FixedColumn 3 10 80 10

    chat     = renamed [Replace "[chat]"] $ spacing 10 $ reflectHoriz $ pidgin


    web      = renamed [Replace "[web]"] $ mikutter `onRight` tileTall
    mikutter = simpleDrawer 0.01 0.4 (Title "mikutter")
    pidgin   = withIM (1%5) (Title "Buddy List") Grid

    toggleFull = mkToggle (NOBORDERS ?? FULL ?? EOT)

    gap     = gaps [(U, 10), (D, 10), (L, 10), (R, 10)]
    withTitles l = noFrillsDeco shrinkText myTheme (desktopLayoutModifiers l)
    -- noTitles l = desktopLayoutModifiers l

---
--- Layouts }}
---

myManageHook = composeAll
  [ className =? "Gimp" --> doFloat
  , className =? "Eclipse" --> doFloat
  , className =? "renpy.py" --> doFloat
  , composeOne [isFullscreen -?> doFullFloat]

  , composeOne
    [ transience
    , className =? "Firefox" -?> doF (W.shift "web")
    , className =? "mikutter" -?> doF (W.shift "web")
    , className =? "Pidgin" -?> doF (W.shift "im")
    ]
  ]

myStartupHook :: X()
myStartupHook = do spawn "fcitx"
                   spawn "killall -u root trayer-srg trayer-srg --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x262626 --heighttype pixel --height 23"
                   spawn "feh --bg-fill ~/.awesomebg"
                   spawn "killall -u root xwrits && xwrits +idle=2 +finger +clock +breakclock +top +mouse t=37 b=3 max=7 +multiply=:7 after=7 b=5 max=77 +multiply=:.07 flash=:.07"
                   spawn "/usr/bin/synergys -f -c /root/.synergy.conf"

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
    layoutHook         = myLayout,
    manageHook         = manageDocks <+> myManageHook,
    startupHook        = myStartupHook,
    logHook            = dynamicLogWithPP xmobarPP
                         { ppOutput = hPutStrLn xmproc
                         , ppTitle = xmobarColor "#1fe0f7" "" . shorten 50
                         }
    }

  xmonad config
