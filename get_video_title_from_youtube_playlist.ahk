#SingleInstance__force


result_Lec=
result_Code=

RunWait,__%ComSpec%__/c__""youtube-dl.exe"__"--flat-playlist"__"--get-title"__"https://www.youtube.com/playlist?list=PLfHPAKSz_DJqmJJIW_P_DM_hMlaP__ivp"__>"out_tmp.txt"",,Hide

FileRead,__titles,__out_tmp.txt
FileDelete,__out_tmp.txt

Loop,__Parse,__titles,__`n
{
	result_Lec__.=__"-__[__]__"__A_LoopField__"`n"
	result_Code__.=__"#####__"__A_LoopField__"`n``````autohotkey`n`n```````n"
	;~__MsgBox,__%__result_Code
}	
	
result__:=__"#__<u>Lectures:</u>`n"__result_Lec__"`n#__<u>Codes:</u>__`n"__result_Code
Clipboard:=__result__
	
return
Esc::ExitApp



