local M = {}

local modalCanvas
local mapShown = 0

function M.showKeymap()
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

function M.hideKeymap()
	 modalCanvas:hide(0.1)
end

function M.showReimod()
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

function M.hideReimod()
	 modalCanvas:hide(0.1)
end

function M.toggleKeymap()
         if mapShown == 0 then
                 M.showKeymap()
                 mapShown = 1
         elseif mapShown == 1 then
                 M.hideKeymap()
                 M.showReimod()
                 mapShown = 2
         else
                 M.hideReimod()
                 mapShown = 0
         end
end

return M
