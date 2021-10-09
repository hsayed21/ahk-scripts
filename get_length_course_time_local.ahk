#singleInstance, force
#Include %A_ScriptDir%\Filexpro.ahk ; more details attributes, properties

path = F:\7S\Courses\Linux\CompTIA Linux

timer_work := 4 ; 4 hour in day
sum_hour := 0
sum_min := 0
sum_sec := 0

Loop, Files, %path%\*.*, RF
{
    if (A_LoopFileExt = "mp4")
    {
        Obj := Filexpro(A_LoopFileFullPath,, "Length" )
        word := ":" 
        var := obj["Length"]
        StringReplace, var, var, %word%, %word%, UseErrorLevel
        count := ErrorLevel
        if (count == 2)
        {
            ; 2 = h,m,s
            arr := StrSplit(var, ":")
            sum_hour += arr[1]
            sum_min += arr[2]
            sum_sec += arr[3]
        }
        else if (count == 1)
        {
            ; 1 = m,s
            arr := StrSplit(var, ":")
            sum_min += arr[1]
            sum_sec += arr[2]
        }
    }
    
}
calc := sum_hour + (sum_min / 60) + (sum_sec / 3600)
finished := calc / timer_work
result = 
(
%sum_hour% hours
%sum_min% minutes
%sum_sec% seconds
-----------------
total of hours = %calc%
%timer_work% hours in day => finished in %finished% days
)
MsgBox % result

return
Esc::ExitApp

