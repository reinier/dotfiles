-- if Hammerspoon is not running, the mech keyboard will fire the CTRL+F keys on every layer change. This results in a beep from the Mac.

layerbar = hs.menubar.new()
layerbar:setTitle("🙂")

-- intercept QMK keys to change the indicated layer
hs.hotkey.bind({'ctrl'}, 'f13', function()
	layerbar:setTitle("BASE")
end)

hs.hotkey.bind({'ctrl'}, 'f14', function()
	layerbar:setTitle("CHAR")
end)

hs.hotkey.bind({'ctrl'}, 'f15', function()
	layerbar:setTitle("NAV")
end)

hs.hotkey.bind({'ctrl'}, 'f16', function()
	layerbar:setTitle("NUM")
end)

hs.hotkey.bind({'ctrl'}, 'f17', function()
	layerbar:setTitle("MOUSE")
end)