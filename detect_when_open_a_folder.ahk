
;~ run it with loop for alaways detect when open a folder
my_path:= "C:`\Intel"

IfWinExist, ahk_class CabinetWClass, %my_path%
{
	msgbox % "The folder is opened in Explorer"
	;WinMinimize, ahk_class CabinetWClass, %my_path%
	;WinClose, ahk_class CabinetWClass, %my_path%
	
}
else {
	msgbox % "Either Explorer or the folder is not opened"
}


