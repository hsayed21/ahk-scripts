#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
;__#Warn__;__Enable__warnings__to__assist__with__detecting__common__errors.
SendMode__Input__;__Recommended__for__new__scripts__due__to__its__superior__speed__and__reliability.
SetWorkingDir__%A_ScriptDir%__;__Ensures__a__consistent__starting__directory.

/*
	First__download__nircmd.exe
	can__do__a__lot__of__things__:)

*/


;Mute
F_::
	Run__nircmd.exe__mutesysvolume_____microphone
	return
	
	
;Unmute
F__::
	Run__nircmd.exe__mutesysvolume_____microphone
	return	
	
	
	
;Toggle
F__::
	Run__nircmd.exe__mutesysvolume_____microphone
	return