-- Do not edit the next two lines
set skypeDevices to {headset:{},speaker:{}}
set sysDevices to {headset:{},speaker:{}}

-- CONFIGURATION --
(* Change true to false below if you don't want to hear a spoken alert every
   time you toggle your audio devices, or change speakVoice to the voice of your
   choosing (available voices are identified at the bottom of this page:
   http://docs.info.apple.com/article.html?path=AppleScript/2.1/en/as304.html
*)

set options to { speak: true, speakVoice: "Trinoids" }


(* Go to Skype > Preferences > Audio and note the exact device names for your
   desired input and output devices, e.g. if your external speakers in the
   "Audio output" drop-down are called "Built-in Output Internal Speakers",
   enter that exactly (in quotation marks) after "output" on the "speaker" line
   below. Do the same for your input and output devices for "headset" and
   "speaker" mode.
*)
 
-- Headset devices:
set headset of skypeDevices to { input: "Avnera Audio Device", output: "Avnera Audio Device", ringer: "Avnera Audio Device" }

-- Speaker/microphone devices:
set speaker of skypeDevices to {input: "Built-in Microphone Internal microphone", output: "Built-in Output Internal Speakers", ringer: "Built-in Output Internal Speakers" }


(* Next, go to System Preferences > Sound > Input and Output and note the
   positions in in the list of your desired input and output devices and enter
   them below, e.g. if your headphones are the third item on the list, enter "3"
   after "output" on the "headset" line below. Do the same for your input and
   output devices for "headset" and "speaker" mode.
*)

-- Headset devices:
set headset of sysDevices to { input: 3, output: 2 }

-- Speaker/microphone devices:
set speaker of sysDevices to { input:1 , output: 1 }


-- Do not edit the rest of this file
return { skypeDevices: skypeDevices, sysDevices: sysDevices, options: options }
