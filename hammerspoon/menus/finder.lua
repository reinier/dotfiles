local M = {}

function M.getMenu(cons)
    return {
        parentMenu = "mainMenu",
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'D', 'Desktop', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'd'},
            }},
            {cons.cat.action, '', 'L', 'Downloads', {
                {
                    cons.act.openfile,
                    "/Users/reinierladan/Downloads"
                },
            }},
            {cons.cat.action, '', 'P', 'Process', {
                {
                    cons.act.openfile,
                    "/Users/reinierladan/Library/Mobile Documents/com~apple~CloudDocs/__Process"
                },
            }},
            {cons.cat.action, '', 'I', "Activate Finder", {
                {cons.act.launcher, 'Finder'}
            }},
        }
    }
end

return M