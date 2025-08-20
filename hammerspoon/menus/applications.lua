local M = {}

function M.getMenu(cons)
    return {
        parentMenu = "mainMenu",
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'A', "App Store", {
                {cons.act.launcher, 'App Store'}
            }},
            {cons.cat.action, '', 'G', "Github", {
                {cons.act.launcher, 'Github Desktop'}
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
            }},
            {cons.cat.action, '', 'I', "Miro", {
                {cons.act.launcher, 'Miro'}
            }}
        }
    }
end

return M