/*
*****************************************
* @file nameOf.ahk
* @description: Get the name of a variable
* @author hsayed
* @date 2024-10-19
*****************************************
*/

nameOf(value) {
	try {
		; Get the stack trace of the caller
		throw Error("", -1)
	} catch as err {
		; Extract the calling line from the stack
		RegExMatch(err.Stack, "\[(.*?)\].*\R.*nameOf\((.*?)\)", &match)
		if !match {
			return "unknown"
		}

		; Return the variable name from the nameOf call
		splitArr := StrSplit(match[2], ".")
		return Trim(splitArr[splitArr.Length])
	}
}

x := 21
MsgBox(nameOf(x)) ; Displays "x"

myVar := "hello world"
MsgBox(nameOf(myVar)) ; Displays "myVar"
