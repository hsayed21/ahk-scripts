#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
;__#Warn__;__Enable__warnings__to__assist__with__detecting__common__errors.
SendMode__Input__;__Recommended__for__new__scripts__due__to__its__superior__speed__and__reliability.
SetWorkingDir__%A_ScriptDir%__;__Ensures__a__consistent__starting__directory.


`::
clipInfo__:=__Clipboard__;__Get__the__text__from__the__current__clipboard
Clipboard__:=__""__;__clear__clipboard
Send__^c__;__copy__the__file,__which__will__give__its__full__path
Clipwait,_____;__wait__a__second__for__the__clipboard__to__have__contents__(why__we__must__clear__first)
IF__(!ErrorLevel)__{__;__If__clipboard__contains__something__after__a__second
	filePath__:=__Clipboard__;__store__the__filepath__of__the__highlghted__file
	;__Method___
	;if__WinActive("ahk_exe__WINWORD.EXE")
	;	send__^v
	;__else
	;	WinActivate,__ahk_exe__WINWORD.EXE
	;	WinWait,__ahk_exe__WINWORD.EXE__;__Wait__for__it__to__appear.
	;	send__^v__
	;sleep_______;__wait__for__the__paste__to__be__over
	;Send,__{Enter}
	
	ControlSend,___WwG_,__%clipboard%__,__ahk_exe__WINWORD.EXE
	ControlSend,___WwG_,__{Enter}__,__ahk_exe__WINWORD.EXE
	
	
}
Clipboard__:=__clipInfo__;__make__clipboard__equal__the__original__contents__again.
Return

~Esc::ExitApp