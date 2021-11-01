-- if Hammerspoon is not running, the mech keyboard will fire the CTRL+F keys on every layer change. This results in a beep from the Mac.

layerbar = hs.menubar.new()
layerbar:setTitle("🙂")

-- intercept QMK keys to change the indicated layer
hs.hotkey.bind({'shift', 'alt'}, 'f16', function()
	layerbar:setTitle("BASE")
end)

hs.hotkey.bind({'shift', 'alt'}, 'f17', function()
	layerbar:setTitle("SYM")
end)

hs.hotkey.bind({'shift', 'alt'}, 'f18', function()
	layerbar:setTitle("NUMPAD")
end)

hs.hotkey.bind({'shift', 'alt'}, 'f19', function()
	layerbar:setTitle("NAVIGATION")
end)