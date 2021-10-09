#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


~LButton:: 
Click, down
while GetKeyState("LButton")
{
}
send ^c

ControlSend, Edit1, %clipboard% , Untitled - Notepad
return

~MButton::
click
send ^v 
return