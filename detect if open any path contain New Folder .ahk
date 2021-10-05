q::
GroupAdd, vGroupFolder, ahk_class CabinetWClass
GroupAdd, vGroupFolder, ahk_class ExploreWClass
SetTitleMatchMode, 3
hWnd1 := WinExist("New Folder ahk_group vGroupFolder")
hWnd2 := WinExist("New Folder (2) ahk_group vGroupFolder")
if (hWnd1 && hWnd2)
MsgBox % "both windows exist"
else
MsgBox % "at least one window doesn't exist"
Return