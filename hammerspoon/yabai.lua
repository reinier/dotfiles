-- ~/.hammerspoon/keyboard/yabai.lua
-- Yabai doesnt work great with focussing multiple monitors (sloooow) and configuring the shortcodes is finnicky and messy
-- For cycling things you have to make your own script
-- In short: Amethyst is far user friendlier.


function yabai(args, completion)
	local yabai_output = ""
	local yabai_error = ""
	-- Runs in background very fast
	local yabai_task = hs.task.new("/opt/homebrew/bin/yabai",nil, function(task, stdout, stderr)
		--print("stdout:"..stdout, "stderr:"..stderr)
		if stdout ~= nil then yabai_output = yabai_output..stdout end
		if stderr ~= nil then yabai_error = yabai_error..stderr end
		return true
	end, args)
	if type(completion) == "function" then
		yabai_task:setCallback(function() completion(yabai_output, yabai_error) end)
	end
	yabai_task:start()
end

-- function yabai_cycle_display()
--     -- local yabai_task = hs.task.new("/opt/homebrew/bin/yabaiyabai -m space --focus next || /opt/homebrew/bin/yabaiyabai -m space --focus first")
--     -- yabai_task:start()
--     hs.execute("/opt/homebrew/bin/yabai -m display --focus next || /opt/homebrew/bin/yabai -m display --focus first");
-- end

-- hs.hotkey.bind(mehkey, hs.keycodes.map["f"], function() yabai({"-m", "display", "--focus", "next"}) end)
-- hs.hotkey.bind(mehkey, hs.keycodes.map["d"], function()
--     print("Gaat het?")
--     yabai_cycle_display()
-- end)

-- hs.hotkey.bind(mehkey, hs.keycodes.map["k"], function() yabai({"-m", "window", "--swap", "recent"}) end)
