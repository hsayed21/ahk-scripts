#SingleInstance force


result_Lec=
result_Code=

RunWait, %ComSpec% /c ""youtube-dl.exe" "--flat-playlist" "--get-title" "https://www.youtube.com/playlist?list=PLfHPAKSz_DJqmJJIW1P3DM9hMlaP24ivp" >"out_tmp.txt"",,Hide

FileRead, titles, out_tmp.txt
FileDelete, out_tmp.txt

Loop, Parse, titles, `n
{
	result_Lec .= "- [ ] " A_LoopField "`n"
	result_Code .= "##### " A_LoopField "`n``````autohotkey`n`n```````n"
	;~ MsgBox, % result_Code
}	
	
result := "# <u>Lectures:</u>`n" result_Lec "`n# <u>Codes:</u> `n" result_Code
Clipboard:= result 
	
return
Esc::ExitApp



