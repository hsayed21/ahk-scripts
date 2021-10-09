#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


`::
clipInfo := Clipboard ; Get the text from the current clipboard
Clipboard := "" ; clear clipboard
Send ^c ; copy the file, which will give its full path
Clipwait, 1 ; wait a second for the clipboard to have contents (why we must clear first)
IF (!ErrorLevel) { ; If clipboard contains something after a second
	filePath := Clipboard ; store the filepath of the highlghted file
	; Method 2
	;if WinActive("ahk_exe WINWORD.EXE")
	;	send ^v
	;  else
	;	WinActivate, ahk_exe WINWORD.EXE
	;	WinWait, ahk_exe WINWORD.EXE  ; Wait for it to appear.
	;	send ^v 
	;sleep 200 ; wait for the paste to be over
	;Send, {Enter}
	
	ControlSend, _WwG1, %clipboard% , ahk_exe WINWORD.EXE
	ControlSend, _WwG1, {Enter} , ahk_exe WINWORD.EXE
	
	
}
Clipboard := clipInfo ; make clipboard equal the original contents again.
Return

~Esc::ExitApp