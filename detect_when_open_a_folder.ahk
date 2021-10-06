
;~__run__it__with__loop__for__alaways__detect__when__open__a__folder
my_path:=__"C:`\Intel"

IfWinExist,__ahk_class__CabinetWClass,__%my_path%
{
	msgbox__%__"The__folder__is__opened__in__Explorer"
	;WinMinimize,__ahk_class__CabinetWClass,__%my_path%
	;WinClose,__ahk_class__CabinetWClass,__%my_path%
	
}
else__{
	msgbox__%__"Either__Explorer__or__the__folder__is__not__opened"
}


