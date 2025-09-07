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

function M.getBrowserMarkdownLink()
    local as = [[
    try
        tell application "Orion"
            set t to name of current tab of window 1
            set u to URL of current tab of window 1
        end tell
        return t & "¶" & u
    on error errMsg
        return "ERROR:" & errMsg
    end try
    ]]
    local ok, result = hs.osascript.applescript(as)
    if not ok or result:match("^ERROR:") then
        hs.alert.show("Orion script failed")
        return
    end
    local title, url = result:match("^(.*)¶(.*)$")
    hs.pasteboard.setContents(string.format("[%s](%s)", title or "", url or ""))
    hs.alert.show("Copied Markdown link")
end

return M