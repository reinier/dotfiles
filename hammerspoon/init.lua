require('ergomouse')
require('layerdisplay')
require('hyperconfig')
-- require('hammerbrowser')

cherry = hs.loadSpoon("Cherry")

cherry:bindHotkeys({
	start = {{ "alt", "shift", "cmd" }, "p"}
})