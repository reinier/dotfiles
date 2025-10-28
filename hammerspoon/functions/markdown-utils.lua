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

-- Safari URL extraction handler
local function getSafariMarkdownData()
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
end

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

-- Generate markdown link from URL and title
local function createMarkdownLink(url, title)
    local function escText(s) return s:gsub("%[","\\["):gsub("%]","\\]") end
    local function escURL(u) return u:gsub("%(","%%28"):gsub("%)","%%29"):gsub(" ", "%%20") end
    return string.format("[%s](%s)", escText(title), escURL(url))
end

-- Get markdown link from Safari
function M.getBrowserMarkdownLink()
    -- Check if Safari is running
    local safariApp = hs.application.get("Safari")
    if not safariApp then
        hs.alert.show("Safari is not currently running")
        return
    end

    -- Extract URL and title from Safari
    local result = getSafariMarkdownData()
    if not result or not result.success then
        hs.alert.show("Failed to get data from Safari")
        return
    end

    -- Decode HTML entities in title and remove problematic characters
    local cleanTitle = decodeHexEntities(hs.http.convertHtmlEntities(result.title))
    cleanTitle = cleanTitle:gsub('[%[%]]', '') -- remove square brackets that interfere with markdown

    -- Create markdown link and copy to clipboard
    local markdownLink = createMarkdownLink(result.url, cleanTitle)
    hs.pasteboard.setContents(markdownLink)
    hs.alert.show("Copied: " .. cleanTitle)
end

return M