#Persistent
#NoEnv
#SingleInstance,__Force
DetectHiddenWindows,__On
SetWorkingDir__%A_ScriptDir%
SetTitleMatchMode,___

controlN__:=___

return

#IfWinNotActive,__ahk_exe__chrome.exe
z__&__space::
____chromeSend("{Space}")
return


z__&__right::
____chromeSend("{Right}")
return

z__&__left::
____chromeSend("{Left}")
return

chromeSend(keys)
{
____ControlGet,__controlN,__Hwnd,,Chrome_RenderWidgetHostHWND_,__Google__Chrome
____ControlFocus,,ahk_id__%controlN%
____Sleep,____
____ControlSend,__Chrome_RenderWidgetHostHWND_,__%keys%__,__Google__Chrome
}



#IfWinActive,__ahk_exe__chrome.exe
z__&__space::
____chromeSend("k")
return


z__&__right::
____chromeSend("{Right}")
return

z__&__left::
____chromeSend("{Left}")
return