#Persistent__;__Keep__this__script__running__until__the__user__explicitly__exits__it.
SetTimer,__WatchAxis,___
return

WatchAxis:
JoyX__:=__GetKeyState("JoyX")__;__Get__position__of__X__axis.
JoyY__:=__GetKeyState("JoyY")__;__Get__position__of__Y__axis.
KeyToHoldDownPrev__:=__KeyToHoldDown__;__Prev__now__holds__the__key__that__was__down__before__(if__any).

if__(JoyX__>____)
____KeyToHoldDown__:=__"Right"
else__if__(JoyX__<____)
____KeyToHoldDown__:=__"Left"
else__if__(JoyY__>____)
____KeyToHoldDown__:=__"Down"
else__if__(JoyY__<____)
____KeyToHoldDown__:=__"Up"
else
____KeyToHoldDown__:=__""

if__(KeyToHoldDown__=__KeyToHoldDownPrev)__;__The__correct__key__is__already__down__(or__no__key__is__needed).
____return__;__Do__nothing.

;__Otherwise,__release__the__previous__key__and__press__down__the__new__key:
SetKeyDelay__-___;__Avoid__delays__between__keystrokes.
if__KeyToHoldDownPrev____;__There__is__a__previous__key__to__release.
____Send,__{%KeyToHoldDownPrev%__up}__;__Release__it.
if__KeyToHoldDown____;__There__is__a__key__to__press__down.
____Send,__{%KeyToHoldDown%__down}__;__Press__it__down.
return