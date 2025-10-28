local M = {}

function M.pasteOverTextForLink()
    local pb = hs.pasteboard
    -- 1) Remember the URL that's already on the clipboard
    local url = pb.getContents()
    if not url or url == "" then
        hs.alert.show("Clipboard has no URL")
        return
    end

    -- 2) Copy the selected text
    local before = pb.changeCount()
    hs.eventtap.keyStroke({"cmd"}, "C")
    -- tiny wait until clipboard changes (max ~0.5s)
    local t0 = hs.timer.absoluteTime()
    while pb.changeCount() == before and (hs.timer.absoluteTime() - t0) < 5e8 do
        hs.timer.usleep(3000)
    end
    local selected = pb.getContents() or ""
    if selected == "" then
        hs.alert.show("No text selected")
        -- keep the original URL intact on the clipboard
        pb.setContents(url)
        return
    end

    -- 3) Build Markdown [selected](url)
    local function escText(s) return s:gsub("%[","\\["):gsub("%]","\\]") end
    local function escURL(u) return u:gsub("%(","%%28"):gsub("%)","%%29"):gsub(" ", "%%20") end
    local md = string.format("[%s](%s)", escText(selected), escURL(url))

    -- 4) Paste it over the selection, then restore the URL to the clipboard
    pb.setContents(md)
    hs.eventtap.keyStroke({"cmd"}, "V")
    pb.setContents(url)

    hs.alert.show("Wrapped as Markdown link")
end

