#SingleInstance force

c := 1

Gui Add,Text, w150 Center vMy, %c%
Gui Show

SetTimer, counter, 1000
return

counter:
c += 1
GuiControl,,My, %c%
return






