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

hs.hotkey.bind(hyperkey, "o", function()
	hs.hints.windowHints()
end)

hs.hotkey.bind(hyperkey, "l", function()
	-- Duplicate line
	hs.eventtap.keyStroke({"cmd"}, "right")
	hs.eventtap.keyStroke({"shift,cmd"}, "left")
	hs.eventtap.keyStroke({"cmd"}, "c")
	hs.eventtap.keyStroke({}, "right")
	hs.eventtap.keyStroke({}, "return")
	hs.eventtap.keyStroke({"cmd"}, "v")
end)

hs.hotkey.bind(hyperkey, "k", function()
	-- Duplicate line
	hs.eventtap.keyStroke({"ctrl,cmd"}, "space")
end)