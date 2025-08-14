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
			{cons.cat.submenu, '', 'W', 'Window', {
				{cons.act.menu, "windowMenu"}
			}},
			{cons.cat.submenu, '', 'T', 'Text', {
				{cons.act.menu, "textMenu"}
			}},
			{cons.cat.submenu, '', 'I', "Finder", {
				{cons.act.menu, 'finderMenu'}
			}},
			{cons.cat.submenu, '', 'D', "Browse", {
				{cons.act.menu, 'browseMenu'}
			}},
			{cons.cat.submenu, '', 'A', "Scripts", {
				{cons.act.menu, 'scriptMenu'}
			}},
			-- {cons.cat.display,'Spacer',{function()return "-----"end}},
			-- {cons.cat.action, 'shift', 'space', "Alfred File Action", {
			-- 	{cons.act.keycombo, {'cmd','shift','option','control'}, 'space'},
			-- }},
			{cons.cat.action, '', 'space', "Alfred", {
				{cons.act.keycombo, {'cmd'}, 'space'},
			}},
			-- {cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, '', 'H', "Apple Music", {
				{cons.act.launcher, 'Music'}
			}},
			{cons.cat.action, '', '.', "Terminal", {
				{cons.act.launcher, 'Terminal'}
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
			{cons.cat.action, '', 'N', "Obsidian", {
				{cons.act.launcher, 'Obsidian'}
			}},
			{cons.cat.action, '', 'L', "Fantastical", {
				{cons.act.launcher, 'Fantastical'}
			}},
			{cons.cat.action, '', 'M', "Arc", {
				{cons.act.launcher, 'Arc'}
			}},
			{cons.cat.action, '', 'P', "1Password", {
				{cons.act.launcher, '1Password'}
			}},
			{cons.cat.action, '', 'J', "Things3", {
				{cons.act.launcher, 'Things3'}
			}},
			{cons.cat.action, '', '/', "Claude", {
				{cons.act.launcher, 'Claude'}
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			-- {cons.cat.action, '', 'A', "Actions", {
			-- 	{cons.act.keycombo, hyperkey, 'a'},
			-- }},
			{cons.cat.action, '', 'V', "Templates", {
				{cons.act.keycombo, hyperkey, 'v'},
			}},
			{cons.cat.action, '', 'C', "Clipboard", {
				{cons.act.func, function()
					hs.eventtap.keyStroke({"cmd","alt","ctrl"}, "1")
				end }
				-- {cons.act.keycombo, hyperkey, 'c'},
			}},
			{cons.cat.action, '', 'S', 'App actions', {
				{cons.act.keycombo, hyperkey, 's'},
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, '', 'R', "Reload HS", {
				{cons.act.func, function()
					hs.reload()
				end }
			}}
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
			{cons.cat.action, '', 'M', "MS Outlook", {
				{cons.act.launcher, 'Microsoft Outlook'}
			}}
		}
	},
	textMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		menuItems = {
			-- {cons.cat.action, '', 'T', "Music", {
			-- 	{cons.act.launcher, "Music"}
			-- }},
			{cons.cat.action, '', 'C', "cooperatie", {
				{cons.act.func, function()
					local text = "coöperatie"
					hs.eventtap.keyStrokes(text)
				end }
			}},
			{cons.cat.action, '', 'P', "PO Werkzaamheden", {
				{cons.act.func, function()
					local text = "PO Werkzaamheden"
					hs.eventtap.keyStrokes(text)
				end }
			}},
			{cons.cat.action, '', 'D', "Date long", {
				{cons.act.func, function()
					local weekdays = {"zondag","maandag","dinsdag","woensdag","donderdag","vrijdag","zaterdag"}
					local months   = {"januari","februari","maart","april","mei","juni","juli","augustus","september","oktober","november","december"}
					local t = os.date("*t")  -- t.wday: 1=zondag .. 7=zaterdag
					local nl = string.format("%s %d %s %d", weekdays[t.wday], t.day, months[t.month], t.year)
					hs.eventtap.keyStrokes(nl)
				end }
			}},
			{cons.cat.action, '', 'F', "Date short", {
				{cons.act.func, function()
					local dateString = os.date("%y-%m-%d")
					hs.eventtap.keyStrokes(dateString)
				end }
			}},
			{cons.cat.action, '', 'G', "Date prefix", {
				{cons.act.func, function()
					local dateString = os.date("%y%m%d-")
					hs.eventtap.keyStrokes(dateString)
				end }
			}},
			



			-- {cons.cat.action, '', 'V', "Homepod vol. high", {
			-- 	{cons.act.func, function()
			-- 		hs.shortcuts.run("Homepod kantoor volume hoog")
			-- 	end }
			-- }}
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
	windowMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		menuHotkey = {mehkey, 'f19'},
		menuItems = {
			{cons.cat.action, '', 'V', 'Move node to workspace 1', {
				{cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 1' && zsh -c '/opt/homebrew/bin/aerospace workspace 1'"},
		  	}},
			{cons.cat.action, '', 'C', 'Move node to workspace 2', {
				{cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 2' && zsh -c '/opt/homebrew/bin/aerospace workspace 2'"},
		  	}},
			{cons.cat.action, '', 'X', 'Move node to workspace 3', {
				{cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 3' && zsh -c '/opt/homebrew/bin/aerospace workspace 3'"},
		  	}},
			{cons.cat.action, '', 'Z', 'Move node to workspace 4', {
				{cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 4' && zsh -c '/opt/homebrew/bin/aerospace workspace 4'"},
		  	}},
		}
	},
	scriptMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		menuItems = {
			{cons.cat.action, '', 'W', "Show week number", {
				{cons.act.func, function()
					local week = os.date("%V")
    				hs.alert.show("Week " .. week, 1) -- 1 second
				end }
			}},
			{cons.cat.action, '', 'V', "Paste over text for link", {
				{cons.act.func, function()
					local pb = hs.pasteboard
					-- 1) Remember the URL that’s already on the clipboard
					local url = pb.getContents()
					if not url or url == "" then
						hs.alert.show("Clipboard has no URL")
						return
					end

					-- 2) Copy the selected text
					local before = pb.changeCount()
					hs.eventtap.keyStroke({"cmd"}, "C")
					-- tiny wait until clipboard changes (max ~0.5s)
					local t0 = hs.timer.absoluteTime()
					while pb.changeCount() == before and (hs.timer.absoluteTime() - t0) < 5e8 do
						hs.timer.usleep(3000)
					end
					local selected = pb.getContents() or ""
					if selected == "" then
						hs.alert.show("No text selected")
						-- keep the original URL intact on the clipboard
						pb.setContents(url)
						return
					end

					-- 3) Build Markdown [selected](url)
					local function escText(s) return s:gsub("%[","\\["):gsub("%]","\\]") end
					local function escURL(u) return u:gsub("%(","%%28"):gsub("%)","%%29"):gsub(" ", "%%20") end
					local md = string.format("[%s](%s)", escText(selected), escURL(url))

					-- 4) Paste it over the selection, then restore the URL to the clipboard
					pb.setContents(md)
					hs.eventtap.keyStroke({"cmd"}, "V")
					pb.setContents(url)

					hs.alert.show("Wrapped as Markdown link")
				end }
			}},
			{cons.cat.action, '', 'U', "Get MD link browser", {
				{cons.act.func, function()
					local as = [[
					try
						tell application "Arc"
						tell front window to tell active tab
							set t to title
							set u to URL
						end tell
						end tell
						return t & "¶" & u
					on error errMsg
						return "ERROR:" & errMsg
					end try
					]]
					local ok, result = hs.osascript.applescript(as)
					if not ok or result:match("^ERROR:") then
						hs.alert.show("Arc script failed")
						return
					end
					local title, url = result:match("^(.*)¶(.*)$")
					hs.pasteboard.setContents(string.format("[%s](%s)", title or "", url or ""))
					hs.alert.show("Copied Markdown link")
				end }
			}}
		}
	},
	browseMenu = {
		parentMenu = "mainMenu",
		menuHotkey = nil,
		menuItems = {
			{cons.cat.action, '', 'C', 'ChatGPT', {
				{cons.act.openurl,
				"https://chat.openai.com/"
				}
			}},
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
