-- if Hammerspoon is not running, the mech keyboard will fire mouse keys 4 to 7 (Hammerspoon turns this into 3 to 6, don't know why...). This is probably fine.

layerbar = hs.menubar.new()
layerbar:setTitle("🙂")

layerchange = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(event)
	if event:getButtonState(3) then
		layerbar:setTitle("BASE")
		return false
		
	elseif event:getButtonState(4) then
		layerbar:setTitle("SYM & NAV")
		return false
	elseif event:getButtonState(5) then
		layerbar:setTitle("NUM")
		return false
	elseif event:getButtonState(6) then
		layerbar:setTitle("MOUSE & CONTROLS")
		return false	
	else
		return false
	end
end)

layerchange:start()