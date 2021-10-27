require('ergomouse')
require('layerdisplay')
require('hyperconfig')
-- require('hammerbrowser')

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse('Emojis', {
	hotkeys = {
		toggle = { { "alt", "shift", "cmd" }, "e" },
	}
})

cherry = hs.loadSpoon("Cherry")
-- emojis = hs.loadSpoon("Emojis")

cherry:bindHotkeys({
	start = {{ "alt", "shift", "cmd" }, "p"}
})

-- emojis:bindHotkeys({
-- 	toggle = {{ "alt", "shift", "cmd" }, "e"}
-- })