-- https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/

function appID(app)
	return hs.application.infoForBundlePath(app)['CFBundleIdentifier']
end

safariBrowser = appID('/Applications/Safari.app')
chromeBrowser = appID('/Applications/Google Chrome.app')
firefoxBrowser = appID('/Applications/Firefox.app')

DefaultBrowser = safariBrowser
workBrowser = chromeBrowser

spoon.SpoonInstall:andUse("URLDispatcher",
	{
	 config = {
		 url_patterns = {
			 { "https?://calendar.google.com",    workBrowser },
			 { "https?://mail.google.com",      	workBrowser },
			 { "https?://meet.google.com",      	workBrowser },
			 { "https?://persgroep-it.slack.com", workBrowser },
			 { "https?://atlassian.dpgmedia.net", workBrowser }
		 },
		 -- url_redir_decoders = {
			--  -- Send MS Teams URLs directly to the app
			--  { "MS Teams URLs",
			-- 	 "(https://teams.microsoft.com.*)", "msteams:%1", true },
			--  -- Preview incorrectly encodes the anchor
			--  -- character in URLs as %23, we fix it
			--  { "Fix broken Preview anchor URLs",
			-- 	 "%%23", "#", false, "Preview" },
		 -- },
		 default_handler = DefaultBrowser
	 },
	 start = true,
	 -- Enable debug logging if you get unexpected behavior
	 -- loglevel = 'debug'
	}
)

-- Move this to a hyperhammer

browsermenu = hs.menubar.new()
items = {
	{ title = "Safari", fn = function() setsafari() end },
	{ title = "Chrome", fn = function() setchrome() end },
}
browsermenu:setMenu(items)
browsermenu:setTitle("🧭")

function setsafari()
	hs.alert.show('safari set as default browser')
	spoon.URLDispatcher.default_handler = safariBrowser
end

function setchrome()
	hs.alert.show('chrome set as default browser')
	spoon.URLDispatcher.default_handler = chromeBrowser
end