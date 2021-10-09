#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Auto copy clipboard
~Lshift::
TimeButtonDown = %A_TickCount%
; Wait for it to be released
Loop
{
   Sleep 10
   GetKeyState, LshiftState, Lshift, P
   if LshiftState = U  ; Button has been released.
      break
   elapsed = %A_TickCount%
   elapsed -= %TimeButtonDown%
   if elapsed > 200  ; Button was held down long enough
   {
      x0 = A_CaretX
      y0 = A_CaretY
      Loop
   {
     Sleep 20                    ; yield time to others
     GetKeyState keystate, Lshift
     IfEqual keystate, U, {
       x0 = A_CaretX
       y0 = A_CaretY
       break
     }
   }
   if (x-x0 > 5 or x-x0 < -5 or y-y0 > 5 or y-y0 < -5)
   {                             ; Caret has moved
      clip0 := ClipBoardAll      ; save old clipboard
      ;ClipBoard =
      Send ^c                    ; selection -> clipboard
      ClipWait 1, 1              ; restore clipboard if no data
	  
	  ControlSend, _WwG1, %clipboard% , ahk_exe WINWORD.EXE
	  ControlSend, _WwG1, {Enter} , ahk_exe WINWORD.EXE
	  
      IfEqual ClipBoard,, SetEnv ClipBoard, %clip0%
	  
	  sleep 200 ; wait for the paste to be over
	  
   }
      return
   }
}

~LButton::
TimeButtonDown = %A_TickCount%
; Wait for it to be released
Loop
{
   Sleep 10
   GetKeyState, LButtonState, LButton, P
   if LButtonState = U  ; Button has been released.
      break
   elapsed = %A_TickCount%
   elapsed -= %TimeButtonDown%
   if elapsed > 200  ; Button was held down too long, so assume it's not a double-click.
   {
      MouseGetPos x0, y0            ; save start mouse position
      Loop
   {
     Sleep 20                    ; yield time to others
     GetKeyState keystate, LButton
     IfEqual keystate, U, {
       MouseGetPos x, y          ; position when button released
       break
     }
   }
   if (x-x0 > 5 or x-x0 < -5 or y-y0 > 5 or y-y0 < -5)
   {                             ; mouse has moved
      clip0 := ClipBoardAll      ; save old clipboard
      ;ClipBoard =
      Send ^c                    ; selection -> clipboard
      ClipWait 1, 1              ; restore clipboard if no data
	  ControlSend, _WwG1, %clipboard% , ahk_exe WINWORD.EXE
	  ControlSend, _WwG1, {Enter} , ahk_exe WINWORD.EXE
	  
      IfEqual ClipBoard,, SetEnv ClipBoard, %clip0%
	  
	  sleep 200 ; wait for the paste to be over
	  
   }
      return
   }
}
; Otherwise, button was released quickly enough.  Wait to see if it's a double-click:
TimeButtonUp = %A_TickCount%
Loop
{
   Sleep 10
   GetKeyState, LButtonState, LButton, P
   if LButtonState = D  ; Button has been pressed down again.
      break
   elapsed = %A_TickCount%
   elapsed -= %TimeButtonUp%
   if elapsed > 350  ; No click has occurred within the allowed time, so assume it's not a double-click.
   {
      ;MouseClick, Left
      return
   }
}
; Since above didn't return, it's a double-click:
Sleep, 10
Send, ^c
ClipWait
ControlSend, _WwG1, %clipboard% , ahk_exe WINWORD.EXE
ControlSend, _WwG1, {Enter} , ahk_exe WINWORD.EXE

sleep 200 ;

return