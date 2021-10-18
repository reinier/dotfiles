local mod = { "cmd", "alt", "ctrl" }

local obj = {}

obj.__index = obj
obj.name = "Tiles"
obj.version = "0.7.0"
obj.author = "Maxim Soukharev <maxim.soukharev@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"


local longLongAxisSizes = {
    { text = '25 %',    frac = 0.25 },
    { text = '33 %',    frac = 0.333 },
    { text = '50 %',    frac = 0.5 },
    { text = '67 %',    frac = 0.666 },
    { text = '75 %',    frac = 0.75 },
    { text = '100 %',   frac = 1}
}

local longAxisSizes = {
    { text = '25 %',    frac = 0.25 },
    { text = '33 %',    frac = 0.333 },
    { text = '50 %',    frac = 0.5 },
    { text = '67 %',    frac = 0.666 },
    { text = '75 %',    frac = 0.75 },
    { text = '100 %',   frac = 1 }
}

local longLongAxisOffsets = {
    { text = '0 %',     frac = 0 },
    { text = '25 %',    frac = 0.25 },
    { text = '33 %',    frac = 0.333 },
    { text = '50 %',    frac = 0.5 },
    { text = '67 %',    frac = 0.666 },
    { text = '75 %',    frac = 0.75 }
}

local longAxisOffsets = {
    { text = '0 %',     frac = 0 },
    { text = '33 %',    frac = 0.333 },
    { text = '50 %',    frac = 0.5 },
    { text = '67 %',    frac = 0.666 }
}

local shortAxisConfigs = {
    { text = '100 %',   frac = {1, 0} },
    { text = 'First 50%', frac = {0.5, 0}},
    { text = 'Second 50%', frac = {0.5, 0.5}}
}


local function isVeryLong(screen)
    local frame = screen:frame()
    local aspectRatio = frame.w / frame.h
    if aspectRatio >= 2.3333 then
        return true
    else
        return false
    end
end


local function getFocusedWindowWithScreen()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    return win, screen
end

local function getLastFocusedWindowWithScreen()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then
        return lastFocused[1], lastFocused[1]:screen()
    end
end


local function setWindowSize(win, screen, w, h)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    winFrameUnit.w = w or winFrameUnit.w
    winFrameUnit.h = h or winFrameUnit.h
    win:move(winFrameUnit)
end

local function setWindowPosition(win, screen, x, y)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    winFrameUnit.x = x or winFrameUnit.x
    winFrameUnit.y = y or winFrameUnit.y
    win:move(winFrameUnit)
end


local positionPicker = hs.chooser.new(function (choice)
    if choice then
        local win, screen = getFocusedWindowWithScreen()
        setWindowPosition(win, screen, choice['frac'])
    end
end):width(15):placeholderText('Window x position')

local sizePicker = hs.chooser.new(function (choice)
    if choice then
        local win, screen = getFocusedWindowWithScreen()
        setWindowSize(win ,screen, choice['frac'])
    end
end):width(15):placeholderText('Window width')

local shortAxisPicker = hs.chooser.new(function (choice)
    if choice then
        local win, screen = getFocusedWindowWithScreen()
        local h, y = table.unpack(choice['frac'])
        setWindowSize(win, screen, nil, h)
        setWindowPosition(win, screen, nil, y)
    end
end):width(15):placeholderText('')


local configPicker = hs.chooser.new(function (sizeChoice)
    if sizeChoice then
        local win, screen = getLastFocusedWindowWithScreen()
        local posChoices = isVeryLong(screen) and longLongAxisOffsets or longAxisOffsets
        local validPosChoices = {}
        for _, pos in ipairs(posChoices) do
            if 1 - pos['frac'] >= sizeChoice['frac'] then
                table.insert(validPosChoices, pos)
            end
        end

        if #validPosChoices == 0 then
            return
        end

        local configPickerPos = hs.chooser.new(function (posChoice)
            if posChoice then
                local configPickerShortAxis = hs.chooser.new(function (shortAxisConfig)
                    if shortAxisConfig then
                        local h, y = table.unpack(shortAxisConfig['frac'])
                        setWindowSize(win, screen, sizeChoice['frac'], h)
                        setWindowPosition(win, screen, posChoice['frac'], y)
                    end
                end):width(15):placeholderText('Window short axis')
                configPickerShortAxis:choices(shortAxisConfigs)
                configPickerShortAxis:show()
            end
        end):width(15):placeholderText('Window x position')

        configPickerPos:choices(validPosChoices)
        configPickerPos:show()
    end
end):width(15):placeholderText('Window width')


hs.hotkey.bind(mod, '0', function ()
    local _, screen = getFocusedWindowWithScreen()
    local choices = isVeryLong(screen) and longLongAxisSizes or longAxisOffsets
    sizePicker:choices(choices)
    sizePicker:show()
end)

hs.hotkey.bind(mod, '-', function ()
    local _, screen = getFocusedWindowWithScreen()
    local choices = isVeryLong(screen) and longLongAxisOffsets or longAxisOffsets
    positionPicker:choices(choices)
    positionPicker:show()
end)

hs.hotkey.bind(mod, '=', function ()
    local choices = shortAxisConfigs
    shortAxisPicker:choices(choices)
    shortAxisPicker:show()
end)


hs.hotkey.bind(mod, '/', function ()
    local _, screen = getFocusedWindowWithScreen()
    local sizeChoices = isVeryLong(screen) and longLongAxisSizes or longAxisSizes
    configPicker:choices(sizeChoices)
    configPicker:show()
end)


return obj
