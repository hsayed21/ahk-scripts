#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
;__#Warn__;__Enable__warnings__to__assist__with__detecting__common__errors.
SendMode__Input__;__Recommended__for__new__scripts__due__to__its__superior__speed__and__reliability.
SetWorkingDir__%A_ScriptDir%__;__Ensures__a__consistent__starting__directory.


~LButton::__
Click,__down
while__GetKeyState("LButton")
{
}
send__^c

ControlSend,__Edit_,__%clipboard%__,__Untitled__-__Notepad
return

~MButton::
click
send__^v__
return