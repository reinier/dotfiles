-- countdown-timer.lua - Simple countdown timer with menu bar display
local M = {}

-- State management
local menubarItem = nil
local timerObject = nil
local remainingSeconds = 0
local isPaused = false
local initialMinutes = 0

-- History management
local HISTORY_KEY = "countdownTimerHistory"
local MAX_HISTORY = 10

-- Helper function to format seconds as MM:SS
local function formatTime(seconds)
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", mins, secs)
end

-- Update menu bar display with fixed-width font
local function updateDisplay()
    if menubarItem then
        local timeText = formatTime(remainingSeconds)
        local icon = isPaused and "⏸ " or "⏱ "

        -- Use styled text with monospace font for consistent width
        local styledText = hs.styledtext.new(icon .. timeText, {
            font = { name = "Menlo", size = 12 },  -- Menlo is a monospace font included with macOS
        })

        menubarItem:setTitle(styledText)
    end
end

-- Timer completion handler
local function onTimerComplete()
    -- Stop the timer
    if timerObject then
        timerObject:stop()
        timerObject = nil
    end

    -- Show completion in menu bar briefly
    if menubarItem then
        menubarItem:setTitle("⏱ 00:00")
    end

    -- Create persistent Mac native notification
    local notification = hs.notify.new(function(notification)
        -- Callback when notification is clicked/dismissed
        M.cleanup()
    end, {
        title = "Timer Complete",
        informativeText = string.format("%d minute timer has finished", initialMinutes),
        withdrawAfter = 0,  -- Stay on screen until dismissed
        hasActionButton = false,
        soundName = nil  -- Silent notification
    })

    -- Send the notification
    if notification then
        notification:send()
    end

    -- Clean up menu bar after a brief display (2 seconds)
    hs.timer.doAfter(2, function()
        if not isPaused then
            M.cleanup()
        end
    end)
end

-- Timer tick handler (called every second)
local function onTimerTick()
    if isPaused then
        return
    end

    remainingSeconds = remainingSeconds - 1

    if remainingSeconds <= 0 then
        remainingSeconds = 0
        onTimerComplete()
    else
        updateDisplay()
    end
end

-- Clean up timer resources
function M.cleanup()
    if timerObject then
        timerObject:stop()
        timerObject = nil
    end

    if menubarItem then
        menubarItem:delete()
        menubarItem = nil
    end

    remainingSeconds = 0
    isPaused = false
    initialMinutes = 0
end

-- Start countdown timer
function M.startTimer(minutes)
    -- Validate input
    if not minutes or minutes <= 0 then
        hs.alert.show("❌ Invalid timer duration", 2)
        return false
    end

    -- Clean up any existing timer
    M.cleanup()

    -- Initialize state
    initialMinutes = minutes
    remainingSeconds = minutes * 60
    isPaused = false

    -- Create menu bar item
    menubarItem = hs.menubar.new()
    if not menubarItem then
        hs.alert.show("❌ Failed to create menu bar item", 2)
        return false
    end

    -- Set up menu bar click actions
    menubarItem:setMenu(function()
        local menu = {
            {
                title = isPaused and "Resume Timer" or "Pause Timer",
                fn = function()
                    if isPaused then
                        M.resumeTimer()
                    else
                        M.pauseTimer()
                    end
                end
            },
            {
                title = "-"  -- Separator
            },
            {
                title = "Cancel Timer",
                fn = function()
                    M.cancelTimer()
                end
            }
        }
        return menu
    end)

    -- Initial display
    updateDisplay()

    -- Start countdown timer (updates every second)
    timerObject = hs.timer.doEvery(1, onTimerTick)

    if not timerObject then
        hs.alert.show("❌ Failed to start timer", 2)
        M.cleanup()
        return false
    end

    hs.alert.show(string.format("✅ Timer started: %d minutes", minutes), 2)
    return true
end

-- Pause timer
function M.pauseTimer()
    if not timerObject then
        return false
    end

    isPaused = true
    updateDisplay()
    hs.alert.show("⏸ Timer paused", 1)
    return true
