local M = {}

function M.getMenu(cons)
    local dateUtils = require('functions.date-utils')
    local markdownUtils = require('functions.markdown-utils')
    local timerApi = require('functions.timer-api')
    
    return {
        parentMenu = "mainMenu",
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'W', "Show week number", {
                {cons.act.func, function()
                    local week = dateUtils.getWeekNumber()
                    hs.alert.show("Week " .. week, 1)
                end }
            }},
            {cons.cat.action, '', 'V', "Paste over text for link", {
                {cons.act.func, function()
                    markdownUtils.pasteOverTextForLink()
                end }
            }},
            {cons.cat.action, '', 'U', "Get MD link browser", {
                {cons.act.func, function()
                    markdownUtils.getBrowserMarkdownLink()
                end }
            }},
            {cons.cat.action, '', 'K', "Show keymap", {
                {cons.act.func, function()
                    toggleKeymap()
                end }
            }},
            {cons.cat.action, '', 'T', "Start Timer", {
                {cons.act.func, function()
                    timerApi.startTimer(function(result, message)
                        if result then
                            hs.alert.show(message, 3)
                        else
                            hs.alert.show(message, 5)
                        end
                    end)
                end }
            }},
            {cons.cat.action, '', 'R', "Reset Timer Settings", {
                {cons.act.func, function()
                    timerApi.resetTimerSettings()
                end }
            }},
        }
    }
end

return M