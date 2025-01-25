/******************************************
 * @file Formatter.ahk
 * @description: A class to format data to different formats
 * @author hsayed
 * @date 2025/01/25
 * @version 1.0.0
 *******************************************/

class Formatter
{
    __New(data?)
    {
        this.data := IsSet(data) ? data : ""
    }

    GetKeys(_map)
    {
        keys := []
        for key, value in _map
        {
            keys.Push(key)
        }
        return keys
    }

    ToTreeMap(data, indent := "", isRoot := true) {
        static branch := "├── ", indentSymbol := "│   ", end := "└── "
        result := ""
        keys := this.GetKeys(data) ; Get all keys (which are folder names or file names)
        itemCount := keys.Length ; Get the number of items at the current level
        current := 0

        for index, key in keys {
            current++
            isLastItem := (current = itemCount)
            ; Determine the next level of indentation based on whether this is the last item
            nextIndent := isRoot ? "" : (isLastItem ? indent . "    " : indent . indentSymbol)
            ; Determine the correct prefix to use
            prefix := (isRoot && !isLastItem) ? branch : (isRoot ? end : (isLastItem ? end : branch))

            ; If it's the root level and the first item, don't add extra indentation
            if (!isRoot || current > 1)
                result .= indent

            if (isRoot)
                result .= key . "`n"
            else
                result .= prefix . key . "`n"

            if (type(data[key]) = "Map")  ; Check if the current item is a Map (directory)
                result .= this.ToTreeMap(data[key], nextIndent, false)
        }
        return result
    }

    ToMarkdownTaskList(withNumbers := false)
    {
        result := ""
        if (this.data = "")
            return ""
        if (this.data is Array)
        {
            for each, item in this.data
            {
                result .= "- [ ] " (withNumbers ? each "_" item : item) "`n"
            }
        }
        else
        {
            result := "- [ ] " this.data "`n"
        }
        return result
    }

    ToMarkdownList(withNumbers := false)
    {
        result := ""
        if (this.data = "")
            return ""
        if (this.data is Array)
        {
            for each, item in this.data
            {
                result .= "- " (withNumbers ? each "_" item : item) "`n"
            }
        }
        else
        {
            result := "- " this.data "`n"
        }
        return result
    }

    ToMarkdownCode(lang := "###", withNumbers := false)
    {
        result := ""
        if (this.data = "")
            return ""
        if (this.data is Array)
        {
            for each, item in this.data
            {
                result .= (withNumbers ? each "_" item : item) "`n``````" lang "`n`n```````n"
            }
        }
        else
        {
            result .= (withNumbers ? each "_" item : item) "`n``````" lang "`n`n```````n"
        }
        return result
    }

}

; Example Usage:
ExampleUsage() {
    ; Example 1: Tree Map
    folders := Map(
        "Root", Map(
            "Folder1", Map(
                "SubFolder1", Map(),
                "SubFolder2", Map()
            ),
            "Folder2", Map(
                "SubFolder3", Map()
            )
        )
    )
    treeFormatter := Formatter()
    MsgBox(treeFormatter.ToTreeMap(folders))
    /*
    Output:
    Root
    ├── Folder1
    │   ├── SubFolder1
    │   └── SubFolder2
    └── Folder2
        └── SubFolder3
    */

    ; Example 2: Markdown Task List
    tasks := ["Buy groceries", "Do laundry", "Write code"]
    taskFormatter := Formatter(tasks)
    MsgBox(taskFormatter.ToMarkdownTaskList())
    /*
    Output:
    - [ ] Buy groceries
    - [ ] Do laundry
    - [ ] Write code
    */

    ; Example 3: Markdown List
    items := ["Apple", "Banana", "Orange"]
    listFormatter := Formatter(items)
    MsgBox(listFormatter.ToMarkdownList(true))
    /*
    Output:
    - 1_Apple
    - 2_Banana
    - 3_Orange
    */

    ; Example 4: Markdown Code
    codeSnippets := ["console.log('Hello')", "console.log('World')"]
    codeFormatter := Formatter(codeSnippets)
    MsgBox(codeFormatter.ToMarkdownCode("javascript"))
    /*
    Output:
    console.log('Hello')
    ```javascript

    ```
    console.log('World')
    ```javascript

    ```
    */
}

ExampleUsage()