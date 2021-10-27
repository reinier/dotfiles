-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

local minihyper = { "alt", "shift", "cmd" }

require('ergomouse')
require('layerdisplay')
require('hyperconfig')
-- require('hammerbrowser')

spoon.SpoonInstall:andUse('Emojis', {
	hotkeys = {
		toggle = { minihyper, "e" },
	}
})

spoon.SpoonInstall:andUse('KSheet', {
	hotkeys = {
		toggle = { minihyper, "/" },
	}
})

spoon.SpoonInstall:andUse('Cherry', {
	hotkeys = {
		start = { minihyper, "p" },
	}
})