end

-- Resume timer
function M.resumeTimer()
    if not timerObject then
        return false
    end

    isPaused = false
    updateDisplay()
    hs.alert.show("▶️ Timer resumed", 1)
    return true
end

-- Cancel timer
function M.cancelTimer()
    M.cleanup()
    hs.alert.show("❌ Timer cancelled", 2)
    return true
end

-- Get current timer status
function M.getStatus()
    if not timerObject then
        return {
            active = false
        }
    end

    return {
        active = true,
        paused = isPaused,
        remainingSeconds = remainingSeconds,
        remainingFormatted = formatTime(remainingSeconds),
        initialMinutes = initialMinutes
    }
end

-- Load timer history from settings
local function loadHistory()
    local history = hs.settings.get(HISTORY_KEY)
    if not history then
        return {}
    end
    return history
end

-- Save timer history to settings
local function saveHistory(history)
    hs.settings.set(HISTORY_KEY, history)
end

-- Add a duration to history (deduplicate and limit to MAX_HISTORY)
local function addToHistory(minutes)
    local history = loadHistory()

    -- Remove if already exists (we'll add it to the front)
    for i, value in ipairs(history) do
        if value == minutes then
            table.remove(history, i)
            break
        end
    end

    -- Add to front
    table.insert(history, 1, minutes)

    -- Limit to MAX_HISTORY items
    while #history > MAX_HISTORY do
        table.remove(history)
    end

    saveHistory(history)
end

-- Build chooser items from history
local function buildChooserItems()
    local history = loadHistory()
    local items = {}

    -- Add history items
    for _, minutes in ipairs(history) do
        table.insert(items, {
            text = string.format("%d minutes", minutes),
            subText = string.format("⏱ %02d:00", minutes),
            minutes = minutes
        })
    end

    return items
end

-- Prompt user for minutes and start timer using chooser
function M.promptAndStart()
    -- Check if timer is already running
    local status = M.getStatus()
    if status.active then
        local button, response = hs.dialog.blockAlert(
            "Timer Already Running",
            string.format("A timer is already running with %s remaining.\n\nWhat would you like to do?",
                         status.remainingFormatted),
            "Cancel Current & Start New",
            "Keep Current Timer"
        )

        if button == "Cancel Current & Start New" then
            M.cleanup()
        else
            return false
        end
    end

    -- Get initial history choices
    local historyChoices = buildChooserItems()

    -- Create chooser for timer selection
    local chooser = hs.chooser.new(function(choice)
        if not choice then
            -- User cancelled
            return
        end

        -- Extract minutes from the selected choice
        local minutesNum = choice.minutes

        if minutesNum and minutesNum > 0 then
            addToHistory(minutesNum)
            M.startTimer(minutesNum)
        else
            hs.alert.show("❌ Invalid timer duration", 2)
        end
    end)

    -- Configure chooser with dynamic query handling
    chooser:choices(historyChoices)
    chooser:placeholderText("Enter minutes or select from history...")
    chooser:searchSubText(true)

    -- Handle custom input as user types
    chooser:queryChangedCallback(function(query)
        if query and query ~= "" then
            local minutesNum = tonumber(query)
            local newChoices = {}

            -- If query is a valid number, show it as first option
            if minutesNum and minutesNum > 0 then
                table.insert(newChoices, {
                    text = string.format("%d minutes", minutesNum),
                    subText = "⏱ " .. string.format("%02d:00", minutesNum) .. " - Press Enter to start",
                    minutes = minutesNum
                })
            end

            -- Add matching history items
            for _, choice in ipairs(historyChoices) do
                if string.find(tostring(choice.minutes), query, 1, true) or
                   string.find(choice.text, query, 1, true) then
                    table.insert(newChoices, choice)
                end
            end

            chooser:choices(newChoices)
        else
            -- No query, show all history
            chooser:choices(historyChoices)
        end
    end)

    -- Show the chooser
    chooser:show()
end

return M
