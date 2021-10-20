require('ergomouse')
require('layerdisplay')
require('hyperconfig')

cherry = hs.loadSpoon("Cherry")

cherry:bindHotkeys({
	start = {{ "alt", "shift", "cmd" }, "p"}
})