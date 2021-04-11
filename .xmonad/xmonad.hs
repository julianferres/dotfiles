-- Data
import Data.Monoid
import Data.Tree
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)
import XMonad
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (nextScreen, prevScreen, nextWS, prevWS, moveTo, WSType(NonEmptyWS), Direction1D(Next,Prev))
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.UpdatePointer

-- Hooks
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docksEventHook, manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.InsertPosition

-- Layouts
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.MultiToggle ((??), EOT (EOT), mkToggle, single)
import qualified XMonad.Layout.MultiToggle as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- Utilities
import XMonad.Util.EZConfig(additionalKeysP, removeKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce

myModMask = mod4Mask :: KeyMask

myTerminal = "alacritty" :: String

myBorderWidth = 3 :: Dimension

myNormColor = "#292d3e" :: String

myFocusColor = "#c792ea" :: String

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "trayer --edge top  --monitor 0 --widthtype request --heighttype pixel --margin 10 --height 22 --align right --transparent true --alpha 0 --tint 0x292d3e --iconspacing 5 --distance 5 &"
    spawnOnce "/home/julian/.xmonad/autostart.sh &"
    setWMName "LG3D"

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Single window with no gaps
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True


-- Toggle float function
toggleFloat w = windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else (W.float w (W.RationalRect (1/6) (1/6) (4/6) (4/6)) s)) -- x y w h of the window
-- Rational Rect recieve proportion of widht and height of screen where top corner will be, and widht and height of the window itself

-- Layouts definition

tall = renamed [Replace "tall"]
    $ limitWindows 12
    $ mySpacing 2
    $ ResizableTall 1 (3 / 100) (1 / 2) []

monocle = renamed [Replace "monocle"]
    $ mySpacing 2
    $ limitWindows 20 Full

grid = renamed [Replace "grid"]
    $ limitWindows 12
    $ mySpacing 2
    $ mkToggle (single MIRROR)
    $ Grid (16 / 10)

threeCol = renamed [Replace "threeCol"]
    $ limitWindows 7
    $ mySpacing' 2
    $ ThreeCol 1 (3 / 100) (1 / 3)

floats = renamed [Replace "floats"] $ limitWindows 20 simplestFloat

-- Layout hook

myLayoutHook = avoidStruts 
    $ smartBorders
    $ mouseResize
    $ windowArrange
    $ T.toggleLayouts floats
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = 
        tall
        ||| monocle
        ||| threeCol
        ||| grid
        ||| floats

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
    $ ["term", "www", "dev", "misc"]
  where
    clickable l = ["<action=xdotool key super+" ++ show (i) ++ "> " ++ ws ++ "</action>" | (i, ws) <- zip [1 .. 4] l]


-- Manage Hook
--
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces, and the names would very long if using clickable workspaces.
     [ title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     , className =? "Gimp"    --> doShift ( myWorkspaces !! 3 )
     , title =? "Oracle VM VirtualBox Manager"     --> doFloat
     , title =? "Visual Studio Code" --> doShift ( myWorkspaces !! 2) 
     , title =? "Telegram" --> doShift ( myWorkspaces !! 3) 
     , title =? "Discord" --> doShift ( myWorkspaces !! 3) 
     , title =? "JetBrains Toolbox" --> doFloat
     , title =? "Intellij IDEA" --> doShift ( myWorkspaces !! 2) 
     , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 3 )
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     ]



