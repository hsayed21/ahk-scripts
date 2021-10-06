#Persistent
#NoEnv
#SingleInstance,__Force

SetTitleMatchMode,___

;ahk_class__MozillaWindowClass
;ahk_class__Chrome_WidgetWin__


z__&__space::
	if__WinExist("ahk_class__MozillaWindowClass"){
		WinActivate,__ahk_class__MozillaWindowClass
		Send,__k
	}
return


z__&__left::
	if__WinExist("ahk_class__MozillaWindowClass"){
		WinActivate,__ahk_class__MozillaWindowClass
		Send,__{Left}
	}
return


z__&__right::
	if__WinExist("ahk_class__MozillaWindowClass"){
		WinActivate,__ahk_class__MozillaWindowClass
		Send,__{Right}
	}
return


