-- https://github.com/FryJay/MenuHammer

menuHammerMenuList = {
	mainMenu = {
		parentMenu = nil,
		menuHotkey = {{}, 'f19'},
		menuItems =  {
			{cons.cat.exit, '', 'f19', 'Exit', {
				{cons.act.func, function() self.menuManager:closeMenu() end }
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.submenu, '', 'O', 'More Apps', {
				{cons.act.menu, "applicationMenu"}
			}},
			{cons.cat.submenu, '', 'T', 'Audio', {
				{cons.act.menu, "audioMenu"}
			}},
			{cons.cat.submenu, '', 'I', "Finder", {
				{cons.act.menu, 'finderMenu'}
			}},
			{cons.cat.submenu, '', 'D', "Browse", {
				{cons.act.menu, 'browseMenu'}
			}},
			-- {cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, 'shift', 'space', "Alfred File Action", {
				{cons.act.keycombo, {'cmd','shift','option','control'}, 'space'},
			}},
			{cons.cat.action, '', 'space', "Alfred", {
				{cons.act.keycombo, {'cmd'}, 'space'},
			}},
			-- {cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, '', 'H', "Arc", {
				{cons.act.launcher, 'Arc'}
			}},
			{cons.cat.action, '', '.', "Terminal", {
				{cons.act.launcher, 'Terminal'}
			}},
			{cons.cat.action, 'shift', ',', "Nova", {
				{cons.act.launcher, 'Nova'}
			}},
			{cons.cat.action, '', ',', "VSCode", {
				{cons.act.launcher, 'Visual Studio Code'}
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
			{cons.cat.action, '', 'N', "Bear", {
				{cons.act.launcher, 'Bear'}
			}},
			{cons.cat.action, '', 'Y', "1Password", {
				{cons.act.launcher, '1Password'}
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, '', 'A', "Actions", {
				{cons.act.keycombo, hyperkey, 'a'},
			}},
			{cons.cat.action, '', 'V', "Templates", {
				{cons.act.keycombo, hyperkey, 'v'},
			}},
			{cons.cat.action, '', 'C', "Clipboard", {
				{cons.act.keycombo, hyperkey, 'c'},
			}},
			{cons.cat.action, '', 'S', 'App actions', {
				{cons.act.keycombo, hyperkey, 's'},
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, '', 'R', "Reload HS", {
				{cons.act.func, function()
					hs.reload()
				end }
			}},
			-- {cons.cat.action, '', 'B', "Show keymap", {
			-- 	{cons.act.func, function()
			-- 		  toggleKeymap()
			-- 	end }
			-- }, true},
			
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
				{cons.act.launcher, 'UlyssesMac'}
			}},
			{cons.cat.action, '', 'S', "Slack", {
				{cons.act.launcher, 'Slack'}
			}},
			{cons.cat.action, '', 'O', "Obsidian", {
				{cons.act.launcher, 'Obsidian'}
			}}
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
				{
					cons.act.openfile,        -- Action type
					"/Users/reinierladan/Downloads" -- File path
				},
			}},
			{cons.cat.action, '', 'P', 'Process', {
				{
					cons.act.openfile,        -- Action type
					"/Users/reinierladan/Library/Mobile Documents/com~apple~CloudDocs/__Process" -- File path
				},
			}},
			{cons.cat.action, '', 'I', "Activate Finder", {
				{cons.act.launcher, 'Finder'}
			}},
		}
	},
	browseMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		menuItems = {
			{cons.cat.action, '', 'F', 'Fastmail', {
				{cons.act.openurl,
				"https://fastmail.com"
				}
			}},
			{cons.cat.action, '', 'M', 'Moneybird', {
				{cons.act.openurl,
				"https://moneybird.com/265874186632693728/documents/filter/period:this_year"
				}
			}},
			{cons.cat.action, '', 'W', 'Wikipedia',
			{
				{cons.act.userinput,                                             -- Action type
				"luckyWikipedia",                                               -- Value Identifier
				"Lucky Wikipedia",                                              -- Message
				"Google a Wikipedia article and hit I'm Feeling Lucky button"}, -- Informative Text
				{cons.act.openurl,
				"http://www.google.com/search?q=@@luckyWikipedia@@%20site:wikipedia.org&meta=&btnI"
				}
			}}
		}
	}
}
