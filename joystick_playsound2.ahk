ToggleKeys__:=___

#If__ToggleKeys
Joy_::
SoundPlay,__C:\WINDOWS\Media\chimes.wav
Return

Joy_::
SoundPlay,__C:\WINDOWS\Media\chord.wav
Return
#If

^F_::	;__Ctrl+F___disables__hotkeys.
ToggleKeys__:=__!ToggleKeys
return