-- Hyper config and efficient window management

hyper = require('hyper')

-- HYPER
config = {}
config.applications = {
	['com.runningwithcrayons.Alfred'] = {
		bundleID = 'com.runningwithcrayons.Alfred',
		local_bindings = { 'c', 'space' }
	},
	['com.apple.finder'] = {
		bundleID = 'com.apple.finder',
		hyper_key = 'r'
	},
	['com.agiletortoise.Drafts-OSX'] = {
		bundleID = 'com.agiletortoise.Drafts-OSX',
		hyper_key = 'd',
		tags = { '#review', '#writing', '#research' },
		local_bindings = { 'x', ';' }
	},
	['com.stairways.keyboardmaestro.engine'] = {
		bundleID = 'com.stairways.keyboardmaestro.engine',
		local_bindings = { 'a', 's', 't', 'm' }
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
		hyper_key = 'f'
	},
	["com.agilebits.onepassword7"] = {
		bundleID = "com.agilebits.onepassword7",
		name = "1Password",
		hyper_key = "p",
	},
}

hyper.start(config)

-- GRID (inspiration: https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888)
hs.window.animationDuration=0.2
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

-- local log = hs.logger.new('mymodule','debug')
-- log.i(hs.inspect(screenPositions))

hyper:bind({}, 'j', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.left)
end)

hyper:bind({}, 'l', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.right)
end)

hyper:bind({}, 'i', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.full)

end)

hyper:bind({}, 'k', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.mid)
end)