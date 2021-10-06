#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
#SingleInstance,Force
#Persistent


#singleInstance,__force
#Persistent

stat__=__Disable
Loop
{
____if__(winActive("ahk_class__CabinetWClass"))
____{
______WinGet,__winid__,__ID,__A__;
______ControlGetText,__currentPath,__ToolbarWindow___,__ahk_id__%winid%
______if__(inStr(currentPath,__"eFootball__PES______"))
______{
__________;MsgBox,__url__contains__Drives
__________WinSet,__%stat%__,,__ahk_id__%winid%
__________;WinSet,__Enable__,,__ahk_id__%winid%
__________;break
______}
______;MsgBox,__is__active
____}
____Sleep_____
}
return
____
RCtrl__&__NumpadDiv::
if__(stat__==__"Disable")
{
____stat__=__Enable
}
else__if__(stat__==__"Enable")
{
____stat__=__Disable
}

return


/*__Other__Way

my_path:=__"C:`\Intel"

toggle=_

While__toggle
{
	
	IfWinExist,__ahk_class__CabinetWClass,__%my_path%
	{
		ToolTip,__is__opened
		WinSet,Disable,,ahk_class__CabinetWClass,__%my_path%
		;WinSet,Enable,,ahk_class__CabinetWClass,__%my_path%
	}
	
}

*/