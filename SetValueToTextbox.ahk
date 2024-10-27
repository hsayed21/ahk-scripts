/*
*****************************************
* @file SetValueToTextbox.ahk
* @description: Set value to textbox include readonly
* @author hsayed
* @date 2024-10-27
******************************************
*/

#Requires AutoHotkey v2.0
#SingleInstance Force
#include Lib\UIA.ahk ;https://github.com/Descolada/UIA-v2
#WinActivateForce
SetWorkingDir A_ScriptDir
SetControlDelay(-1)
SetWinDelay(-1)
SetDefaultMouseSpeed(0)

^LButton::
{
	el := UIA.ElementFromPoint()
	MouseGetPos(&mouseX, &mouseY)
	editEl := UIA.ElementFromPoint(mouseX, mouseY)
	if (editEl.ControlType = UIA.ControlType.Edit)
		editEl.Highlight()
	
	currentText := editEl.Value
	result := InputBox("Enter new text:", "Modify Text", "h100", currentText)
	if (result.Value && result.Result = "OK")
	{
		editEl.Value := result.Value
		MsgBox("Text updated successfully")
	}
}

Esc:: ExitApp

