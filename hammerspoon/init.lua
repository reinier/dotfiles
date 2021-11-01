-- Required download:
-- https://github.com/Hammerspoon/Spoons/blob/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

hyperkey = { "ctrl", "alt", "shift", "cmd" }
-- minihyper = { "alt", "shift", "cmd" }

require('ergomouse')
require('layerdisplay')
require('hammerbrowser')
require('hypers')
require('hyperhyper')

-- spoon.SpoonInstall:andUse('KSheet', {
-- 	hotkeys = {
-- 		toggle = { hyperkey, "/" },
-- 	}
-- })

-- spoon.SpoonInstall:andUse('Cherry', {
-- 	hotkeys = {
-- 		start = { minihyper, "p" },
-- 	}
-- })

-- https://www.hammerspoon.org/Spoons/Seal.plugins.useractions.html
-- spoon.SpoonInstall:andUse("Seal",
--  {
-- 	 hotkeys = { show = { {"alt"}, "space" } },
-- 	 fn = function(s)
-- 		 s:loadPlugins({"apps", "calc"})
-- 		 s:refreshAllCommands()
-- 	 end,
-- 	 start = true,
--  }
-- )


-- Predefined keys include:
-- https://github.com/Hammerspoon/hammerspoon/blob/master/extensions/utf8/init.lua#L188
---
---     (U+2325) alt              ⌥
---     (U+F8FF) apple            
---     (U+21E4) backtab          ⇤
---     (U+21EA) capslock         ⇪
---     (U+2713) checkMark        ✓
---     (U+2318) cmd              ⌘
---     (U+27E1) concaveDiamond   ✧
---     (U+00A9) copyrightSign    ©
---     (U+2303) ctrl             ⌃
---     (U+232B) delete           ⌫
---     (U+2193) down             ↓
---     (U+21E3) down2            ⇣
---     (U+23CF) eject            ⏏
---     (U+21F2) end              ⇲
---     (U+2198) end2             ↘
---     (U+238B) escape           ⎋
---     (U+2326) forwarddelete    ⌦
---     (U+FE56) help             ﹖
---     (U+21F1) home             ⇱
---     (U+2196) home2            ↖
---     (U+21B8) home3            ↸
---     (U+2190) left             ←
---     (U+21E0) left2            ⇠
---     (U+201C) leftDoubleQuote  “
---     (U+2018) leftSingleQuote  ‘
---     (U+00B7) middleDot        ·
---     (U+21ED) numlock          ⇭
---     (U+2325) option           ⌥
---     (U+2327) padclear         ⌧
---     (U+2324) padenter         ⌤
---     (U+2386) padenter2        ⎆
---     (U+21A9) padenter3        ↩
---     (U+21DF) pagedown         ⇟
---     (U+21DE) pageup           ⇞
---     (U+233D) power            ⌽
---     (U+00AE) registeredSign   ®
---     (U+23CE) return           ⏎
---     (U+21A9) return2          ↩
---     (U+2192) right            →
---     (U+21E2) right2           ⇢
---     (U+201D) rightDoubleQuote  ”
---     (U+2019) rightSingleQuote  ’
---     (U+00A7) sectionSign      §
---     (U+21E7) shift            ⇧
---     (U+2423) space            ␣
---     (U+21E5) tab              ⇥
---     (U+2191) up               ↑
---     (U+21E1) up2              ⇡