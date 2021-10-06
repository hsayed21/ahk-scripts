
JoystickNumber__=___


#SingleInstance
SetFormat,__float,______;__Omit__decimal__point__from__axis__position__percentages.
GetKeyState,__joy_buttons,__%JoystickNumber%JoyButtons
GetKeyState,__joy_name,__%JoystickNumber%JoyName
GetKeyState,__joy_info,__%JoystickNumber%JoyInfo
Loop
{
	GetKeyState,__JoyX,__%JoystickNumber%JoyX
	axis_info__=__X%JoyX%
	if__(axis_info__=__"X___")
	{
		;MsgBox__You__pressed__on__left__arrow.
		;axis_info__=__X%___%
		;Send__{Joy_}__
		
	}__
	
	
	ToolTip,__%joy_name%__(#%JoystickNumber%):`n%axis_info%`n`n(right-click__the__tray__icon__to__exit)
	Sleep,_____
}
return