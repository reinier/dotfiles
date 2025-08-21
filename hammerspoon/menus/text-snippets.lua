local M = {}

function M.getMenu(cons)
    local dateUtils = require('functions.date-utils')
    
    return {
        parentMenu = "mainMenu",
        menuHotkey = nil,
        menuItems = {
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
            {cons.cat.action, '', 'J', "Desc acc to refinement", {
                {cons.act.func, function()
                    local text = "Description according to refinement sessions:"
                    hs.eventtap.keyStrokes(text)
                end }
            }},
            {cons.cat.action, '', 'D', "Date long", {
                {cons.act.func, function()
                    hs.eventtap.keyStrokes(dateUtils.getLongDate())
                end }
            }},
            {cons.cat.action, '', 'F', "Date short", {
                {cons.act.func, function()
                    hs.eventtap.keyStrokes(dateUtils.getShortDate())
                end }
            }},
            {cons.cat.action, '', 'G', "Date prefix", {
                {cons.act.func, function()
                    hs.eventtap.keyStrokes(dateUtils.getDatePrefix())
                end }
            }},
        }
    }
end

return M