-- Browser-specific URL extraction handlers
local browserHandlers = {
    Safari = function()
        local as = [[
        try
            tell application "Safari"
                set u to URL of front document
                set t to name of front document
            end tell
            return u & "¶" & t
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]
        local ok, result = hs.osascript.applescript(as)
        if ok and not result:match("^ERROR:") then
            local url, title = result:match("^(.*)¶(.*)$")
            if url and title then
                return {
                    url = url,
                    title = title,
                    source = "browser",
                    success = true
                }
            end
        end
        return {
            url = nil,
            title = nil,
            source = "browser",
            success = false
        }
    end,

    Orion = function()
        local as = [[
        try
            tell application "Orion"
                set u to URL of current tab of window 1
                set t to name of current tab of window 1
            end tell
            return u & "¶" & t
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]
        local ok, result = hs.osascript.applescript(as)
        if ok and not result:match("^ERROR:") then
            local url, title = result:match("^(.*)¶(.*)$")
            if url and title then
                return {
                    url = url,
                    title = title,
                    source = "browser",
                    success = true
                }
            end
        end
        return {
            url = nil,
            title = nil,
            source = "browser",
            success = false
        }
    end,

    Arc = function()
        -- Try combined approach first, then fallback to separate calls
        local combinedAs = [[
        try
            tell application "Arc"
                return execute front window's active tab javascript "window.location.href + '|||' + document.title.replace(/\"/g, '')"
            end tell
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]

        local ok, result = hs.osascript.applescript(combinedAs)
        if ok and not result:match("^ERROR:") then
            -- Use simple separator to avoid encoding issues
            local separatorPos = result:find("|||", 1, true) -- plain text search
            if separatorPos then
                local url = result:sub(1, separatorPos - 1)
                local title = result:sub(separatorPos + 3) -- +3 for "|||"

                -- Clean up any remaining quotes or whitespace issues in both URL and title
                url = url:gsub('^%s*"*(.-)%s*"*$', '%1') -- remove leading/trailing quotes and whitespace
                url = url:gsub('"+', '"'):gsub('"$', ''):gsub('^"', '') -- remove duplicate and trailing quotes

                title = title:gsub('^%s*"*(.-)%s*"*$', '%1') -- remove leading/trailing quotes and whitespace
                title = title:gsub('"+', '"'):gsub('"$', ''):gsub('^"', '') -- remove duplicate and trailing quotes
                title = title:gsub('[%[%]]', '') -- remove square brackets that interfere with markdown

                if url and title and url ~= "" and title ~= "" then
                    return {
                        url = url,
                        title = title,
                        source = "browser",
                        success = true
                    }
                end
            end
        end

        -- Fallback: separate JavaScript calls
        local urlAs = [[
        try
            tell application "Arc"
                return execute front window's active tab javascript "window.location.href"
            end tell
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]

        local titleAs = [[
        try
            tell application "Arc"
                return execute front window's active tab javascript "document.title.replace(/\"/g, '')"
            end tell
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]

        local urlOk, url = hs.osascript.applescript(urlAs)
        local titleOk, title = hs.osascript.applescript(titleAs)

        if urlOk and titleOk and not url:match("^ERROR:") and not title:match("^ERROR:") then
            -- Clean up any remaining quotes or whitespace issues in both URL and title
            url = url:gsub('^%s*"*(.-)%s*"*$', '%1') -- remove leading/trailing quotes and whitespace
            url = url:gsub('"+', '"'):gsub('"$', ''):gsub('^"', '') -- remove duplicate and trailing quotes

            title = title:gsub('^%s*"*(.-)%s*"*$', '%1') -- remove leading/trailing quotes and whitespace
            title = title:gsub('"+', '"'):gsub('"$', ''):gsub('^"', '') -- remove duplicate and trailing quotes
            title = title:gsub('[%[%]]', '') -- remove square brackets that interfere with markdown

            return {
                url = url,
                title = title,
                source = "browser",
                success = true
            }
        end

        return {
            url = nil,
            title = nil,
            source = "browser",
            success = false
        }
    end,

    ["zen"] = function()
        -- Store original clipboard content
        local originalClipboard = hs.pasteboard.getContents()

        -- Focus browser and use GUI automation
        hs.application.launchOrFocus("Zen Browser")
        hs.timer.usleep(100000) -- Wait for launch

        local zenApp = hs.application.get("Zen Browser")
        if zenApp then
            zenApp:activate()
            zenApp:unhide()
            -- More forceful activation using AppleScript
            hs.osascript.applescript([[
                tell application "Zen Browser"
                    activate
                    tell application "System Events"
                        tell process "zen"
                            set frontmost to true
                        end tell
                    end tell
                end tell
            ]])
        end
        hs.timer.usleep(300000) -- 0.3 second delay for activation

        -- Get URL via address bar
        hs.eventtap.keyStroke({"cmd"}, "l")
        hs.timer.usleep(100000) -- Increased delay
        hs.eventtap.keyStroke({"cmd"}, "c")
        hs.timer.usleep(200000) -- Increased delay

        local url = hs.pasteboard.getContents()

        -- Get title from window title (fallback method)
        local titleScript = [[
        try
            tell application "System Events"
                tell application process "zen"
                    set windowTitle to name of front window
                end tell
            end tell
            return windowTitle
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]

        local titleOk, windowTitle = hs.osascript.applescript(titleScript)
        local title = nil

        if titleOk and not windowTitle:match("^ERROR:") then
            -- Clean up window title (remove " - Zen" or similar suffixes)
            title = windowTitle:gsub(" %- [Zz]en.*$", ""):gsub(" %- Mozilla Firefox$", "")
        end

        -- Restore original clipboard
        if originalClipboard then
            hs.pasteboard.setContents(originalClipboard)
        end

        if url and url ~= "" and url ~= originalClipboard then
            return {
                url = url,
                title = title or "Unknown Title",
                source = "browser",
                success = true
            }
        end

        return {
            url = nil,
            title = nil,
            source = "browser",
            success = false
        }
    end
}

-- Custom hexadecimal HTML entity decoder
local function decodeHexEntities(str)
    return str:gsub("&#x(%x+);", function(hex)
        local num = tonumber(hex, 16)
        if num and num > 0 and num < 0x110000 then
            return utf8.char(num)
        end
        return "&#x" .. hex .. ";" -- fallback if conversion fails
    end)
end

-- HTTP title fetcher
local function fetchWebTitle(url, callback)
    hs.http.asyncGet(url, {}, function(status, body, headers)
        if status == 200 and body then
            -- Extract title using multiple patterns for different HTML structures
            local title = body:match("<title>(.-)</title>") or
                         body:match("<title[^>]*>(.-)</title>") or
                         body:match('<title[^>]*>(.-)</title>') or
                         body:match("(?i)<title[^>]*>(.-)</title>")

            if title then
                -- Decode HTML entities (both named and hexadecimal) and clean up whitespace
                title = decodeHexEntities(hs.http.convertHtmlEntities(title))
                title = title:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
                title = title:gsub("%s+", " ") -- normalize internal whitespace
            end

            callback(title or "Unknown Title")
        else
            -- Fallback: use domain name as title
            local domain = url:match("https?://([^/]+)")
            callback(domain or "Failed to fetch title")
        end
    end)
end

-- Browser availability checker
local function isBrowserAvailable(browserName)
    local app = hs.application.get(browserName)
    return app ~= nil
end

-- Generate markdown link from URL and title
local function createMarkdownLink(url, title)
    local function escText(s) return s:gsub("%[","\\["):gsub("%]","\\]") end
    local function escURL(u) return u:gsub("%(","%%28"):gsub("%)","%%29"):gsub(" ", "%%20") end
    return string.format("[%s](%s)", escText(title), escURL(url))
end

-- Get markdown link from Safari
function M.getBrowserMarkdownLink()
    local browserName = "Safari"

    -- Check if Safari is available
    if not isBrowserAvailable(browserName) then
        hs.alert.show("Safari is not currently running")
        return
    end

    -- Get Safari handler
    local handler = browserHandlers[browserName]

    -- Extract both URL and title from Safari
    local result = handler()
    if not result or not result.success then
        hs.alert.show("Failed to get data from Safari")
        return
    end

    -- Decode HTML entities in browser-provided title and remove problematic characters
    local cleanTitle = decodeHexEntities(hs.http.convertHtmlEntities(result.title))
    cleanTitle = cleanTitle:gsub('[%[%]]', '') -- remove square brackets that interfere with markdown

    -- Create markdown link
    local markdownLink = createMarkdownLink(result.url, cleanTitle)
    hs.pasteboard.setContents(markdownLink)
    hs.alert.show("Copied: " .. cleanTitle)
end

return M