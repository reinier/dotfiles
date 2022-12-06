local secrets = require('secrets')
secrets.start('.secrets.json')

-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

hyperkey = { "ctrl", "alt", "shift", "cmd" }
mehkey = { "ctrl", "alt", "shift" }

reimod = mehkey

require('ergomouse')
-- require('hammerbrowser')
require('showkeymap')
-- require('windowmanagement')

hsImage = hs.loadSpoon('FadeLogo')
hsImage:start()
