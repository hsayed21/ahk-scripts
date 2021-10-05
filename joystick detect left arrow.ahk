
JoystickNumber = 2


#SingleInstance
SetFormat, float, 03  ; Omit decimal point from axis position percentages.
GetKeyState, joy_buttons, %JoystickNumber%JoyButtons
GetKeyState, joy_name, %JoystickNumber%JoyName
GetKeyState, joy_info, %JoystickNumber%JoyInfo
Loop
{
	GetKeyState, JoyX, %JoystickNumber%JoyX
	axis_info = X%JoyX%
	if (axis_info = "X000")
	{
		;MsgBox You pressed on left arrow.
		;axis_info = X%100%
		;Send {Joy1} 
		
	} 
	
	
	ToolTip, %joy_name% (#%JoystickNumber%):`n%axis_info%`n`n(right-click the tray icon to exit)
	Sleep, 100
}
return