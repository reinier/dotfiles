hs.window.switcher.ui.fontName = 'Menlo'
hs.window.switcher.ui.showThumbnails = false
hs.window.switcher.ui.showTitles = false
hs.window.switcher.ui.showSelectedThumbnail = true 
hs.window.animationDuration = 0

switcher = hs.window.switcher.new()
hs.hotkey.bind(mehkey, "f", switcher.nextWindow, nil,switcher.nextWindow)
hs.hotkey.bind(mehkey, "g", switcher.previousWindow,nil,switcher.previousWindow)