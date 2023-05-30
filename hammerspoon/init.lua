local secrets = require('secrets')
secrets.start('.secrets.json')

-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

hyperkey = { "ctrl", "alt", "shift", "cmd" }
mehkey = { "ctrl", "alt", "shift" }

reimod = mehkey

require('ergomouse')
require('showkeymap')
-- require('leader')
menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()


hsImage = hs.loadSpoon('FadeLogo')
hsImage:start()

-- ~/.hammerspoon/keyboard/yabai.lua
-- Send message(s) to a running instance of yabai.
local function yabai(commands)
	for _, cmd in ipairs(commands) do
		os.execute("/opt/homebrew/bin/yabai -m " .. cmd)
	end
end

local function yabaimod(key, commands)
	hs.hotkey.bind(mehkey, key, function()
		yabai(commands)
	end)
end

yabaimod("j", { "window --focus next" })
yabaimod("l", { "window --focus prev" })
yabaimod("u", { "display --focus 1" })
yabaimod("i", { "display --focus 2" })
yabaimod("o", { "display --focus 3" })


-- alpha
-- yabaimod("f", { "window --toggle zoom-fullscreen" })
-- yabaimod("l", { "space --focus recent" })
-- yabaimod("m", { "space --toggle mission-control" })
-- yabaimod("p", { "window --toggle pip" })
-- yabaimod("g", { "space --toggle padding", "space --toggle gap" })
-- yabaimod("r", { "space --rotate 90" })
-- yabaimod("t", { "window --toggle float", "window --grid 4:4:1:1:2:2" })

yabaimod("y", { "config layout bsp" })
yabaimod("z", { "config layout float" })
-- yabaimod("tab", { "space --focus recent" })