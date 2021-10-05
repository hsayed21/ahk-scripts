;Blank all monitors
;Copyright Stephen Millard - thoughtasylum.com
;For more information see http://www.thoughtasylum.com/blog/2014/7/30/blank-all-of-your-screens-with-an-autohotkey-script.html
;Press CTRL+WIN+b to blank screen
;Press SHIFT+CTRL+WIN+b to set screen blanking colour

#Include Lib-Colours.ahk


;Set global colour variable and default to black
InitBlankScreen()
{
    global strBlankColour, strBlankColourValue
    if strBlankColour = 
        strBlankColour = Black
    if strBlankColourValue = 
        strBlankColourValue = Black
}


;Blank all screens
;Ctrl+Win+b
^#b::
;Initialise
InitBlankScreen()
global strBlankColourValue

;Set a new window to have a background colour and remove its chrome
Gui, Color, %strBlankColourValue%
Gui, +ToolWindow -Caption +AlwaysOnTop


;The virtual screen is the bounding rectangle of all display monitors.
;We need an x & y origin and the height & width to create our overlay.
SysGet, intOriginX, 76
SysGet, intOriginY, 77
SysGet, intWidth, 78
SysGet, intHeight, 79

;Display the overlay until user presses ESC key
Gui, show, x%intOriginX% y%intOriginY% w%intWidth% h%intHeight%, NA
return


; Create a pop-up menu.
BuildBlankScreenColourMenu()
{
    ;Initialise
    InitBlankScreen()
    global strBlankColour
    
    Menu, menuBlankScreen, Add
    Menu, menuBlankScreen, DeleteAll
    
    ;Add a header to the menu
    Menu, menuBlankScreen, Add, Select Blank Screen Colour, MenuHandler
    Menu, menuBlankScreen, Disable, Select Blank Screen Colour
    Menu, menuBlankScreen, Add
    
    ;Add colours to the menu
    Menu, menuBlankScreen, Add, Black, MenuHandler
    Menu, menuBlankScreen, Add, Red, MenuHandler
    Menu, menuBlankScreen, Add, Blue, MenuHandler
    Menu, menuBlankScreen, Add, Green, MenuHandler
    Menu, menuBlankScreen, Add, Orange, MenuHandler
    Menu, menuBlankScreen, Add, Yellow, MenuHandler
    Menu, menuBlankScreen, Add, Purple, MenuHandler
    Menu, menuBlankScreen, Add, Silver, MenuHandler
    Menu, menuBlankScreen, Add, White, MenuHandler
    Menu, menuBlankScreen, Add, Custom, MenuHandler
    
    ;Set a check mark against the colour to be used
    Menu, menuBlankScreen, Check, %strBlankColour%
    
    return
}


;Process the menu selection
MenuHandler:
;Initialise
InitBlankScreen()
global strBlankColour, strBlankColourValue

;Uncheck the current blanking colour in the menu
;Menu, menuBlankScreen, Uncheck, %strBlankColour%

;Set the colour as the selected menu item
strBlankColour = %A_ThisMenuItem%
strBlankColourValue = %A_ThisMenuItem%

;Override for any non-standard colours
IfEqual, strBlankColour, Orange
{
    strBlankColourValue = FF6600
}

;For a custom colour use a standard OS colour picker
IfEqual, strBlankColour, Custom
{
    SetFormat IntegerFast, H

    Colours := [0x00FF00, 0xFF0000, 0xFF00FF]
    SelectedColour := ChooseColor(0x80FF, GuiHwnd, , , Colours*)
    
    IfEqual, ErrorLevel, 0x0
    {
        StringTrimLeft, SelectedColour, SelectedColour, 2
        strBlankColourValue = %SelectedColour%
    }
    Else
    {
        ;Default to black because it was cancelled
        strBlankColour = Black
        strBlankColourValue = Black
    }
   
}

return


;Display pop-up menu
;Shift+Ctrl+Win+b
+^#b::
BuildBlankScreenColourMenu()
Menu, menuBlankScreen, Show 
return

Esc::ExitApp
return