menuHammerMenuList = {
	mainMenu = {
		parentMenu = nil,
		menuHotkey = {{}, 'f19'},
		menuItems =  {
			{cons.cat.submenu, '', '/', 'More Apps', {
				  {cons.act.menu, "applicationMenu"}
			}},
			{cons.cat.submenu, '', 'T', 'Audio', {
				  {cons.act.menu, "audioMenu"}
			}},
			{cons.cat.action, '', 'I', "Finder", {
				  {cons.act.menu, 'finderMenu'}
			}},
			{cons.cat.action, '', 'H', "Arc", {
				  {cons.act.launcher, 'Arc'}
			}},
			{cons.cat.action, '', '.', "Terminal", {
				  {cons.act.launcher, 'Terminal'}
			}},
			{cons.cat.action, '', ',', "Nova", {
				  {cons.act.launcher, 'Nova'}
			}},
			{cons.cat.action, 'shift', ',', "VSCode", {
				  {cons.act.launcher, 'Visual Studio Code'}
			}},
			{cons.cat.action, '', 'space', "Alfred", {
				  {cons.act.keycombo, {'cmd'}, 'space'},
			}},
			{cons.cat.action, '', 'U', "Figma", {
				  {cons.act.launcher, 'Figma'}
			}},
			{cons.cat.action, '', 'K', "Drafts", {
				  {cons.act.launcher, 'Drafts'}
			}},
			{cons.cat.action, '', 'J', "Things", {
				  {cons.act.launcher, 'Things3'}
			}},
			{cons.cat.action, '', 'L', "Fantastical", {
				  {cons.act.launcher, 'Fantastical'}
			}},
			{cons.cat.action, '', 'M', "Mindnode", {
				  {cons.act.launcher, 'Mindnode'}
			}},
			{cons.cat.action, '', 'P', "Craft", {
				  {cons.act.launcher, 'Craft'}
			}},
			{cons.cat.action, '', 'O', "Obsidian", {
				  {cons.act.launcher, 'Obsidian'}
			}},
			{cons.cat.action, '', 'Y', "1Password", {
				  {cons.act.launcher, '1Password'}
			}},
			{cons.cat.action, '', 'A', "Actions", {
				{cons.act.keycombo, hyperkey, 'a'},
			}},
			{cons.cat.action, '', 'V', "Actions", {
				{cons.act.keycombo, hyperkey, 'v'},
			}},
			{cons.cat.action, '', 'C', "Clipboard", {
				{cons.act.keycombo, hyperkey, 'c'},
			}},
			{cons.cat.action, '', 'S', 'App actions', {
				  {cons.act.keycombo, hyperkey, 's'},
			}},

			{cons.cat.action, '', 'R', "Reload HS", {
				{cons.act.func, function()
					  hs.reload()
				end }
			}},
			-- {cons.cat.action, '', 'H', "Hammerspoon Manual", {
			-- 	  {cons.act.func, function()
			-- 		  hs.doc.hsdocs.forceExternalBrowser(true)
			-- 		  hs.doc.hsdocs.moduleEntitiesInSidebar(true)
			-- 		  hs.doc.hsdocs.help()
			-- 	  end }
			-- }},
			-- {cons.cat.action, '', 'M', 'MenuHammer Default Config', {
			-- 	{cons.act.openfile, "~/.hammerspoon/Spoons/MenuHammer.spoon/MenuConfigDefaults.lua"},
			-- }},
			{cons.cat.action, '', 'X', "Mute/Unmute", {
				  {cons.act.mediakey, "mute"}
			}},
		}
	},
	applicationMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		-- menuHotkey = {{"shift"}, 'f19'},
		menuItems = {
			{cons.cat.action, '', 'A', "App Store", {
				  {cons.act.launcher, 'App Store'}
			}},
			{cons.cat.action, '', 'G', "Github", {
				  {cons.act.launcher, 'Github Desktop'}
			}},
			{cons.cat.action, '', 'K', "Keyboard Maestro", {
				  {cons.act.launcher, 'Keyboard Maestro'}
			}},
			{cons.cat.action, '', 'N', "Numbers", {
				  {cons.act.launcher, 'Numbers'}
			}},
			{cons.cat.action, '', 'U', "Ulysses", {
				  {cons.act.launcher, 'Ulysses'}
			}},
			{cons.cat.action, '', 'S', "Slack", {
				  {cons.act.launcher, 'Slack'}
			}},
		}
	},
	audioMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		-- menuHotkey = {{"shift"}, 'f19'},
		menuItems = {
			{cons.cat.action, '', 'A', "Music", {
				{cons.act.launcher, "Music"}
			}},
			{cons.cat.action, '', 'H', "Previous Track", {
				{cons.act.mediakey, "previous"}
			}},
			{cons.cat.action, '', 'J', "Volume Down", {
				{cons.act.mediakey, "adjustVolume", -10}
			},true},
			{cons.cat.action, '', 'K', "Volume Up", {
				{cons.act.mediakey, "adjustVolume", 10}
			},true},
			{cons.cat.action, '', 'L', "Next Track", {
				{cons.act.mediakey, "next"}
			}},
			{cons.cat.action, '', 'X', "Mute/Unmute", {
				{cons.act.mediakey, "mute"}
			}},
			{cons.cat.action, '', 'S', "Play/Pause", {
				{cons.act.mediakey, "playpause"}
			}},
			{cons.cat.action, '', 'I', "Brightness Down", {
				{cons.act.mediakey, "brightness", -10}
			},true},
			{cons.cat.action, '', 'O', "Brightness Up", {
				{cons.act.mediakey, "brightness", 10}
			},true},
		}
	},
	finderMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		-- menuHotkey = {{"shift"}, 'f19'},
		menuItems = {
			{cons.cat.action, '', 'D', 'Desktop', {
			  	{cons.act.launcher, 'Finder'},
			  	{cons.act.keycombo, {'cmd', 'shift'}, 'd'},
			}},
			{cons.cat.action, '', 'L', 'Downloads', {
				  {cons.act.launcher, 'Finder'},
				  {cons.act.keycombo, {'cmd', 'shift'}, 'l'},
			}},
			{cons.cat.action, '', 'I', "Activate Finder", {
				  {cons.act.launcher, 'Finder'}
			}},
		}
	}
}