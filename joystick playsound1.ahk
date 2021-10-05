ToggleKeys := 1

Hotkey, Joy1, PlaySound1, On
Hotkey, JOy2, PlaySound2, On
return

PlaySound1:
SoundPlay, C:\WINDOWS\Media\chimes.wav
Return

PlaySound2:
SoundPlay, C:\WINDOWS\Media\chord.wav
Return

^F2::	; Ctrl+F2 disables hotkeys.
ToggleKeys := !ToggleKeys
If ToggleKeys
{
	Hotkey, Joy1, PlaySound1, On
	Hotkey, Joy2, PlaySound2, On
}
Else
{
	Hotkey, Joy1, PlaySound1, Off
	Hotkey, Joy2, PlaySound2, Off
}
return


#CommentFlag //  ; Joy1 = Sroo
#CommentFlag //  ; Joy2 = Long Pass
#CommentFlag //  ; Joy3 = short Pass
#CommentFlag //  ; Joy4 = shoot