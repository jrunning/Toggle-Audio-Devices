tell application "Finder" to get folder of (path to me) -- get this script's folder
set myFolder to result as Unicode text
-- load the configuration file
set config to run script (a reference to file (myFolder & "config.applescript"))

-- Go!
toggle(skypeDevices of config, sysDevices of config, options of config)

-- Toggle to whatever device we're not using now
on toggle(skypeDevices, sysDevices, options)
	if areSpeakersOn(sysDevices) then
		toggleToHeadset(skypeDevices, sysDevices, options)
	else
		toggleToSpeaker(skypeDevices, sysDevices, options)
	end if
end toggle

-- Switch to the devices defined for "headset" mode
on toggleToHeadset(skypeDevices, sysDevices, options)
	setSkypeDevices(headset of skypeDevices)
	setSysDevices(headset of sysDevices)
  if speak of options
  	say "Headset." using speakVoice of options
  end if
end toggleToHeadset

-- Switch to the devices defined for "speaker" mode
on toggleToSpeaker(skypeDevices, sysDevices, options)
	setSkypeDevices(speaker of skypeDevices)
	setSysDevices(speaker of sysDevices)
  
  if speak of options
  	say "Speakers." using speakVoice of options
  end if
end toggleToSpeaker

-- Set the Skype audio preferences
on setSkypeDevices(mode)
	tell application "Skype" to activate
	tell application "System Events"
		tell process "Skype"
      -- open the Preferences dialog with the keyboard shortcut
			keystroke "," using command down
			set prefs to front window
      
      -- switch to the Audio tab and grab the drop-down menus
			click UI element "Audio" of tool bar 1 of prefs
			set dropDowns to group 1 of group 1 of prefs
			
			set outputDrop to pop up button 1 of dropDowns
			set inputDrop to pop up button 2 of dropDowns
			set ringerDrop to pop up button 3 of dropDowns
			
			-- set Audio output device
			click outputDrop
			click menu item (output of mode) of menu 1 of outputDrop
			
			-- set Audio input device
			click inputDrop
			click menu item (input of mode) of menu 1 of inputDrop
			
			-- set Ringing device
			click ringerDrop
			click menu item (ringer of mode) of menu 1 of ringerDrop
      
      -- close Preferences with the keyboard shortcut
      keystroke "w" using command down
		end tell
	end tell
end setSkypeDevices

-- Set the system audio preferences
on setSysDevices(mode)
	openSysPrefs()

	tell application "System Events"
		if UI elements enabled then
			try
				tell application process "System Preferences"
					tell tab group 1 of window "Sound"
						click radio button "Output" -- switch to the Output tab
						select row (output of mode) of table 1 of scroll area 1 -- choose the device
						
						click radio button "Input" -- switch to the Input tab
						select row (input of mode) of table 1 of scroll area 1 -- choose the device
					end tell
				end tell
			end try
		end if
	end tell
  tell application "System Preferences" to quit
end setSysDevices

-- Return true if audio output is set to speakers
on areSpeakersOn(sysDevices)
	openSysPrefs()
	tell application "System Events"
		if UI elements enabled then
			try
				tell application process "System Preferences"
					tell tab group 1 of window "Sound"
						click radio button "Output" -- switch to the Output tab
            -- return true if the configured "speaker" device is the one selected
						return selected of row (output of speaker of sysDevices) of table 1 of scroll area 1
					end tell
				end tell
			end try
		end if
	end tell
end areSpeakersOn

-- Launch the System Preferences dialog and switch to the Sound pane
on openSysPrefs()
	tell application "System Preferences"
		activate
		set current pane to pane "com.apple.preference.sound"
	end tell
end openSysPrefs

