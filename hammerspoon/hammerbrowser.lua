--
-- Browser Menu
--

-- Step 1: Take care, that Hammerspoon is the default browser
if hs.urlevent.getDefaultHandler("http") ~= "org.hammerspoon.hammerspoon" then
		hs.urlevent.setDefaultHandler("http")
end

-- Step 2: Setup the browser menu
local active_browser     = hs.settings.get("active_browser") or "com.apple.safari"
local browser_menu       = hs.menubar.new()
local available_browsers = {
		["com.apple.safari"] = {
				name = "Safari",
				icon = os.getenv("HOME") .. "/.hammerspoon/browsermenu/safari.png"
		},
		["org.mozilla.firefox"] = {
				name = "Firefox",
				icon = os.getenv("HOME") .. "/.hammerspoon/browsermenu/firefox.png"
		},
		["com.google.chrome"] = {
				name = "Google Chrome",
				icon = os.getenv("HOME") .. "/.hammerspoon/browsermenu/chrome.png"
		},
}

function init_browser_menu()
		local menu_items = {}

		for browser_id, browser_data in pairs(available_browsers) do
				local image = hs.image.imageFromPath(browser_data["icon"]):setSize({w=16, h=16})

				if browser_id == active_browser then
						browser_menu:setIcon(image)
				end

				table.insert(menu_items, {
						title   = browser_data["name"],
						image   = image,
						checked = browser_id == active_browser,
						fn      = function()
								active_browser = browser_id
								hs.settings.set("active_browser", browser_id)
								init_browser_menu()
						end
				})
		end

		browser_menu:setMenu(menu_items)
end

init_browser_menu()

-- Step 3: Register a handler for opening URLs
hs.urlevent.httpCallback = function(scheme, host, params, fullURL)
		hs.urlevent.openURLWithBundle(fullURL, active_browser)
end