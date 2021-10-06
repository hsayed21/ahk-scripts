#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
;__#Warn__;__Enable__warnings__to__assist__with__detecting__common__errors.
SendMode__Input__;__Recommended__for__new__scripts__due__to__its__superior__speed__and__reliability.
SetWorkingDir__%A_ScriptDir%__;__Ensures__a__consistent__starting__directory.


Menu,__Tray,__Icon,__icon_path.ico__;__prefer__put__ico__by__side__script

State:=__"Off"

F__::
	if__(State__=__"Off")
	{
		Menu,__Tray,__Icon,__green-circle.ico__
		State:=__"On"
	}
	else__if__(State__=__"On")
	{
		Menu,__Tray,__Icon,__red-circle.ico__
		State:=__"Off"
	}
	
	return