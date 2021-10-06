#SingleInstance,__force
SetTitleMatchMode,__RegEx

~LButton::
MouseGetPos,,,win,con
;MsgBox__%__win__"__-__"__con
if__inStr(con,"VLC__video__output")
{
	;MsgBox,__yes__you__press__on__vlc__output__control
	ControlSend,,__{space},__ahk_class__Qt_QWindowIcon
	
}
return

Esc::ExitApp
