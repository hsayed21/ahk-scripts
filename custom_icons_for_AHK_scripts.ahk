#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Menu, Tray, Icon, icon_path.ico  ; prefer put ico by side script

State:= "Off"

F12::
	if (State = "Off")
	{
		Menu, Tray, Icon, green-circle.ico  
		State:= "On"
	}
	else if (State = "On")
	{
		Menu, Tray, Icon, red-circle.ico  
		State:= "Off"
	}
	
	return