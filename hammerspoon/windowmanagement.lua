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

screenPositions.top = {
 x = 0, y = 0,
 w = 6, h = 2
}

screenPositions.bottom = {
 x = 0, y = 2,
 w = 6, h = 2
}
local flagA
-- local flagB

hs.hotkey.bind(reimod, "i", function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.top)
end)

hs.hotkey.bind(reimod, "k", function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.bottom)
end)

hs.hotkey.bind(reimod, "j", function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.left)
end)

hs.hotkey.bind(reimod, "l", function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.right)
end)

hs.hotkey.bind(reimod, "o", function()
	window = hs.window.focusedWindow()
	if flagB ~= 'full' then
		grid.set(window, screenPositions.full)
		flagB = 'full'
	else
		grid.set(window, screenPositions.mid)
		flagB = 'mid'
	end
end)

-- Move window to next display and resize relatively
hs.hotkey.bind(reimod, 'u', function()
 window = hs.window.focusedWindow()
 local screen = window:screen()
 -- compute the unitRect of the focused window relative to the current screen
 -- and move the window to the next screen setting the same unitRect 
 window:move(window:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)