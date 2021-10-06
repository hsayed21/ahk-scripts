#NoEnv__;__Recommended__for__performance__and__compatibility__with__future__AutoHotkey__releases.
#SingleInstance,Force
#Persistent

my_path:=__"C:`\Intel"

toggle=_

While__toggle
{
	
	IfWinExist,__ahk_class__CabinetWClass,__%my_path%
	{
		ToolTip,__is__opened
		WinSet,Style,-_xC_____,__A
		;WinSet,Disable,,ahk_class__CabinetWClass,__%my_path%
		;WinSet,Enable,,ahk_class__CabinetWClass,__%my_path%
	}
	
}
	