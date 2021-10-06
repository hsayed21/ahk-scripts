ToggleKeys__:=___

Hotkey,__Joy_,__PlaySound_,__On
Hotkey,__JOy_,__PlaySound_,__On
return

PlaySound_:
SoundPlay,__C:\WINDOWS\Media\chimes.wav
Return

PlaySound_:
SoundPlay,__C:\WINDOWS\Media\chord.wav
Return

^F_::	;__Ctrl+F___disables__hotkeys.
ToggleKeys__:=__!ToggleKeys
If__ToggleKeys
{
	Hotkey,__Joy_,__PlaySound_,__On
	Hotkey,__Joy_,__PlaySound_,__On
}
Else
{
	Hotkey,__Joy_,__PlaySound_,__Off
	Hotkey,__Joy_,__PlaySound_,__Off
}
return


#CommentFlag__//__;__Joy___=__Sroo
#CommentFlag__//__;__Joy___=__Long__Pass
#CommentFlag__//__;__Joy___=__short__Pass
#CommentFlag__//__;__Joy___=__shoot