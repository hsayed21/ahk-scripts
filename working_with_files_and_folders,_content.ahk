;; List Files and Folders Sorted (By Num)
/*
#singleInstance, force
result = 
folderNames = 
fileNames = 
path = C:\Users\HS\Downloads\Intermediate AutoHotkey\[ DevCourseWeb.com ] Intermediate AutoHotkey - Windows Desktop Automation (RPA)
Loop, Files, %path%\*.*, D
{
	folderNames .= A_LoopFileName "`n"
}
Sort, folderNames, N

Loop, parse, folderNames, "`n"
{
	folderName := A_LoopField
	folderIndex := A_Index
	Loop, Files, %path%\%folderName%\*.*, F
	{
		if (A_LoopFileExt = "mp4")
		{
			filename := SubStr(A_LoopFileName,1,StrLen(A_LoopFileName)-4)
			;~ filename := StrReplace(filename,"--- [ DevCourseWeb.com ] ---","")
			fileNames .= filename "`n"
		}
	}
	Sort, fileNames, N
	Loop, parse, fileNames, "`n"
	{
		result .= "- [ ] [" folderName " #" folderIndex "] "  A_LoopField "`n"
	}
	fileNames = 
}

Clipboard:= result

return
Esc::ExitApp
*/
;; Get Files Content From a Specific Folder (obsidain)
;~ /*
#singleInstance, force
result_Lec=
result_Code=
fileNames=
path = F:\7S\IS\ZNotes\My_Plan_2020\Ethical Hacking\00- Linux\RH124_RHEL7 (Admin 1)
Loop, Files, %path%\*.*, F
{
	fileNames .= A_LoopFileName "`n"
}
Sort, fileNames, p8 N D
;~ MsgBox % fileNames
Loop, parse, fileNames, "`n"
{
	fext := SubStr(A_LoopField,StrLen(A_LoopField)-2,StrLen(A_LoopField))
	if (fext == "txt")
	{
		filename := SubStr(A_LoopField,1,StrLen(A_LoopField)-4)
		FileRead,Rfile, %path%\%A_LoopField%
		result_Lec .= "- [ ] " filename "`n"
		result_Code .= "##### " filename "`n`````` `n" Rfile "`n`````` `n`n"
	}
}

result := "# <u>Lectures:</u>`n" result_Lec "`n# <u>Codes:</u> `n" result_Code
Clipboard:= result 
	
return
Esc::ExitApp

;~ */














