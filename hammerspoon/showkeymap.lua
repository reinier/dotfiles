showKeymap = function()
	local frame = hs.screen.mainScreen():frame()
	local currentScreen = hs.screen.mainScreen():name()
	-- if (currentScreen == 'LG UltraFine') then
	-- 	imgsz = hs.geometry.size(1400, 960)
	-- else
	-- 	imgsz = hs.geometry.size(700, 480)
	-- end
	imgsz = hs.geometry.size(1400, 960)
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
	local currentScreen = hs.screen.mainScreen():name()
	-- if (currentScreen == 'LG UltraFine') then
	-- 	imgsz = hs.geometry.size(1400, 960)
	-- else
	-- 	imgsz = hs.geometry.size(700, 480)
	-- end
	imgsz = hs.geometry.size(1400, 960)
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

mapShown = 0

function toggleKeymap()
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
end

-- Svalboard keymap display functions
showSvalboardMain = function()
	local frame = hs.screen.mainScreen():frame()
	imgsz = hs.geometry.size(1400, 960)
	svalboardCanvas = hs.canvas.new(frame)
	svalboardCanvas[1] = {
		type = 'image',
		image = hs.image.imageFromPath('keyboard/svalboard-main.png'),
		frame = {
			 x = (frame.w - imgsz.w) / 2,
			 y = (frame.h - imgsz.h) / 2,
			 w = imgsz.w,
			 h = imgsz.h,
		},
		imageAlpha = 1.0,
	}
	svalboardCanvas:show(0.1)
end

function hideSvalboardMain()
	 svalboardCanvas:hide(0.1)
end

showSvalboardLayers = function()
	local frame = hs.screen.mainScreen():frame()
	imgsz = hs.geometry.size(1400, 960)
	svalboardCanvas = hs.canvas.new(frame)
	svalboardCanvas[1] = {
		type = 'image',
		image = hs.image.imageFromPath('keyboard/svalboard-layers.png'),
		frame = {
			 x = (frame.w - imgsz.w) / 2,
			 y = (frame.h - imgsz.h) / 2,
			 w = imgsz.w,
			 h = imgsz.h,
		},
		imageAlpha = 1.0,
	}
	svalboardCanvas:show(0.1)
end

function hideSvalboardLayers()
	 svalboardCanvas:hide(0.1)
end

svalboardMapShown = 0

function toggleSvalboardKeymap()
	 if svalboardMapShown == 0 then
		 showSvalboardMain()
		 svalboardMapShown = 1
	 elseif svalboardMapShown == 1 then
		 hideSvalboardMain()
		 showSvalboardLayers()
		 svalboardMapShown = 2
	 else
		 hideSvalboardLayers()
		 svalboardMapShown = 0
	 end
end
