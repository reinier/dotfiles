local secrets = require('secrets')
secrets.start('.secrets.json')

-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

hyperkey = { "ctrl", "alt", "shift", "cmd" }
mehkey = { "ctrl", "alt", "shift" }

reimod = mehkey

require('showkeymap')
hs.hotkey.bind(reimod, "=", toggleKeymap)
hs.hotkey.bind('', "F18", toggleKeymap)

menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

hsImage = hs.loadSpoon('FadeLogo')
hsImage:start()

-- Initialize directory watchers
local directoryWatchers = require('functions.directory-watchers')
directoryWatchers.start()
