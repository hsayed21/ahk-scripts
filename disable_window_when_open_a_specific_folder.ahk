#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
#Persistent


#singleInstance, force
#Persistent

stat = Disable
Loop
{
   if (winActive("ahk_class CabinetWClass"))
   {
      WinGet, winid , ID, A ;
      ControlGetText, currentPath, ToolbarWindow323,  ahk_id %winid%
      if (inStr(currentPath, "eFootball PES 2021"))
      {
         ;MsgBox, url contains Drives
         WinSet, %stat% ,, ahk_id %winid%
         ;WinSet, Enable ,, ahk_id %winid%
         ;break
      }
      ;MsgBox, is active
   }
   Sleep 200
}
return
   
RCtrl & NumpadDiv::
if (stat == "Disable")
{
   stat = Enable
}
else if (stat == "Enable")
{
   stat = Disable
}

return


/* Other Way

my_path:= "C:`\Intel"

toggle=1

While toggle
{
	
	IfWinExist, ahk_class CabinetWClass, %my_path%
	{
		ToolTip, is opened
		WinSet,Disable,,ahk_class CabinetWClass, %my_path%
		;WinSet,Enable,,ahk_class CabinetWClass, %my_path%
	}
	
}

*/