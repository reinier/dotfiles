-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

local minihyper = { "alt", "shift", "cmd" }

require('ergomouse')
require('layerdisplay')
require('hyperconfig')
require('hammerbrowser')

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

spoon.SpoonInstall:andUse("Seal",
 {
	 hotkeys = { show = { {"alt"}, "space" } },
	 fn = function(s)
		 s:loadPlugins({"apps", "calc"})
		 -- https://www.hammerspoon.org/Spoons/Seal.plugins.useractions.html
		 -- s.plugins.useractions.actions =
			--  {
			-- 		 ["Hammerspoon docs webpage"] = {
						-- 	url = "http://hammerspoon.org/docs/",
						-- 	icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
						-- 	hotkey = { hyper, "h" }
					 -- },
			--  }
		 s:refreshAllCommands()
	 end,
	 start = true,
 }
)