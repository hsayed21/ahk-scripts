#SingleInstance,__force
#Persistent

;~__~LButton::
;~__if__(a_timesincepriorhotkey__!=__-___&&__a_timesincepriorhotkey__<_____)
	;~__cnt__+=___
;~__else__if__(a_timesincepriorhotkey__>_____)
	;~__cnt__:=___

;~__if__(cnt__==___)
	;~__MsgBox,__double__click


;~__return

;~__keywait,__LButton,__t_._
;~__if__errorlevel__=___
;~__{
	;~__msgbox__hold
;~__return
;~__}
;~__else
	;~__keywait,__LButton,__d,__t_._
;~__if__errorlevel__=___
;~__{
	;~__msgbox__double
;~__return
;~__}
;~__else__{
	;~__MouseClick,R		;__add__this__line__when__you__want__to__RClick__after__action
	;~__msgbox__nothing
;~__return
;~__}

;;__pause/resume__when__click
~LButton::

MouseGetPos,,,win,con
if__inStr(con,"VLC__video__output")
{
	if__(a_timesincepriorhotkey__!=__-___&&__a_timesincepriorhotkey__<_____)
		cnt__+=___
	else__if__(a_timesincepriorhotkey__>_____)
		cnt__:=___

	if__(cnt__==___)
	{
		;MsgBox,__double__click
		click,_
		return
	}
	ControlSend,,__{space},__ahk_class__Qt_QWindowIcon
}
return

;;__pause/resume__when__Alt+z
!z::
ControlSend,,__{space},__ahk_class__Qt_QWindowIcon
return

;;__backward______sec__
!Left::
ControlSend,,{Left},ahk_exe__vlc.exe
return

;;__forward______sec
!Right::
ControlSend,,{Right},ahk_exe__vlc.exe
return

;Esc::ExitApp