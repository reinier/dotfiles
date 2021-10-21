-- Hyper config and efficient window management

hyper = require('hyper')

-- HYPER
config = {}
config.applications = {
	['com.runningwithcrayons.Alfred'] = {
		bundleID = 'com.runningwithcrayons.Alfred',
		local_bindings = { 'c' }
	},
	['com.apple.finder'] = {
		bundleID = 'com.apple.finder',
		hyper_key = 'r'
	},
	['com.agiletortoise.Drafts-OSX'] = {
		bundleID = 'com.agiletortoise.Drafts-OSX',
		hyper_key = 'd'
	},
	['com.stairways.keyboardmaestro.engine'] = {
		bundleID = 'com.stairways.keyboardmaestro.engine',
		local_bindings = { 'a', 's', 't', 'm', 'k' }
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
	["com.panic.nova"] = {
		bundleID = "com.panic.nova",
		name = "Nova",
		hyper_key = "e",
	},
}

hyper.start(config)

hyper:bind({}, 'o', function()
	hs.hints.windowHints()
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
		hs.alert.show('Copied: ' .. "[" .. data[2] .. "](" .. data[1] .. ")")
		hs.pasteboard.setContents("[" .. data[2] .. "](" .. data[1] .. ")")
	end
	end
end

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

local log = hs.logger.new('mymodule','debug')
-- log.i(hs.inspect(screenPositions))

-- HYPER SPACE

local hyperspacemode = hs.hotkey.modal.new()

hyper:bind({}, 'space', nil, function()
	hyperspacemode:enter()
	layerbar:setTitle("HYPER SPACE")
end)

exithyperspacemode = function()
	layerbar:setTitle("BASE")
	hyperspacemode:exit()
end

hyperspacemode:bind({}, 'space', function()
	exithyperspacemode()
end)

hyperspacemode:bind({}, '.', function()
	saf.copyUrl()
	exithyperspacemode()
end)

hyperspacemode:bind('', 'j', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.left)
	exithyperspacemode()
end)

hyperspacemode:bind({}, 'l', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.right)
	exithyperspacemode()
end)

hyperspacemode:bind({}, 'i', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.full)
  exithyperspacemode()
end)

hyperspacemode:bind({}, 'k', function()
	window = hs.window.focusedWindow()
	grid.set(window, screenPositions.mid)
	exithyperspacemode()
end)

hyperspacemode:bind({}, 's', function()
	hs.spotify.displayCurrentTrack()
	exithyperspacemode()
end)

hyperspacemode:bind({}, 'd', function()
	hs.spotify.playpause()
	exithyperspacemode()
end)

hyperspacemode:bind({}, 'f', function()
	hs.spotify.next()
	exithyperspacemode()
end)

hyperspacemode:bind({}, 'a', function()
	hs.spotify.previous()
	exithyperspacemode()
end)


-- https://github.com/levinine/hammerspoon-config/blob/f0ea4e358b62c67e436d97aa3b2e2516accccd58/audio-watcher.lua

polybt = hs.audiodevice.findOutputByName('Poly BT600')
cakewalk = hs.audiodevice.findOutputByName('External Headphones')
airpodsmax = hs.audiodevice.findOutputByName('AirPods Max van Reinier')

-- Set audio to cake output
hyperspacemode:bind({}, 'e', function()
	-- External Headphones
	cakewalk:setDefaultOutputDevice()
	hs.alert.show('Output: Cakewalk')
	exithyperspacemode()
end)

-- Set audio to poly output and input
hyperspacemode:bind({}, 'r', function()
	-- Poly BT600
	polybt:setDefaultOutputDevice()
	polybt:setDefaultInputDevice()
	hs.alert.show('Output and input: Poly')
	exithyperspacemode()
end)

-- AirPods Max van Reinier
hyperspacemode:bind({}, 't', function()
	airpodsmax:setDefaultOutputDevice()
	airpodsmax:setDefaultInputDevice()
	hs.alert.show('Output and input: Airpods Max')
	exithyperspacemode()
end)



-- Mute
hyperspacemode:bind({}, 'x', function()
	local current = hs.audiodevice.defaultOutputDevice()
	current:setVolume(0)
	hs.alert.show('Mute')
	exithyperspacemode()
end)

-- Decrease volume
hyperspacemode:bind({}, 'c', function()
	local current = hs.audiodevice.defaultOutputDevice()
	local currVolume = current:volume()
	current:setVolume(currVolume - 10)
	hs.alert.show('-- ' .. currVolume - 10)
	-- exithyperspacemode()
end)

-- Increase volume
hyperspacemode:bind({}, 'v', function()
	local current = hs.audiodevice.defaultOutputDevice()
	local currVolume = current:volume()
	current:setVolume(currVolume + 10)
	hs.alert.show('++ ' .. currVolume + 10)
	-- exithyperspacemode()
end)