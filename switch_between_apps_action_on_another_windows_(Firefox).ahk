#Persistent
#NoEnv
#SingleInstance, Force

SetTitleMatchMode, 2

;ahk_class MozillaWindowClass
;ahk_class Chrome_WidgetWin_1


z & space::
	if WinExist("ahk_class MozillaWindowClass"){
		WinActivate, ahk_class MozillaWindowClass
		Send, k
	}
return


z & left::
	if WinExist("ahk_class MozillaWindowClass"){
		WinActivate, ahk_class MozillaWindowClass
		Send, {Left}
	}
return


z & right::
	if WinExist("ahk_class MozillaWindowClass"){
		WinActivate, ahk_class MozillaWindowClass
		Send, {Right}
	}
return


