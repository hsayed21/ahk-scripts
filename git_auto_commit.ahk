#SingleInstance force

;repo path
SetWorkingDir, C:\Users\HS\Desktop\asd 

SetTimer, start, 600000 ; 10min
return

start:
Loop, Files, %A_WorkingDir%\*.txt
{
	/*
	filename := strReplace(A_LoopFileName, " ", "_")
	If (InStr(filename, A_Space))
	{
		filename := """" filename """" 
	}
	*/
	
	filename := A_LoopFileName
	out := RunWaitOneErr("git cat-file -e :" filename)
	if (out == "")
	{
		; not first time (can be modified)
		out := RunWaitOneOut("git status -s")
		if (InStr(out, filename))
		{
			;modified
			commit = Update %filename%
			commit := """" commit """" 
			RunWaitOneErr("git add " filename)
			Sleep 200
			RunWaitOneErr("git commit -m " commit)
		}
	}
	else
	{
		; first time (error)
		RunWaitOneErr("git add " filename)
		Sleep 200
		commit = Create %filename%
		commit := """" commit """" 
		RunWaitOneErr("git commit -m " commit)
		/*
		;replace/add double quotes 
		filename := strReplace(filename, """", "") ; 
		If (InStr(commit, A_Space))
		{
			commit := """" commit """" 
		}
		*/
	}
	
	Sleep 2000
	
}

return


RunWaitOneOut(command) {
  DetectHiddenWindows On
  Run %ComSpec%,, Hide, pid
  WinWait ahk_pid %pid%
  DllCall("AttachConsole", "UInt", pid)

  shell := ComObjCreate("WScript.Shell")
  exec := shell.Exec(ComSpec " /C " command)

  DllCall( "FreeConsole" )
    return exec.StdOut.ReadAll()
}

RunWaitOneErr(command) {
  DetectHiddenWindows On
  Run %ComSpec%,, Hide, pid
  WinWait ahk_pid %pid%
  DllCall("AttachConsole", "UInt", pid)

  shell := ComObjCreate("WScript.Shell")
  exec := shell.Exec(ComSpec " /C " command)

  DllCall( "FreeConsole" )
    return exec.StdErr.ReadAll()
}

Esc::
ExitApp
return