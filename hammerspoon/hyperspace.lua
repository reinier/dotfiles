-- Meh reserved:

-- C, T, A - Keyboard Maestro
-- H - Hyperhammer
-- M - MenuAnywhere

-- MehSpace is my Hammerspoon chooser to do stuff
-- Initiate all the audio

polybto = hs.audiodevice.findOutputByName('Poly BT600')
polybti = hs.audiodevice.findInputByName('Poly BT600')

polybtusbo = hs.audiodevice.findOutputByName('Poly Sync 20-M')
polybtusbi = hs.audiodevice.findInputByName('Poly Sync 20-M')

macbookprospeakers = hs.audiodevice.findOutputByName('MacBook Pro Speakers')
macbookpromic = hs.audiodevice.findInputByName('MacBook Pro Microphone')

cakewalk = hs.audiodevice.findOutputByName('Elgato Dock')

airpodsmaxo = hs.audiodevice.findOutputByName('AirPods Max van Reinier')
airpodsmaxi = hs.audiodevice.findInputByName('AirPods Max van Reinier')

-- log = hs.logger.new('mymodule','debug')
-- log.i(hs.inspect(hs.audiodevice.allDevices()))

local chooserActions = {
	{
		["text"] = "MacBook Pro",
		["subText"] = "Input and output audio to MacBook Pro",
		["val"] = "macbookpro"
	},
	{
		["text"] = "Cakewalk",
		["subText"] = "Output audio to Cakewalk by Elgato Dock",
		["val"] = "elgato"
	},
	{
		["text"] = "Poly USB",
		["subText"] = "Input and output audio to Poly over USB",
		["val"] = "polyusb"
	},
	{
		["text"] = "AirPods Max",
		["subText"] = "Input and output audio to AirPods Max",
		["val"] = "airpodsmax"
	},
	{
		["text"] = "Poly BT",
		["subText"] = "Input and output audio to Poly over BT",
		["val"] = "polybt"
	},
	{
		["text"] = "Set Safari as default",
		["subText"] = "Set Safari as default browser in Hammerspoon",
		["val"] = "safari"
	},
	{
		["text"] = "Set Chrome as default",
		["subText"] = "Set Chrome as default browser in Hammerspoon",
		["val"] = "chrome"
	},
}

local chooser
choseAction = function(action)
	-- log.i(hs.inspect(action));
	
	hs.alert.show(action['subText'])
	
	if action['val'] == "macbookpro" then
		if (macbookprospeakers and macbookpromic) then
			macbookprospeakers:setDefaultOutputDevice()
			macbookpromic:setDefaultInputDevice()
			hs.alert.show('✅')
		else
			hs.alert.show('❌ not found')
		end
	
	elseif action['val'] == "polyusb" then
		if (polybtusbo and polybtusbi) then
			polybtusbo:setDefaultOutputDevice()
			polybtusbi:setDefaultInputDevice()
			hs.alert.show('✅')
		else
			hs.alert.show('❌ not found')
		end
	
	elseif action['val'] == "polybt" then
		if (polybto and polybti) then
			polybto:setDefaultOutputDevice()
			polybti:setDefaultInputDevice()
			hs.alert.show('✅')
		else
			hs.alert.show('❌ not found')
		end
	
	elseif action['val'] == "elgato" then
		if (cakewalk) then
			cakewalk:setDefaultOutputDevice()
			hs.alert.show('✅')
		else
			hs.alert.show('❌ not found')
		end
		
	elseif action['val'] == "airpodsmax" then
		if (airpodsmaxi and airpodsmaxo) then
			airpodsmaxo:setDefaultOutputDevice()
			airpodsmaxi:setDefaultInputDevice()
			hs.alert.show('✅')
		else
			hs.alert.show('❌ not found')
		end
	
	-- See hammerbrowser.lua for variables 
	
	elseif action['val'] == "safari" then
		hs.alert.show('✅')
		spoon.URLDispatcher.default_handler = safariBrowser
	
	elseif action['val'] == "chrome" then
		hs.alert.show('✅')
		spoon.URLDispatcher.default_handler = chromeBrowser
		
	else
		hs.alert.show('❌ not found')
	end
end

chooser = hs.chooser.new(choseAction)
chooser:choices(chooserActions)

hs.hotkey.bind(hyperkey, "h", function()
	chooser:show()
end)

-- Meh keybindings for window management

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

hs.hotkey.bind(hyperkey, "j", function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.left)
end)

hs.hotkey.bind(hyperkey, 'l', function()
 window = hs.window.focusedWindow()
 grid.set(window, screenPositions.right)
end)

hs.hotkey.bind(hyperkey, 'i', function()
 window = hs.window.focusedWindow()
 grid.set(window, screenPositions.full)
end)

hs.hotkey.bind(hyperkey, 'k', function()
 window = hs.window.focusedWindow()
 grid.set(window, screenPositions.mid)
end)

-- Move window to next display and resize relatively
hs.hotkey.bind(hyperkey, 'o', function()
 window = hs.window.focusedWindow()
 local screen = window:screen()
 -- compute the unitRect of the focused window relative to the current screen
 -- and move the window to the next screen setting the same unitRect 
 window:move(window:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)