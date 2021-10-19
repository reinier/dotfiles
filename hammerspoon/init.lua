hs.loadSpoon('Tiler')

-- https://github.com/tekezo/Karabiner/issues/814
-- https://savourytimes.com/smooth-scrolling-with-greatest-trackball-mx-ergo/
-- HANDLE SCROLLING WITH MOUSE BUTTON PRESSED
local scrollMouseButton = 2
local deferred = false

overrideOtherMouseDown =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseDown},
  function(e)
	deferred = true
	return true
  end
)

overrideOtherMouseUp =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseUp},
  function(e)
	if (deferred) then
	  overrideOtherMouseDown:stop()
	  overrideOtherMouseUp:stop()
	  hs.eventtap.rightClick(e:location(), pressedMouseButton)
	  overrideOtherMouseDown:start()
	  overrideOtherMouseUp:start()
	  return true
	end
	return false
  end
)

local oldmousepos = {}
local scrollmult = -2 -- negative multiplier makes mouse work like traditional scrollwheel, for macOS, use positive number.

dragOtherToScroll =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseDragged},
  function(e)
	deferred = false
	oldmousepos = hs.mouse.absolutePosition()
	local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
	local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
	local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult}, {}, "pixel")
	-- put the mouse back
	hs.mouse.absolutePosition(oldmousepos)
	return true, {scroll}
  end
)

overrideOtherMouseDown:start()
overrideOtherMouseUp:start()
dragOtherToScroll:start()

-- Show keyboard layer

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

-- HYPER
config = {}
config.applications = {
	['com.runningwithcrayons.Alfred'] = {
		bundleID = 'com.runningwithcrayons.Alfred',
		local_bindings = { 'c', 'space' }
	},
	['com.apple.finder'] = {
		bundleID = 'com.apple.finder',
		hyper_key = 'f'
	},
	['com.agiletortoise.Drafts-OSX'] = {
		bundleID = 'com.agiletortoise.Drafts-OSX',
		hyper_key = 'd',
		tags = { '#review', '#writing', '#research' },
		local_bindings = { 'x', ';' }
	},
	['com.stairways.keyboardmaestro.engine'] = {
		bundleID = 'com.stairways.keyboardmaestro.engine',
		local_bindings = { 'a', 's' }
	},
	['com.google.Chrome'] = {
		bundleID = 'com.google.Chrome',
		hyper_key = 'b'
	},
	['com.apple.Safari'] = {
		bundleID = 'com.apple.Safari',
		hyper_key = 'g'
	},
	['com.omnigroup.OmniFocus3.MacAppStore'] = {
		bundleID = 'com.omnigroup.OmniFocus3.MacAppStore',
		hyper_key = 't'
	},
	
}

hyper = require('hyper')
hyper.start(config)

-- GRID (inspiration: https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888)
hs.window.animationDuration=0.2
local grid = require "hs.grid"

grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDHEIGHT = 4
grid.GRIDWIDTH = 6

--	Set window
local screenPositions       = {}
screenPositions.left        = {
	x = 0, y = 0,
	w = 3, h = 4
}

screenPositions.right        = {
	x = 3, y = 0,
	w = 3, h = 4
}

screenPositions.full        = {
	x = 0, y = 0,
	w = 6, h = 4
}

screenPositions.mid        = {
	x = 1, y = 0.5,
	w = 4, h = 3
}

-- local log = hs.logger.new('mymodule','debug')
-- log.i(hs.inspect(screenPositions))

hyper:bind({'cmd'}, 'j', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.left)
end)

hyper:bind({'cmd'}, 'l', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.right)
end)

hyper:bind({'cmd'}, 'i', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.full)

end)

hyper:bind({'cmd'}, 'k', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.mid)
end)

-- Move Window
hyper:bind({'alt'}, 'i', grid.pushWindowDown)
hyper:bind({'alt'}, 'k', grid.pushWindowUp)
hyper:bind({'alt'}, 'j', grid.pushWindowLeft)
hyper:bind({'alt'}, 'l', grid.pushWindowRight)
-- 
-- -- Resize Window
hyper:bind({'shift'}, 'i', grid.resizeWindowShorter)
hyper:bind({'shift'}, 'k', grid.resizeWindowTaller)
hyper:bind({'shift'}, 'l', grid.resizeWindowWider)
hyper:bind({'shift'}, 'j', grid.resizeWindowThinner)


