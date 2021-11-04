-- Reserved:

-- A - Keyboard Maestro
-- C - Alfred
-- T - Alfred

hs.hotkey.bind(hyperkey, "d", function()
	hs.application.launchOrFocusByBundleID('com.agiletortoise.Drafts-OSX')
end)

hs.hotkey.bind(hyperkey, "r", function()
	hs.application.launchOrFocusByBundleID('com.apple.finder')
end)

hs.hotkey.bind(hyperkey, "b", function()
	hs.application.launchOrFocusByBundleID('com.google.Chrome')
end)

hs.hotkey.bind(hyperkey, "g", function()
	hs.application.launchOrFocusByBundleID('com.apple.Safari')
end)

hs.hotkey.bind(hyperkey, "f", function()
	hs.application.launchOrFocusByBundleID('com.omnigroup.OmniFocus3.MacAppStore')
end)

hs.hotkey.bind(hyperkey, "p", function()
	hs.application.launchOrFocusByBundleID('com.agilebits.onepassword7')
end)

hs.hotkey.bind(hyperkey, "e", function()
	hs.application.launchOrFocusByBundleID('com.panic.nova')
end)

-- hs.hotkey.bind(hyperkey, "l", function()
-- 	-- Duplicate line
-- 	hs.eventtap.keyStroke({"cmd"}, "right")
-- 	hs.eventtap.keyStroke({"shift,cmd"}, "left")
-- 	hs.eventtap.keyStroke({"cmd"}, "c")
-- 	hs.eventtap.keyStroke({}, "right")
-- 	hs.eventtap.keyStroke({}, "return")
-- 	hs.eventtap.keyStroke({"cmd"}, "v")
-- end)

-- hs.hotkey.bind(hyperkey, "k", function()
-- 	-- Show emojis and characters
-- 	hs.eventtap.keyStroke({"ctrl,cmd"}, "space")
-- end)

-- hs.hotkey.bind(hyperkey, "o", function()
--   hs.eventtap.keyStroke({}, "return")
-- end)

-- Application switcher
hs.window.switcher.ui.fontName = 'Menlo'
hs.window.switcher.ui.textSize = 9 -- in screen points
hs.window.switcher.ui.showTitles = true -- show window titles
hs.window.switcher.ui.showThumbnails = false -- show window thumbnails
hs.window.switcher.ui.showSelectedThumbnail = false -- show a larger thumbnail for the currently selected window
switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})

hs.hotkey.bind(hyperkey,'q', function()switcher:next()end)
hs.hotkey.bind(hyperkey,'w', function()switcher:previous()end)
