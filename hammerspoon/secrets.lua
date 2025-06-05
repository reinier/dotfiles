-- SECRETS
-- Inspiration: https://github.com/evantravers/hammerspoon-config/blob/master/secrets.lua
-- Really stupid simple loading of secrets into `hs.settings`.

local M = {}

function M.start(filename)
	if hs.fs.attributes(filename) then
		hs.settings.set("secrets", hs.json.read(filename))
	else
		print("You need to create a file at " .. filename)
	end
end

return M
