-- Application switcher
-- hs.window.switcher.ui.textColor = {0.9,0.9,0.9}

hs.window.switcher.ui.fontName = 'Menlo'
hs.window.switcher.ui.textSize = 9 -- in screen points
-- hs.window.switcher.ui.highlightColor = {0.8,0.5,0,0.8} -- highlight color for the selected window
-- hs.window.switcher.ui.backgroundColor = {0.3,0.3,0.3,1}
-- hs.window.switcher.ui.onlyActiveApplication = false -- only show windows of the active application
-- hs.window.switcher.ui.showTitles = true -- show window titles
-- hs.window.switcher.ui.titleBackgroundColor = {0,0,0}
-- hs.window.switcher.ui.showThumbnails = true -- show window thumbnails
-- hs.window.switcher.ui.thumbnailSize = 128 -- size of window thumbnails in screen points
-- hs.window.switcher.ui.showSelectedThumbnail = true -- show a larger thumbnail for the currently selected window
-- hs.window.switcher.ui.selectedThumbnailSize = 384
-- hs.window.switcher.ui.showSelectedTitle = true -- show larger title for the currently selected window

-- Include minimized/hidden windows, current Space only
switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})

hs.hotkey.bind('alt','tab','Next window', function()switcher:next()end)
hs.hotkey.bind('alt-shift','tab','Previous window', function()switcher:previous()end)