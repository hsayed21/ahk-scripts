#SingleInstance, Force
CoordMode, Mouse, Screen

LButton::
	MouseGetPos, x, y
	x_ := x + 50
	y_ := y - 50
	Tooltip, % "x: " x "`ny: " y
	MouseMove, %x_%,%y_%
return 

ESC::ExitApp