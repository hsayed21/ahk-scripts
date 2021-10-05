ToggleKeys := 1

#If ToggleKeys
Joy1::
SoundPlay, C:\WINDOWS\Media\chimes.wav
Return

Joy2::
SoundPlay, C:\WINDOWS\Media\chord.wav
Return
#If

^F2::	; Ctrl+F2 disables hotkeys.
ToggleKeys := !ToggleKeys
return