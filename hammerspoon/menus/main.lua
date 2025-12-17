local M = {}

function M.getMenu(cons)
    return {
        parentMenu = nil,
		menuHotkey = {{}, 'f19'},
		menuItems =  {
			{cons.cat.exit, '', 'f19', 'Exit', {
				{cons.act.func, function() menuHammer.menuManager:closeMenu() end }
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.submenu, '', 'O', 'More Apps', {
				{cons.act.menu, "applicationMenu"}
			}},
			{cons.cat.submenu, '', 'S', 'Aerospace', {
				{cons.act.menu, "windowMenu"}
			}},
			{cons.cat.submenu, '', 'F', 'Paste stuff', {
				{cons.act.menu, "textMenu"}
			}},
			{cons.cat.submenu, '', 'I', "Finder", {
				{cons.act.menu, 'finderMenu'}
			}},
			{cons.cat.submenu, '', 'A', "Scripts", {
				{cons.act.menu, 'scriptMenu'}
			}},
			{cons.cat.display,'Spacer',{function()return "-----"end}},
			{cons.cat.action, '', 'H', "Apple Music", {
				{cons.act.launcher, 'Music'}
			}},
			{cons.cat.action, '', '.', "Ghostty", {
				{cons.act.launcher, 'Ghostty'}
			}},
			{cons.cat.action, '', ',', "Nova", {
				{cons.act.launcher, 'Nova'}
			}},
			{cons.cat.action, '', 'U', "Figma", {
				{cons.act.launcher, 'Figma'}
			}},
			{cons.cat.action, '', 'K', "Drafts", {
				{cons.act.launcher, 'Drafts'}
			}},
			{cons.cat.submenu, '', 'N', "Obsidian", {
				{cons.act.menu, "obsidianVaultsMenu"}
			}},
			{cons.cat.action, '', 'L', "Fantastical", {
				{cons.act.launcher, 'Fantastical'}
			}},
			{cons.cat.action, '', 'M', "Safari", {
				{cons.act.launcher, 'Safari'}
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
			{cons.cat.action, '', 'space', "Alfred", {
				{cons.act.keycombo, {'cmd'}, 'space'},
			}},
			{cons.cat.action, '', 'D', "Clipboard", {
				{cons.act.func, function()
					hs.eventtap.keyStroke({"cmd"}, "space")
					hs.timer.doAfter(0.05, function()
						hs.eventtap.keyStroke({"cmd"}, "4")
					end)
				end }
			}},
			{cons.cat.action, '', 'R', "Reload HS", {
				{cons.act.func, function()
					hs.reload()
				end }
			}}
		}
    }
end

return M

