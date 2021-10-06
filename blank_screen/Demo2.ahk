;Blank__all__monitors
;Copyright__Stephen__Millard__-__thoughtasylum.com
;For__more__information__see__http://www.thoughtasylum.com/blog/____/_/__/blank-all-of-your-screens-with-an-autohotkey-script.html
;Press__CTRL+WIN+b__to__blank__screen
;Press__SHIFT+CTRL+WIN+b__to__set__screen__blanking__colour

#Include__Lib-Colours.ahk


;Set__global__colour__variable__and__default__to__black
InitBlankScreen()
{
____global__strBlankColour,__strBlankColourValue
____if__strBlankColour__=__
________strBlankColour__=__Black
____if__strBlankColourValue__=__
________strBlankColourValue__=__Black
}


;Blank__all__screens
;Ctrl+Win+b
^#b::
;Initialise
InitBlankScreen()
global__strBlankColourValue

;Set__a__new__window__to__have__a__background__colour__and__remove__its__chrome
Gui,__Color,__%strBlankColourValue%
Gui,__+ToolWindow__-Caption__+AlwaysOnTop


;The__virtual__screen__is__the__bounding__rectangle__of__all__display__monitors.
;We__need__an__x__&__y__origin__and__the__height__&__width__to__create__our__overlay.
SysGet,__intOriginX,____
SysGet,__intOriginY,____
SysGet,__intWidth,____
SysGet,__intHeight,____

;Display__the__overlay__until__user__presses__ESC__key
Gui,__show,__x%intOriginX%__y%intOriginY%__w%intWidth%__h%intHeight%,__NA
return


;__Create__a__pop-up__menu.
BuildBlankScreenColourMenu()
{
____;Initialise
____InitBlankScreen()
____global__strBlankColour
____
____Menu,__menuBlankScreen,__Add
____Menu,__menuBlankScreen,__DeleteAll
____
____;Add__a__header__to__the__menu
____Menu,__menuBlankScreen,__Add,__Select__Blank__Screen__Colour,__MenuHandler
____Menu,__menuBlankScreen,__Disable,__Select__Blank__Screen__Colour
____Menu,__menuBlankScreen,__Add
____
____;Add__colours__to__the__menu
____Menu,__menuBlankScreen,__Add,__Black,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Red,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Blue,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Green,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Orange,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Yellow,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Purple,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Silver,__MenuHandler
____Menu,__menuBlankScreen,__Add,__White,__MenuHandler
____Menu,__menuBlankScreen,__Add,__Custom,__MenuHandler
____
____;Set__a__check__mark__against__the__colour__to__be__used
____Menu,__menuBlankScreen,__Check,__%strBlankColour%
____
____return
}


;Process__the__menu__selection
MenuHandler:
;Initialise
InitBlankScreen()
global__strBlankColour,__strBlankColourValue

;Uncheck__the__current__blanking__colour__in__the__menu
;Menu,__menuBlankScreen,__Uncheck,__%strBlankColour%

;Set__the__colour__as__the__selected__menu__item
strBlankColour__=__%A_ThisMenuItem%
strBlankColourValue__=__%A_ThisMenuItem%

;Override__for__any__non-standard__colours
IfEqual,__strBlankColour,__Orange
{
____strBlankColourValue__=__FF____
}

;For__a__custom__colour__use__a__standard__OS__colour__picker
IfEqual,__strBlankColour,__Custom
{
____SetFormat__IntegerFast,__H

____Colours__:=__[_x__FF__,___xFF____,___xFF__FF]
____SelectedColour__:=__ChooseColor(_x__FF,__GuiHwnd,__,__,__Colours*)
____
____IfEqual,__ErrorLevel,___x_
____{
________StringTrimLeft,__SelectedColour,__SelectedColour,___
________strBlankColourValue__=__%SelectedColour%
____}
____Else
____{
________;Default__to__black__because__it__was__cancelled
________strBlankColour__=__Black
________strBlankColourValue__=__Black
____}
____
}

return


;Display__pop-up__menu
;Shift+Ctrl+Win+b
+^#b::
BuildBlankScreenColourMenu()
Menu,__menuBlankScreen,__Show__
return

Esc::ExitApp
return