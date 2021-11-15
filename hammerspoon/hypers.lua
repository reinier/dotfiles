-- Manage apps on left hand

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

hs.hotkey.bind(hyperkey, "s", function()
	hs.application.launchOrFocusByBundleID('com.agilebits.onepassword7')
end)

hs.hotkey.bind(hyperkey, "c", function()
	hs.application.launchOrFocusByBundleID('com.lukilabs.lukiapp')
end)

hs.hotkey.bind(hyperkey, "v", function()
	hs.application.launchOrFocusByBundleID('com.flexibits.fantastical2.mac')
end)

hs.hotkey.bind(hyperkey, "e", function()
	hs.application.launchOrFocusByBundleID('com.apple.Mail')
end)

hs.hotkey.bind(hyperkey, "w", function()
	hs.application.launchOrFocusByBundleID('com.apple.MobileSMS')
end)

hs.hotkey.bind(hyperkey, "t", nil, function()
	hs.application.launchOrFocusByBundleID('com.apple.Music')
end)

hs.hotkey.bind(hyperkey, "a", function()
	hs.application.launchOrFocusByBundleID('com.tinyspeck.slackmacgap')
end)

hs.hotkey.bind(hyperkey, "x", function()
	hs.application.launchOrFocusByBundleID('com.apple.Notes')
end)

-- Create stuff on right hand

hs.hotkey.bind(hyperkey, "k", function()
	hs.application.launchOrFocusByBundleID('com.panic.nova')
end)

hs.hotkey.bind(hyperkey, "m", function()
	hs.application.launchOrFocusByBundleID('com.ideasoncanvas.mindnode.macos')
end)

hs.hotkey.bind(hyperkey, "j", function()
	hs.application.launchOrFocusByBundleID('com.figma.Desktop')
end)

hs.hotkey.bind(hyperkey, "i", function()
	hs.application.launchOrFocusByBundleID('com.apple.Terminal')
end)

hs.hotkey.bind(hyperkey, "h", function()
	hs.application.launchOrFocusByBundleID('com.omnigroup.OmniGraffle7')
end)

hs.hotkey.bind(hyperkey, "l", function()
	hs.application.launchOrFocusByBundleID('com.zengobi.curio')
end)

hs.hotkey.bind(hyperkey, "n", function()
	hs.application.launchOrFocusByBundleID('com.apple.iWork.Keynote')
end)

hs.hotkey.bind(hyperkey, "y", function()
	hs.application.launchOrFocusByBundleID('com.apple.iWork.Numbers')
end)

hs.hotkey.bind(hyperkey, "u", function()
	hs.application.launchOrFocusByBundleID('com.ulyssesapp.mac')
end)