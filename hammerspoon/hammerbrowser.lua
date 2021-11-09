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
			 { hs.settings.get("secrets").workUrls.calendar,	workBrowser },
			 { hs.settings.get("secrets").workUrls.mail,    	workBrowser },
			 { hs.settings.get("secrets").workUrls.meet,  		workBrowser },
			 { hs.settings.get("secrets").workUrls.slack, 		workBrowser },
			 { hs.settings.get("secrets").workUrls.jira,			workBrowser }
		 },
		 default_handler = DefaultBrowser
	 },
	 start = true,
	 -- Enable debug logging if you get unexpected behavior
	 -- loglevel = 'debug'
	}
)
