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