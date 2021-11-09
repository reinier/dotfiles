local secrets = require('secrets')
	secrets.start('.secrets.json')

-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

hyperkey = { "ctrl", "alt", "shift", "cmd" }

require('ergomouse')
require('hammerbrowser')
require('hyperhammer')
require('hypers')
