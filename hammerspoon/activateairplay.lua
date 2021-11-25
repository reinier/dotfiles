hs.urlevent.bind("activateHomepodsOffice", function(eventName, params)
	hs.alert.show('Activate Homepods')
	hs.applescript(' \
	tell application "System Preferences" \
			reveal anchor "output" of pane id "com.apple.preference.sound" \
	end tell \
	\
	delay 2 \
	\
	tell application "System Events" to tell process "System Preferences" \
			tell table 1 of scroll area 1 of tab group 1 of window 1 \
					select (row 1 where value of text field 1 is "Werkruimte") \
			end tell \
	end tell \
	\
	quit application "System Preferences" \
	')
end)