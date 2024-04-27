/*
*****************************************
* @file GetFormName.ahk
* @description: Get name of the form under the mouse cursor
* @author hsayed
* @date 2024-03-30
******************************************
*/

#Requires AutoHotkey v2.0
#SingleInstance force
#include Lib\UIA.ahk
#WinActivateForce
SetWorkingDir A_ScriptDir
SetControlDelay(-1)
SetWinDelay(-1)
SetDefaultMouseSpeed(0)

SetTimer(GetFormNameUnderMouse, 100)
return

GetFormNameUnderMouse()
{
    try
    {
        el := UIA.ElementFromPoint()
        winEl := el.WalkTree("n", { Type: "Window"}).Highlight()
        ToolTip("Form Class: " winEl.AutomationId "`n`nPress ESC to copy and exit")
        global winFormName := winEl.AutomationId
    }
    catch
    {
        return
    }
}

Esc::
{
    A_Clipboard := winFormName
    ExitApp
}
