
JoystickNumber = 2
Joy2::
Send {Left down}  ; Hold down the left-arrow key.
KeyWait Joy2  ; Wait for the user to release the joystick button.
Send {Left up}  ; Release the left-arrow key.
return