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



hyperhyper:bind({}, 's', function()
	hs.spotify.displayCurrentTrack()
	hyperhyper:exit()
end)

hyperhyper:bind({}, 'd', function()
	hs.spotify.playpause()
	hyperhyper:exit()
end)

hyperhyper:bind({}, 'f', function()
	hs.spotify.next()
	hyperhyper:exit()
end)

hyperhyper:bind({}, 'a', function()
	hs.spotify.previous()
	hyperhyper:exit()
end)

-- https://github.com/levinine/hammerspoon-config/blob/f0ea4e358b62c67e436d97aa3b2e2516accccd58/audio-watcher.lua

polybt = hs.audiodevice.findOutputByName('Poly BT600')
cakewalk = hs.audiodevice.findOutputByName('Elgato Dock')
airpodsmax = hs.audiodevice.findOutputByName('AirPods Max van Reinier')
macbookprospeakers = hs.audiodevice.findOutputByName('MacBook Pro Speakers')
macbookpromic = hs.audiodevice.findInputByName('MacBook Pro Microphone')

-- local log = hs.logger.new('mymodule','debug')
-- log.i(hs.inspect(hs.audiodevice.allDevices()))

-- MacBook Pro Microphone
-- MacBook Pro Speakers

-- { <userdata 1> -- hs.audiodevice: Elgato Dock (0x600007f29ae8), <userdata 2> -- hs.audiodevice: Elgato Dock (0x600007f29768), <userdata 3> -- hs.audiodevice: LG UltraFine Display Audio (0x600007f2a798), <userdata 4> -- hs.audiodevice: LG UltraFine Display Audio (0x600007f2a098), <userdata 5> -- hs.audiodevice: Poly BT600 (0x600007f29c38), <userdata 6> -- hs.audiodevice: Poly BT600 (0x600007f29848), <userdata 7> -- hs.audiodevice: MacBook Pro Microphone (0x600007f29ca8), <userdata 8> -- hs.audiodevice: MacBook Pro Speakers (0x600007f29928) }

-- Set audio to cake output
hyperhyper:bind({}, 'e', function()
	-- External Headphones
	cakewalk:setDefaultOutputDevice()
	hs.alert.show('Output: Cakewalk')
	hyperhyper:exit()
end)

-- Set audio to poly output and input
hyperhyper:bind({}, 'r', function()
	-- Poly BT600
	polybt:setDefaultOutputDevice()
	polybt:setDefaultInputDevice()
	hs.alert.show('Output and input: Poly')
	hyperhyper:exit()
end)

-- MacBook Prow
hyperhyper:bind({}, 't', function()
	macbookprospeakers:setDefaultOutputDevice()
	macbookpromic:setDefaultInputDevice()
	hs.alert.show('Output and input: MacBook Pro')
	hyperhyper:exit()
end)

-- Mute
hyperhyper:bind({}, 'x', function()
	local current = hs.audiodevice.defaultOutputDevice()
	current:setVolume(0)
	hs.alert.show('Mute')
	hyperhyper:exit()
end)

-- Decrease volume
hyperhyper:bind({}, 'c', function()
	local current = hs.audiodevice.defaultOutputDevice()
	local currVolume = current:volume()
	current:setVolume(currVolume - 10)
	hs.alert.show('-- ' .. currVolume - 10)
	-- hyperhyper:exit()
end)

-- Increase volume
hyperhyper:bind({}, 'v', function()
	local current = hs.audiodevice.defaultOutputDevice()
	local currVolume = current:volume()
	current:setVolume(currVolume + 10)
	hs.alert.show('++ ' .. currVolume + 10)
	-- hyperhyper:exit()
end)



-- Get the front most page title and url from Safari and Chrome

local chrome = {}
local saf = {}

local as = hs.applescript

local function tell(cmd)
	local _cmd = 'tell application "Google Chrome" to ' .. cmd
	local _ok, result = as.applescript(_cmd)
	return result
end

function chrome.copyUrl()
	local app = hs.application.applicationsForBundleID('com.google.Chrome')[1]
	if app ~= nil then
		local url = tell('tell window 1 to URL of active tab')
	if url ~= 'chrome://newtab/' then
		hs.alert.show('Copied: '..url)
		hs.pasteboard.setContents(url)
	end
	end
end

function saf.copyUrl()
	local app = hs.application.applicationsForBundleID("com.apple.Safari")[1]
	if app ~= nil then
		local stat, data = hs.applescript('tell application "Safari" to get {URL, name} of current tab of window 1')
	if url ~= '' then
		local theLink = "[" .. data[2] .. "](" .. data[1] .. ")"
		-- hs.alert.show(theLink)
		hs.notify.new({title="Link copied", informativeText=theLink}):send()
		hs.pasteboard.setContents(theLink)
	end
	end
end

hyperhyper:bind({}, '.', function()
	saf.copyUrl()
	hyperhyper:exit()
end)