;;__List__Files__and__Folders__Sorted__(By__Num)
/*
#singleInstance,__force
result__=__
folderNames__=__
fileNames__=__
path__=__C:\Users\HS\Downloads\Intermediate__AutoHotkey\[__DevCourseWeb.com__]__Intermediate__AutoHotkey__-__Windows__Desktop__Automation__(RPA)
Loop,__Files,__%path%\*.*,__D
{
	folderNames__.=__A_LoopFileName__"`n"
}
Sort,__folderNames,__N

Loop,__parse,__folderNames,__"`n"
{
	folderName__:=__A_LoopField
	folderIndex__:=__A_Index
	Loop,__Files,__%path%\%folderName%\*.*,__F
	{
		if__(A_LoopFileExt__=__"mp_")
		{
			filename__:=__SubStr(A_LoopFileName,_,StrLen(A_LoopFileName)-_)
			;~__filename__:=__StrReplace(filename,"---__[__DevCourseWeb.com__]__---","")
			fileNames__.=__filename__"`n"
		}
	}
	Sort,__fileNames,__N
	Loop,__parse,__fileNames,__"`n"
	{
		result__.=__"-__[__]__["__folderName__"__#"__folderIndex__"]__"__A_LoopField__"`n"
	}
	fileNames__=__
}

Clipboard:=__result

return
Esc::ExitApp
*/
;;__Get__Files__Content__From__a__Specific__Folder__(obsidain)
;~__/*
#singleInstance,__force
result_Lec=
result_Code=
fileNames=
path__=__F:\_S\IS\ZNotes\My_Plan_____\Ethical__Hacking\__-__Linux\RH____RHEL___(Admin___)
Loop,__Files,__%path%\*.*,__F
{
	fileNames__.=__A_LoopFileName__"`n"
}
Sort,__fileNames,__p___N__D
;~__MsgBox__%__fileNames
Loop,__parse,__fileNames,__"`n"
{
	fext__:=__SubStr(A_LoopField,StrLen(A_LoopField)-_,StrLen(A_LoopField))
	if__(fext__==__"txt")
	{
		filename__:=__SubStr(A_LoopField,_,StrLen(A_LoopField)-_)
		FileRead,Rfile,__%path%\%A_LoopField%
		result_Lec__.=__"-__[__]__"__filename__"`n"
		result_Code__.=__"#####__"__filename__"`n``````__`n"__Rfile__"`n``````__`n`n"
	}
}

result__:=__"#__<u>Lectures:</u>`n"__result_Lec__"`n#__<u>Codes:</u>__`n"__result_Code
Clipboard:=__result__
	
return
Esc::ExitApp

;~__*/














