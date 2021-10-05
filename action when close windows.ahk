#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
#Persistent

SetTitleMatchMode,2
;Path_Settings:="C:\Users\HS\Documents\KONAMI\PRO EVOLUTION SOCCER 2019\settings.dat"


	while(1){
		if WinExist("ahk_exe Settings.exe"){
			WinWait, Settings - PRO EVOLUTION SOCCER 2019
			WinWaitClose  ; Wait for the exact window found by WinWait to be closed.
			;MsgBox, Windows is now closed.
			if FileExist("C:\Users\HS\Documents\KONAMI\PRO EVOLUTION SOCCER 2019\settings.dat"){
				;MsgBox, file is found
				FileDelete, C:\Users\HS\Documents\KONAMI\PRO EVOLUTION SOCCER 2019\settings.dat
				;MsgBox, file is delete
				FileCopy, C:\Users\HS\Documents\KONAMI\settings.dat, C:\Users\HS\Documents\KONAMI\PRO EVOLUTION SOCCER 2019\
				;MsgBox, file is copy
			}
			Sleep, 9000
		}
		
	}



	