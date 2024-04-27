/******************************************
 * @file StringBuilder.ahk
 * @description: Most of the time, I need to convert a list of sql queries to a StringBuilder object in C#.
 * @author hsayed
 * @date 2024-04-27
 ******************************************/
#Requires Autohotkey v2.0
#SingleInstance Force
 
result := ""
Loop Parse, A_Clipboard, "`r`n"
{
    ; if line is not empty
    if (A_LoopField = "")
        continue
    ; if line is not a comment
    if (SubStr(A_loopField, 1 , 2) = "--")
        continue

    result .= "sb.AppendLine(" . '"' . A_LoopField . '"'  . ");" . "`r`n"
}

A_Clipboard := result
