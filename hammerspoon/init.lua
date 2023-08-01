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

menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

hsImage = hs.loadSpoon('FadeLogo')
hsImage:start()

-- Bind alt-space to add an inbox item with Siri Shortcut
hs.hotkey.bind({"alt"}, "space", function()
    hs.shortcuts.run("Add item")
end)