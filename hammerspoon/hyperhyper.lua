-- HYPER HYPER leader key
-- Press Hyper + h to go into HYPER HYPER mode
hyperhyper = hs.hotkey.modal.new(hyperkey, "h")

function hyperhyper:entered() layerbar:setTitle("HYPER HYPER") end
function hyperhyper:exited()  layerbar:setTitle("BASE")  end

hyperhyper:bind({}, 'q', function() hyperhyper:exit() end)

-- GRID (inspiration: https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888)

hs.window.animationDuration = 0
local grid = require "hs.grid"

grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDHEIGHT = 4
grid.GRIDWIDTH = 6

--	Set window
local screenPositions = {}
screenPositions.left = {
	x = 0, y = 0,
	w = 3, h = 4
}

screenPositions.right = {
	x = 3, y = 0,
	w = 3, h = 4
}

screenPositions.full = {
	x = 0, y = 0,
	w = 6, h = 4
}

screenPositions.mid = {
	x = 1, y = 0.5,
	w = 4, h = 3
}

hyperhyper:bind('', 'j', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.left)
	hyperhyper:exit()
end)

hyperhyper:bind({}, 'l', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.right)
	hyperhyper:exit()
end)

hyperhyper:bind({}, 'i', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.full)
	hyperhyper:exit()
end)

hyperhyper:bind({}, 'k', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.mid)
	hyperhyper:exit()
end)

-- Move window to next display and resize relatively
hyperhyper:bind({}, 'o', function()
	window = hs.window.focusedWindow()
	local screen = window:screen()
	-- compute the unitRect of the focused window relative to the current screen
	-- and move the window to the next screen setting the same unitRect 
	window:move(window:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
	hyperhyper:exit()
end)

 
-- Get the front most page title and url from Safari and Chrome

-- local chrome = {}
-- local saf = {}
-- 
-- local as = hs.applescript
-- 
-- local function tell(cmd)
-- 	local _cmd = 'tell application "Google Chrome" to ' .. cmd
-- 	local _ok, result = as.applescript(_cmd)
-- 	return result
-- end
-- 
-- function chrome.copyUrl()
-- 	local app = hs.application.applicationsForBundleID('com.google.Chrome')[1]
-- 	if app ~= nil then
-- 		local url = tell('tell window 1 to URL of active tab')
-- 	if url ~= 'chrome://newtab/' then
-- 		hs.alert.show('Copied: '..url)
-- 		hs.pasteboard.setContents(url)
-- 	end
-- 	end
-- end
-- 
-- function saf.copyUrl()
-- 	local app = hs.application.applicationsForBundleID("com.apple.Safari")[1]
-- 	if app ~= nil then
-- 		local stat, data = hs.applescript('tell application "Safari" to get {URL, name} of current tab of window 1')
-- 	if url ~= '' then
-- 		local theLink = "[" .. data[2] .. "](" .. data[1] .. ")"
-- 		-- hs.alert.show(theLink)
-- 		hs.notify.new({title="Link copied", informativeText=theLink}):send()
-- 		hs.pasteboard.setContents(theLink)
-- 	end
-- 	end
-- end
-- 
-- hyperhyper:bind({}, '.', function()
-- 	saf.copyUrl()
-- 	hyperhyper:exit()
-- end)