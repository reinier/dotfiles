-- local chooserActions = {
-- 	{
-- 		["text"] = "Set Safari as default",
-- 		["subText"] = "Set Safari as default browser in Hammerspoon",
-- 		["val"] = "safari"
-- 	},
-- 	{
-- 		["text"] = "Set Chrome as default",
-- 		["subText"] = "Set Chrome as default browser in Hammerspoon",
-- 		["val"] = "chrome"
-- 	},
-- }

-- hsImage:hide()
-- hsImage:show()

-- local chooser
-- choseAction = function(action)
-- 	-- log.i(hs.inspect(action));
-- 	
-- 	hs.alert.show(action['subText'])
-- 	
-- 	-- See hammerbrowser.lua for variables 
-- 	
-- 	if action['val'] == "safari" then
-- 		hs.alert.show('✅')
-- 		spoon.URLDispatcher.default_handler = safariBrowser
-- 	
-- 	elseif action['val'] == "chrome" then
-- 		hs.alert.show('✅')
-- 		spoon.URLDispatcher.default_handler = chromeBrowser
-- 		
-- 	else
-- 		hs.alert.show('❌ not found')
-- 	end
-- end

-- chooser = hs.chooser.new(choseAction)
-- chooser:choices(chooserActions)

local hammermodal = hs.hotkey.modal.new()

-- imageHammerModal = hs.loadSpoon('FadeLogo')
-- imageHammerModal.image = hs.image.imageFromPath('~/dev/dotfiles/hammerspoon/hammermodal.png')
-- imageHammerModal:start()

-- imageHammerModal:hide()
-- imageHammerModal:show()

showModalLayout = function()
	local frame = hs.screen.mainScreen():frame()
	local imgsz = hs.geometry.size(800, 400)
	modalCanvas = hs.canvas.new(frame)
	modalCanvas[1] = {
		type = 'image',
		image = hs.image.imageFromPath('keyboard/hammermodal.png'),
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

function hideModalLayout()
	 modalCanvas:hide(0.1)
end

hs.hotkey.bind(reimod, "h", function()
	showModalLayout()
	hammermodal:enter()
end)

exithammermodal = function()
	hideModalLayout()
	hammermodal:exit()
end

hammermodal:bind({}, 's', function()
	spoon.URLDispatcher.default_handler = safariBrowser
	hs.alert.show('Safari is now the default browser')
	exithammermodal()
end)

hammermodal:bind({}, 'c', function()
	spoon.URLDispatcher.default_handler = chromeBrowser
	hs.alert.show('Chrome is now the default browser')
	exithammermodal()
end)

hammermodal:bind({}, 'escape', function()
	exithammermodal()
end)

