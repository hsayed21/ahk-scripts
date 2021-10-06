#SingleInstance__force

;;__Save__output__cmd__command
;~__MsgBox__%__RunWaitOne("dir__"__A_ScriptDir)
;~__RunWaitOne(command)__{
____;~__shell__:=__ComObjCreate("WScript.Shell")
____;~__exec__:=__shell.Exec(ComSpec__"__/C__"__command)
____;~__return__exec.StdOut.ReadAll()
;~__}


times__:=__ComObjCreate("WScript.Shell").Exec("cmd.exe__/q__/c__youtube-dl.exe__--flat-playlist__--get-duration__https://www.youtube.com/playlist?list=PLfHPAKSz_DJqmJJIW_P_DM_hMlaP__ivp").StdOut.ReadAll()

timer_work__:=_____;_____hour__in__day
sum_hour__:=___
sum_min__:=___
sum_sec__:=___

Loop,__Parse,__times,__`n
{
	;;;;;__Count__char__in__string__;;;;;;
	;way_
	;~__str__=__the__dog__went__for__a__run__with__another__dog
	;~__match__=__dog
	;~__msgbox__%__"Found__"__(__count,__regexReplace(__str
			__;~__,__"("__match__")",__match,__count__))
			__;~__.__"__instance"__(__count!=___?__"s"__:__""__)
			__;~__.__"__of__"__match__"."
			__
	;way_
	word__:=__":"__
	var__:=__A_loopfield
	StringReplace,__var,__var,__%word%,__%word%,__UseErrorLevel
	count__:=__ErrorLevel
	if__(count__==___)
	{
		;_____=__h,m,s
		arr__:=__StrSplit(A_loopfield,__":")
		sum_hour__+=__arr[_]
		sum_min__+=__arr[_]
		sum_sec__+=__arr[_]
	}
	else__if__(count__==___)
	{
		;_____=__m,s
		arr__:=__StrSplit(A_loopfield,__":")
		sum_min__+=__arr[_]
		sum_sec__+=__arr[_]
	}
	
}
calc__:=__sum_hour__+__(sum_min__/____)__+__(sum_sec__/______)
finished__:=__calc__/__timer_work
result__=__
(
%sum_hour%__hours
%sum_min%__minutes
%sum_sec%__seconds
-----------------
total__of__hours__=__%calc%
%timer_work%__hours__in__day__=>__finished__in__%finished%__days
)
MsgBox__%__result

return
Esc::ExitApp



