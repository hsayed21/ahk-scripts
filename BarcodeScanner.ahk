#Requires AutoHotkey v2.0+
#SingleInstance Force

class BarcodeScanner {
    barcodes := Map()
    configFile := A_ScriptDir "\barcodes.txt"
    scan_wav := A_ScriptDir "\assets\barcode_scanner.wav"
    isActive := false

    __New() {
        this.CreateGui()
        this.LoadConfig()
    }

    CreateGui() {
        this.mainGui := Gui(, "Simple Barcode Scanner")
        this.mainGui.SetFont("s10")

        this.btnToggle := this.mainGui.AddButton("w300 h30", "Start Scanning")
        this.btnToggle.OnEvent("Click", this.ToggleScanning.Bind(this))

        this.mainGui.AddText("w200", "Enter Barcode:")
        this.edtBarcode := this.mainGui.AddEdit("w300")
        this.mainGui.AddText("w200", "Press Hotkey:")
        this.edtHotkey := this.mainGui.AddHotkey("w300")

        btnAdd := this.mainGui.AddButton("w100", "Add")
        btnAdd.OnEvent("Click", this.AddBarcode.Bind(this))
        btnDel := this.mainGui.AddButton("x+5 w100", "Delete")
        btnDel.OnEvent("Click", this.DeleteSelected.Bind(this))

        this.lvBarcodes := this.mainGui.AddListView("xm w300 r10", ["Hotkey", "Barcode"])
        this.lvBarcodes.OnEvent("DoubleClick", this.EditSelected.Bind(this))

        this.mainGui.OnEvent("Close", (*) => this.SaveConfig())
        this.mainGui.Show()
    }

    ToggleScanning(*) {
        this.isActive := !this.isActive
        this.btnToggle.Text := this.isActive ? "Stop Scanning" : "Start Scanning"
        this.btnToggle.Opt(this.isActive ? "+cRed" : "+cBlack")

        ; Enable/disable all registered hotkeys
        for _hotkey in this.barcodes {
            Hotkey(_hotkey, this.isActive ? "On" : "Off")
        }
    }

    AddBarcode(*) {
        _barcode := this.edtBarcode.Value
        _hotkey := this.edtHotkey.Value

        if !(_barcode && _hotkey) {
            MsgBox("Please enter both barcode and hotkey", "Error")
            return
        }

        if this.barcodes.Has(_hotkey) {
            Hotkey(_hotkey,, "Off")
        }

        this.barcodes[_hotkey] := _barcode
        Hotkey(_hotkey, (*) => this.SendBarcode(this.barcodes[_hotkey]), this.isActive ? "On" : "Off")

        this.RefreshList()
        this.edtBarcode.Value := ""
        this.edtHotkey.Value := ""
    }

    SendBarcode(barcode) {
        A_Clipboard := barcode
        SoundPlay(this.scan_wav)
        Send("^v")
    }

    DeleteSelected(*) {
        if (row := this.lvBarcodes.GetNext()) {
            _hotkey := this.lvBarcodes.GetText(row, 1)
            Hotkey(_hotkey,, "Off")
            this.barcodes.Delete(_hotkey)
            this.RefreshList()
        }
    }

    EditSelected(*) {
        if (row := this.lvBarcodes.GetNext()) {
            _hotkey := this.lvBarcodes.GetText(row, 1)
            this.edtBarcode.Value := this.barcodes[_hotkey]
            this.edtHotkey.Value := _hotkey
        }
    }

    RefreshList() {
        this.lvBarcodes.Delete()
        for _hotkey, _barcode in this.barcodes {
            this.lvBarcodes.Add(, _hotkey, _barcode)
        }
    }

    SaveConfig() {
        text := ""
        for _hotkey, _barcode in this.barcodes {
            text .= _hotkey "`t" _barcode "`n"
        }
        try FileDelete(this.configFile)
        if (text != "")
            FileAppend(text, this.configFile)
    }

    LoadConfig() {
        if !FileExist(this.configFile)
            return

        Loop Read, this.configFile {
            parts := StrSplit(A_LoopReadLine, "`t")
            if parts.Length != 2
                continue

            _hotkey := parts[1]
            _barcode := parts[2]
            this.barcodes[_hotkey] := _barcode
            Hotkey(_hotkey, (*) => this.SendBarcode(this.barcodes[_hotkey]), "Off")
        }
        this.RefreshList()
    }
}

; start
BarcodeScanner()
