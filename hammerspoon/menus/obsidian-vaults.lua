local M = {}

function M.getMenu(cons)
    return {
        parentMenu = "mainMenu",
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'T', "Tweede Brein", {
                {cons.act.func, function()
                    hs.urlevent.openURL("obsidian://open/?vault=TweedeBrein")
                end }
            }},
            {cons.cat.action, '', 'N', "NS", {
                {cons.act.func, function()
                    hs.urlevent.openURL("obsidian://open/?vault=ns-obsidian")
                end }
            }},
            {cons.cat.action, '', 'F', "FYI", {
                {cons.act.func, function()
                    hs.urlevent.openURL("obsidian://open/?vault=FYI")
                end }
            }}
        }
    }
end

return M
