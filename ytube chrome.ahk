#Persistent
#NoEnv
#SingleInstance, Force
DetectHiddenWindows, On
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

controlN := 0

return

#IfWinNotActive, ahk_exe chrome.exe
z & space::
    chromeSend("{Space}")
return


z & right::
    chromeSend("{Right}")
return

z & left::
    chromeSend("{Left}")
return

chromeSend(keys)
{
    ControlGet, controlN, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
    ControlFocus,,ahk_id %controlN%
    Sleep, 50
    ControlSend, Chrome_RenderWidgetHostHWND1, %keys% , Google Chrome
}



#IfWinActive, ahk_exe chrome.exe
z & space::
    chromeSend("k")
return


z & right::
    chromeSend("{Right}")
return

z & left::
    chromeSend("{Left}")
return