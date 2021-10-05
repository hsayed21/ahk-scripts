#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
~LButton::
{	KeyWait, LButton, T0.5 ;Wait for half sec to start copying things.
	If ErrorLevel
	{	SoundBeep, 100, 10
		;IfWinActive, ahk_exe WINWORD.EXE
		;{	Keywait, LButton ;Wait for LButton to be released
		Send, ^c
		;}
		IfWinActive, ahk_exe firefox.exe ;If you are not using FireFox, just make sure to Replace ahk_exe firefox.exe with the internet browser you are using Gmail with.
		{	Keywait, LButton ;Wait for LButton to be released
			Send, ^v
}	}	} Return
~Esc::ExitApp