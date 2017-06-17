--[[--
  Use this file to specify **System** preferences.
  Review [examples](+D:\Applications\ZeroBraneStudio\cfg\user-sample.lua) or check [online documentation](http://studio.zerobrane.com/documentation.html) for details.
--]]--
editor.fontname = "Source Code Pro"
editor.showfncall = false
editor.tabwidth = 4
editor.usetabs = true
editor.autotabs = true
editor.usewrap = false
editor.smartindent = true

-- updated shortcuts to use them as of v1.20
keymap[ID.STARTDEBUG]       = "F5"
keymap[ID.STOPDEBUG]        = "Shift-F5"
keymap[ID.BREAKPOINTTOGGLE] = "F9"
keymap[ID.STEP]             = "F11"
keymap[ID.STEPOVER]         = "F10"
keymap[ID.STEPOUT]          = "Shift-F11"