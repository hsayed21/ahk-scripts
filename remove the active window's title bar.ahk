#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
#Persistent

my_path:= "C:`\Intel"

toggle=1

While toggle
{
	
	IfWinExist, ahk_class CabinetWClass, %my_path%
	{
		ToolTip, is opened
		WinSet,Style,-0xC00000, A
		;WinSet,Disable,,ahk_class CabinetWClass, %my_path%
		;WinSet,Enable,,ahk_class CabinetWClass, %my_path%
	}
	
}
	