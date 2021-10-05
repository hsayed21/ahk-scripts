#SingleInstance force

;; Save output cmd command
;~ MsgBox % RunWaitOne("dir " A_ScriptDir)
;~ RunWaitOne(command) {
    ;~ shell := ComObjCreate("WScript.Shell")
    ;~ exec := shell.Exec(ComSpec " /C " command)
    ;~ return exec.StdOut.ReadAll()
;~ }


times := ComObjCreate("WScript.Shell").Exec("cmd.exe /q /c youtube-dl.exe --flat-playlist --get-duration https://www.youtube.com/playlist?list=PLfHPAKSz_DJqmJJIW1P3DM9hMlaP24ivp").StdOut.ReadAll()

timer_work := 4 ; 4 hour in day
sum_hour := 0
sum_min := 0
sum_sec := 0

Loop, Parse, times, `n
{
	;;;;; Count char in string ;;;;;;
	;way1
	;~ str = the dog went for a run with another dog
	;~ match = dog
	;~ msgbox % "Found " ( count, regexReplace( str
			 ;~ , "(" match ")", match, count ))
			 ;~ . " instance" ( count!=1 ? "s" : "" )
			 ;~ . " of " match "."
			 
	;way2
	word := ":" 
	var := A_loopfield
	StringReplace, var, var, %word%, %word%, UseErrorLevel
	count := ErrorLevel
	if (count == 2)
	{
		; 2 = h,m,s
		arr := StrSplit(A_loopfield, ":")
		sum_hour += arr[1]
		sum_min += arr[2]
		sum_sec += arr[3]
	}
	else if (count == 1)
	{
		; 1 = m,s
		arr := StrSplit(A_loopfield, ":")
		sum_min += arr[1]
		sum_sec += arr[2]
	}
	
}
calc := sum_hour + (sum_min / 60) + (sum_sec / 3600)
finished := calc / timer_work
result = 
(
%sum_hour% hours
%sum_min% minutes
%sum_sec% seconds
-----------------
total of hours = %calc%
%timer_work% hours in day => finished in %finished% days
)
MsgBox % result

return
Esc::ExitApp



