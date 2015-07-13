import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops

import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import qualified Data.Map as M
  
import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowNavigation

import qualified XMonad.Core as XMonad
    (normalBorderColor,focusedBorderColor)

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ICCCMFocus

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
  
myConfig = ewmh desktopConfig {
            modMask = mod4Mask,
            keys = myKeys,
            terminal = "gnome-terminal",
            workspaces = myWorkspaces,
	    manageHook = myManageHook <+> manageHook desktopConfig,
            layoutHook = mylayoutHook,
            startupHook = startup,
	    logHook = takeTopFocus,
    	    XMonad.focusedBorderColor = "white",
	    XMonad.normalBorderColor = "#000D2A"
        } 

myWorkspaces = ["1:web","2","3","4","5","6","7:music","8:chat","9:mail"]
                    
mylayoutHook =  smartBorders(tiled) ||| noBorders (Full) 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

startup :: X ()
startup = do
          -- spawn "feh --bg-scale ~/desktop.png"
          spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut false  --expand true --width 10 --transparent true --alpha 0 --tint 0x000D2A --height 32"
	  spawn "/var/lib/dropbox/.dropbox-dist/dropboxd"
	  spawn "xfce4-power-manager"
	  spawn "synapse -s"
          
-- http://www.haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#Rebinding_the_mod_key_.28Alt_conflicts_with_other_apps.3B_I_want_the_____key.21.29

 
myKeys x  = M.union (M.fromList (newKeys x)) (keys defaultConfig x)
 
newKeys conf@(XConfig {XMonad.modMask = modm}) = [
--      ((modm, xK_o), spawn "synapse")
      ((modm,                 xK_Right), sendMessage $ Go R)
    , ((modm,                 xK_Left ), sendMessage $ Go L)
    , ((modm,                 xK_Up   ), sendMessage $ Go U)
    , ((modm,                 xK_Down ), sendMessage $ Go D)
    , ((modm .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((modm .|. controlMask, xK_Left ), sendMessage $ Swap L)
    , ((modm .|. controlMask, xK_Up   ), sendMessage $ Swap U)
    , ((modm .|. controlMask, xK_Down ), sendMessage $ Swap D)
  ]

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what's being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myManageHook = composeAll [title =? "Gajim" --> doF (W.shift "8:chat")
                          ,className =? "Xfce4-notifyd" --> doIgnore
			  ,resource =? "Do" -->doIgnore                          
                          ]

