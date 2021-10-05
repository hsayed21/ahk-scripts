#SingleInstance, force
SetTitleMatchMode, RegEx

~LButton::
MouseGetPos,,,win,con
;MsgBox % win " - " con
if inStr(con,"VLC video output")
{
	;MsgBox, yes you press on  vlc output control
	ControlSend,, {space}, ahk_class Qt5QWindowIcon
	
}
return

Esc::ExitApp
