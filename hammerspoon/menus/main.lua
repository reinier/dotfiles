local M = {}

function M.getMenu(cons)
    return {
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
			{cons.cat.action, '', 'space', "Alfred", {
				{cons.act.keycombo, {'cmd'}, 'space'},
			}},
			{cons.cat.action, '', 'D', "Clipboard", {
				{cons.act.func, function()
					hs.eventtap.keyStroke({"cmd","alt","ctrl"}, "1")
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

