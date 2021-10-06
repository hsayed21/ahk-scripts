#SingleInstance,__Force
;~__If__!A_IsAdmin
__;~__Run__*RunAs__"%A_ScriptFullPath%"

^!SPACE::__Gosub,__Alwaysontop

AlwaysonTop:
WinGet,__ExStyle,__ExStyle,__A
if__(ExStyle__&___x_)__{
__Winset,__Alwaysontop,__Off__,__A
}__else__{
__Winset,__Alwaysontop,__,__A
}
return