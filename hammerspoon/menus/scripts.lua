local M = {}

function M.getMenu(cons)
    local dateUtils = require('functions.date-utils')
    local markdownUtils = require('functions.markdown-utils')
    local timerApi = require('functions.timer-api')
    local timerUtils = require('functions.timer-api.utils')
    local directoryWatchers = require('functions.directory-watchers')
    
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
                            timerUtils.logSuccess(message, 3)
                        else
                            timerUtils.logError(message, 5)
                        end
                    end)
                end }
            }},
            {cons.cat.action, '', 'R', "Reset Timer Settings", {
                {cons.act.func, function()
                    timerApi.resetTimerSettings()
                end }
            }},
            {cons.cat.action, '', 'D', "Debug Active Timers", {
                {cons.act.func, function()
                    timerApi.debugActiveTimers(function(result, message)
                        if result then
                            timerUtils.logSuccess("✅ Debug completed - check console", 3)
                        else
                            timerUtils.logError("❌ Debug failed: " .. (message or "Unknown error"), 5)
                        end
                    end)
                end }
            }},
            {cons.cat.action, '', 'C', "Copy Computer Name", {
                {cons.act.func, function()
                    local computerName = directoryWatchers.getCurrentComputer()
                    hs.pasteboard.setContents(computerName)
                    hs.alert.show("Computer name copied: " .. computerName, 3)
                end }
            }},
            {cons.cat.action, '', 'O', "Open Console", {
                {cons.act.func, function()
                    hs.console.hswindow():focus()
                end }
            }},
            {cons.cat.action, '', 'S', "Directory Watcher Status", {
                {cons.act.func, function()
                    directoryWatchers.status()
                    hs.alert.show("Directory watcher status - check console", 2)
                end }
            }},
            {cons.cat.action, '', 'L', "Reload Directory Watchers", {
                {cons.act.func, function()
                    local success = directoryWatchers.reload()
                    if success then
                        hs.alert.show("✅ Directory watchers reloaded", 3)
                    else
                        hs.alert.show("❌ Failed to reload directory watchers", 3)
                    end
                end }
            }},
        }
    }
end

return M