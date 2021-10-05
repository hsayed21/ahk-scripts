#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
	First download nircmd.exe
	can do a lot of things :)

*/


;Mute
F9::
	Run nircmd.exe mutesysvolume 1 microphone
	return
	
	
;Unmute
F10::
	Run nircmd.exe mutesysvolume 0 microphone
	return	
	
	
	
;Toggle
F11::
	Run nircmd.exe mutesysvolume 2 microphone
	return