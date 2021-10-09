#SingleInstance, force
#Persistent

;~ ~LButton::
;~ if (a_timesincepriorhotkey != -1 && a_timesincepriorhotkey < 200)
	;~ cnt += 1
;~ else if (a_timesincepriorhotkey > 400)
	;~ cnt := 0

;~ if (cnt == 1)
	;~ MsgBox, double click


;~ return

;~ keywait, LButton, t0.5
;~ if errorlevel = 1
;~ {
	;~ msgbox hold
;~ return
;~ }
;~ else
	;~ keywait, LButton, d, t0.5
;~ if errorlevel = 0
;~ {
	;~ msgbox double
;~ return
;~ }
;~ else {
	;~ MouseClick,R		; add this line when you want to RClick after action
	;~ msgbox nothing
;~ return
;~ }

;; pause/resume when click
~LButton::

MouseGetPos,,,win,con
if inStr(con,"VLC video output")
{
	if (a_timesincepriorhotkey != -1 && a_timesincepriorhotkey < 200)
		cnt += 1
	else if (a_timesincepriorhotkey > 400)
		cnt := 0

	if (cnt == 1)
	{
		;MsgBox, double click
		click,2
		return
	}
	ControlSend,, {space}, ahk_class Qt5QWindowIcon
}
return

;; pause/resume when Alt+z
!z::
ControlSend,, {space}, ahk_class Qt5QWindowIcon
return

;; backward 10 sec 
!Left::
ControlSend,,{Left},ahk_exe vlc.exe
return

;; forward 10 sec
!Right::
ControlSend,,{Right},ahk_exe vlc.exe
return

;Esc::ExitApp