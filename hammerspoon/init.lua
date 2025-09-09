local secrets = require('secrets')
secrets.start('.secrets.json')

-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
local Install=spoon.SpoonInstall

hyperkey = { "ctrl", "alt", "shift", "cmd" }
mehkey = { "ctrl", "alt", "shift" }

reimod = mehkey

require('showkeymap')
hs.hotkey.bind(reimod, "=", toggleKeymap)
hs.hotkey.bind('', "F18", toggleKeymap)

Install:installSpoonFromZipURL('https://github.com/reinier/MenuHammer/raw/master/Spoons/MenuHammer.spoon.zip')
local menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

-- Initialize directory watchers
local directoryWatchers = require('functions.directory-watchers')
directoryWatchers.start()

-- Show reload confirmation message
hs.alert.show("✅ Hammerspoon loaded", 2)
