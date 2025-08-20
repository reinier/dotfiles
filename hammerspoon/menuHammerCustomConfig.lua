-- https://github.com/FryJay/MenuHammer
-- Refactored menu configuration with modular components

-- Load menu modules
local main = require('menus.main')
local applicationMenu = require('menus.applications')
local textMenu = require('menus.text-snippets')
local finderMenu = require('menus.finder')
local windowMenu = require('menus.window-management')
local scriptMenu = require('menus.scripts')

menuHammerMenuList = {
	-- Load modular menu definitions
	mainMenu = main.getMenu(cons),
	applicationMenu = applicationMenu.getMenu(cons),
	textMenu = textMenu.getMenu(cons),
	finderMenu = finderMenu.getMenu(cons),
	windowMenu = windowMenu.getMenu(cons),
	scriptMenu = scriptMenu.getMenu(cons)
}
