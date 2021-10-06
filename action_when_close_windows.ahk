#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
#SingleInstance,Force
#Persistent

SetTitleMatchMode,_
;Path_Settings:="C:\Users\HS\Documents\KONAMI\PRO__EVOLUTION__SOCCER______\settings.dat"


	while(_){
		if__WinExist("ahk_exe__Settings.exe"){
			WinWait,__Settings__-__PRO__EVOLUTION__SOCCER______
			WinWaitClose__;__Wait__for__the__exact__window__found__by__WinWait__to__be__closed.
			;MsgBox,__Windows__is__now__closed.
			if__FileExist("C:\Users\HS\Documents\KONAMI\PRO__EVOLUTION__SOCCER______\settings.dat"){
				;MsgBox,__file__is__found
				FileDelete,__C:\Users\HS\Documents\KONAMI\PRO__EVOLUTION__SOCCER______\settings.dat
				;MsgBox,__file__is__delete
				FileCopy,__C:\Users\HS\Documents\KONAMI\settings.dat,__C:\Users\HS\Documents\KONAMI\PRO__EVOLUTION__SOCCER______\
				;MsgBox,__file__is__copy
			}
			Sleep,______
		}
		
	}



	