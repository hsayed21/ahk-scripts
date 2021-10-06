#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
;__#Warn__;__Enable__warnings__to__assist__with__detecting__common__errors.
SendMode__Input__;__Recommended__for__new__scripts__due__to__its__superior__speed__and__reliability.
SetWorkingDir__%A_ScriptDir%__;__Ensures__a__consistent__starting__directory.

#SingleInstance__Force
~LButton::
{	KeyWait,__LButton,__T_.___;Wait__for__half__sec__to__start__copying__things.
	If__ErrorLevel
	{	SoundBeep,_____,____
		;IfWinActive,__ahk_exe__WINWORD.EXE
		;{	Keywait,__LButton__;Wait__for__LButton__to__be__released
		Send,__^c
		;}
		IfWinActive,__ahk_exe__firefox.exe__;If__you__are__not__using__FireFox,__just__make__sure__to__Replace__ahk_exe__firefox.exe__with__the__internet__browser__you__are__using__Gmail__with.
		{	Keywait,__LButton__;Wait__for__LButton__to__be__released
			Send,__^v
}	}	}__Return
~Esc::ExitApp