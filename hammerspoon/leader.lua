-- https://nethumlamahewage.medium.com/setting-up-a-global-leader-key-for-macos-using-hammerspoon-f0330f8a7a4a

hs.loadSpoon("RecursiveBinder")

spoon.RecursiveBinder.escapeKey = {{}, 'escape'}  -- Press escape to abort

local singleKey = spoon.RecursiveBinder.singleKey

local keyMap = {
  [singleKey('h', 'Arc')] = function() hs.application.launchOrFocus("Arc") end,
  [singleKey('.', 'Terminal')] = function() hs.application.launchOrFocus("Terminal") end,
  [singleKey(',', 'VSCode')] = function() hs.application.launchOrFocus("Visual Studio Code") end,
  [singleKey('i', 'Finder')] = function() hs.application.launchOrFocus("Finder") end,
  [singleKey('k', 'Drafts')] = function() hs.application.launchOrFocus("Drafts") end,
  [singleKey('j', 'Things')] = function() hs.application.launchOrFocus("Things") end,
  [singleKey('m', 'Mindnode')] = function() hs.application.launchOrFocus("Mindnode") end,
  [singleKey('u', 'Figma')] = function() hs.application.launchOrFocus("Figma") end,
  [singleKey('p', 'Craft')] = function() hs.application.launchOrFocus("Craft") end,
  [singleKey('l', 'Fantastical')] = function() hs.application.launchOrFocus("Fantastical") end,
  [singleKey('o', 'Obsidian')] = function() hs.application.launchOrFocus("Obsidian") end,
  [singleKey('y', '1Password')] = function() hs.application.launchOrFocus("1Password") end,
  [singleKey('space', 'alfred')] = function() hs.eventtap.keyStroke({'cmd'}, "space") end,
  [singleKey('d', 'web+')] = {
	[singleKey('g', 'github')] = function() hs.urlevent.openURL("https://github.com") end,
	[singleKey('y', 'youtube')] = function() hs.urlevent.openURL("https://youtube.com") end
  },
  [singleKey('R', 'reload hs')] = function() hs.reload() end,
  [singleKey('C', 'show hs console')] = function() hs.console.hswindow():focus() end
}

hs.hotkey.bind({}, 'F19', spoon.RecursiveBinder.recursiveBind(keyMap))

-- spoon.RecursiveBinder.showBindHelper = false;

spoon.RecursiveBinder.helperFormat = {
	atScreenEdge = 2,  -- Bottom edge (default value)
	textStyle = {  -- An hs.styledtext object
		font = {
			name = "Menlo",
			size = 18
		}
	}
}