`::
if WinActive("ahk_class PotPlayer64")
{
	Send {Space}
	WinActivate, ahk_exe ONENOTE.EXE
	WinWait, ahk_exe ONENOTE.EXE  ; Wait for it to appear.
}
else
{
	WinActivate, ahk_class PotPlayer64
	WinWait, ahk_class PotPlayer64  ; Wait for it to appear.
	Send {Space}
	WinActivate, ahk_exe ONENOTE.EXE
	WinWait, ahk_exe ONENOTE.EXE  ; Wait for it to appear.
}	
return