local secrets = require('secrets')
	secrets.start('.secrets.json')

-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

hyperkey = { "ctrl", "alt", "shift", "cmd" }
mehkey = { "ctrl", "alt", "shift" }

reimod = mehkey

require('ergomouse')
require('hammerbrowser')
require('hammermodal')
require('windowmanagement')

hsImage = hs.loadSpoon('FadeLogo')
hsImage:start()

showKeymap = function()
	local frame = hs.screen.mainScreen():frame()
	local imgsz = hs.geometry.size(700, 480)
	modalCanvas = hs.canvas.new(frame)
	modalCanvas[1] = {
		type = 'image',
		image = hs.image.imageFromPath('keyboard/keymap.png'),
		frame = {
			 x = (frame.w - imgsz.w) / 2,
			 y = (frame.h - imgsz.h) / 2,
			 w = imgsz.w,
			 h = imgsz.h,
		},
		imageAlpha = 1.0,
	}
	modalCanvas:show(0.1)
end

function hideKeymap()
	 modalCanvas:hide(0.1)
end

showReimod = function()
	local frame = hs.screen.mainScreen():frame()
	local imgsz = hs.geometry.size(700, 480)
	modalCanvas = hs.canvas.new(frame)
	modalCanvas[1] = {
		type = 'image',
		image = hs.image.imageFromPath('keyboard/mehmap.png'),
		frame = {
			 x = (frame.w - imgsz.w) / 2,
			 y = (frame.h - imgsz.h) / 2,
			 w = imgsz.w,
			 h = imgsz.h,
		},
		imageAlpha = 1.0,
	}
	modalCanvas:show(0.1)
end

function hideReimod()
	 modalCanvas:hide(0.1)
end

local mapShown = 0

hs.hotkey.bind(reimod, "/", function()
	if mapShown == 0 then
		showKeymap()
		mapShown = 1
	elseif mapShown == 1 then
		hideKeymap()
		showReimod()
		mapShown = 2
	else
		hideReimod()
		mapShown = 0
	end
end)