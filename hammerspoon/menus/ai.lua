local M = {}

-- Configuration for AI chooser items
local function getChooserItems()
    local mehkey = {"ctrl", "alt", "shift"}

    return {
        {
            text = "Check Spelling",
            subText = "Invoke BoltAI spell checker on selected text",
            action = function()
                hs.eventtap.keyStroke(mehkey, "1")
            end
        },
        {
            text = "Screenshot Chat",
            subText = "Take a screenshot and chat about it in BoltAI",
            action = function()
                hs.eventtap.keyStroke(mehkey, "2")
            end
        },
        {
            text = "Open Chat Bar",
            subText = "Open BoltAI Chat Bar",
            action = function()
                hs.eventtap.keyStroke(mehkey, "3")
            end
        },
    }
end

-- Show the AI chooser
function M.showChooser()
    local items = getChooserItems()

    local chooser = hs.chooser.new(function(choice)
        if choice then
            -- Find the matching item by text and execute its action
            for _, item in ipairs(items) do
                if item.text == choice.text then
                    item.action()
                    break
                end
            end
        end
    end)

    local chooserData = {}
    for _, item in ipairs(items) do
        table.insert(chooserData, {
            text = item.text,
            subText = item.subText
        })
    end

    chooser:choices(chooserData)
    chooser:show()
end

return M