myKeys :: [(String, X ())]
myKeys = 
    [
    ------------------ Window configs ------------------

    -- Move focus to the next window
    ("M-j", windows W.focusDown),
    -- Move focus to the previous window
    ("M-k", windows W.focusUp),
    -- Swap focused window with next window
    ("M-S-j", windows W.swapDown),
    -- Swap focused window with prev window
    ("M-S-k", windows W.swapUp),
    -- Kill window
    ("M-q", kill1),
    -- Kill all windows in workspace
    ("M-S-q", killAll),
    -- Restart xmonad
    ("M-r", spawn "xmonad --recompile; xmonad --restart"),
    -- Suspend system
    ("M-S-C-s", spawn "systemctl suspend"),
    -- Shutdown system
    ("M-S-C-e", spawn "shutdown -h now"),
    -- Reboot
    ("M-S-C-r", spawn "reboot"),
    -- Quit xmonad
    ("M-S-e", io exitSuccess),


    ----------------- Floating windows -----------------

    -- Toggles 'floats' layout
    ("M-t", withFocused toggleFloat),


    -------------------- Workspaces --------------------
    -- Switch focus to next monitor
    ("M-M1-.", nextScreen),
    -- Switch focus to prev monitor
    ("M-M1-,", prevScreen),
    -- Switch focus to next workspace
    ("M-.", nextWS),
    -- Switch focus to prev workspace
    ("M-,", prevWS),
    -- Switch  to next non-empty workspace
    ("M-S-.", moveTo Next NonEmptyWS),
    -- Switch  to prev non-empty workspace
    ("M-S-,", moveTo Prev NonEmptyWS),


    ---------------------- Layouts ----------------------
    -- Switch to next layout
    ("M-<Space>", sendMessage NextLayout),
    -- Switch to first layout
    ("M-S-<Space>", sendMessage FirstLayout),
    -- Toggles noborder/full
    ("M-<Tab>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts),
    -- Toggles noborder
    ("M-S-n", sendMessage $ MT.Toggle NOBORDERS),
    -- Shrink horizontal window widh
    ("M-S-h", sendMessage Shrink),
    -- Expand horizontal window width
    ("M-S-l", sendMessage Expand),
    -- Shrink vertical window width
    ("M-C-j", sendMessage MirrorShrink),
    -- Exoand vertical window width
    ("M-C-k", sendMessage MirrorExpand),
    -- 

    -------------------- App configs --------------------

    -- Menu
    ("M-n", spawn "rofi -show drun"),
    -- Dmenu
    ("M-S-d", spawn "dmenu_run -p 'dmenu' -h 25 -sb '#4A4F68' -nf '#c792ea' -nb '#192d3e' -sf '#c3e88d' -fn 'UbuntuMono Nerd Font:weight=bold:pixelsize=16' -y 4 -x 4 -z 1358"),
    -- Window nav
    ("M-S-m", spawn "rofi -show"),
    -- Browser
    ("M-b", spawn "firefox"),
    -- Text Editor
    ("M-e", spawn "subl"),
    -- Terminal
    ("M-<Return>", spawn myTerminal),
    -- Graphical File explorer
    ("M-f", spawn "nautilus"),
    -- Scrot
    --("M-s", spawn "scrot"),
    ("M-s", spawn "scrot ~/Pictures/%Y-%m-%d_%H-%M-%S_screenshot.png"),

    -- File Explorer dmenufm rofi
    ("M-S-f", spawn "dmenufm"),

    --------------------- Hardware ---------------------

    -- Volume
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle" ),

    -- Brightness
    ("<XF86MonBrightnessUp>", spawn "light -A 5"),
    ("<XF86MonBrightnessDown>", spawn "light -U 5")
    ]

myKeysR :: [String]
myKeysR = ["M-S-q", "M-q"]

main :: IO ()
main = do
    -- Xmobar
    xmobarLaptop <- spawnPipe "xmobar -x 0 ~/.config/xmobar/primary.hs"
    xmobarMonitor <- spawnPipe "xmobar -x 1 ~/.config/xmobar/secondary.hs"
    -- Xmonad
    xmonad $ ewmh def {
        manageHook = (isFullscreen --> doFullFloat) <+> myManageHook <+> manageDocks <+> insertPosition Below Newer,
        handleEventHook = docksEventHook,
        modMask = myModMask,
        terminal = myTerminal,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        workspaces = myWorkspaces,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormColor,
        focusedBorderColor = myFocusColor,
        -- Log hook
        logHook = workspaceHistoryHook <+> dynamicLogWithPP xmobarPP {
            ppOutput = \x -> hPutStrLn xmobarLaptop x >> hPutStrLn xmobarMonitor x,
            -- Current workspace in xmobar
            ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" " ]",
            -- Visible but not current workspace
            ppVisible = xmobarColor "#c3e88d" "",
            -- Hidden workspaces in xmobar
            ppHidden = xmobarColor "#82AAFF" "",
            -- Hidden workspaces (no windows)
            ppHiddenNoWindows = xmobarColor "#c792ea" "",
            -- Title of active window in xmobar
            ppTitle = xmobarColor "#6272a4" "" . shorten 55,
            -- Separators in xmobar
            ppSep = "<fc=#666666> | </fc>",
            -- Urgent workspace
            ppUrgent = xmobarColor "#C45500" "" . wrap "" "!",
            -- Number of windows in current workspace
            ppExtras = [windowCount],
            ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
        } >> updatePointer (0.5, 0.5) (0.5, 0.5) 
    } `removeKeysP` myKeysR `additionalKeysP` myKeys
