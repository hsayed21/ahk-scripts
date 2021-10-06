#SingleInstance,__Force
CoordMode,__Mouse,__Screen

LButton::
	MouseGetPos,__x,__y
	x___:=__x__+____
	y___:=__y__-____
	Tooltip,__%__"x:__"__x__"`ny:__"__y
	MouseMove,__%x_%,%y_%
return__

ESC::ExitApp