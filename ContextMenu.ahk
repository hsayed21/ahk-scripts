/******************************************
 * @file ContextMenu.ahk
 * @description: class to create context menu with submenus and actions
 * @author hsayed
 * @date 2024-04-11
 * @version 1.0.0
*******************************************/

class MenuItem {
    __New(name, func := "") {
        this.Name := name
        this.Func := func
        this.SubMenu := []
    }
}

class ContextMenu {
    __New(menuArray) {
        this.Menus := []
        this.BuildMenu(menuArray, this.Menus)
    }

    BuildMenu(arr, arrMenu) {
        for index, value in arr {
            if (IsObject(value)) { ; Check if it's a submenu or a action
                if (value.HasProp("Name") && value.HasProp("SubMenu")) { ; It's a submenu
                    newItem := MenuItem(value.Name)
                    this.BuildMenu(value.SubMenu, newItem.SubMenu)
                    arrMenu.Push(newItem)
                } else if (value.HasProp("Name") && value.HasProp("Action")) { ; It's a Action
                    if (value.HasProp("Value"))
                        _func := this.GenerateFunc(value.Action, value.Value)
                    else
                        _func := this.GenerateFunc(value.Action, value.Name)
                    arrMenu.Push(MenuItem(value.Name, _func))
                }
            }
        }
    }

    ShowMenu() {
        MyMenu := Menu()
        this.PopulateMenu(this.Menus, MyMenu)
        MyMenu.Show()
    }

    PopulateMenu(_menus, _myMenu) {
        for index, item in _menus {
            itemName := item.Name
            _func := item.Func
            if (item.SubMenu.Length > 0) {
                _subMenu := Menu()
                this.PopulateMenu(item.SubMenu, _subMenu)
                _myMenu.Add(itemName, _subMenu)
            } else {
                if (Type(_func) = "Func" || Type(_func) = "Closure") {
                    if (!_AddValidFunc(_myMenu, _func, itemName))
                        return
                } else {
                    if (itemName = "_")
                        _myMenu.Add()
                    else
                        _myMenu.Add(itemName)
                }
            }
        }

        _AddValidFunc(_myMenu, _func, itemName)
        {
            try
            {
                parmasCount := _func.MinParams
                if (Type(_func) = "Func")
                    parmasCount -= 1
                switch (parmasCount)
                {
                    case 0:
                        _myMenu.Add(itemName, Type(_func) = "Func" ? _func : (*) => _func.Call())
                    case 1:
                        _myMenu.Add(itemName, Type(_func) = "Func" ? _func : (_itemName, *) => _func.Call(_itemName))
                    case 2:
                        _myMenu.Add(itemName, Type(_func) = "Func" ? _func : (_itemName, _itemPos, *) => _func.Call(_itemName, _itemPos))
                    case 3:
                        _myMenu.Add(itemName, Type(_func) = "Func" ? _func : (_itemName, _itemPos, _myMenu) => _func.Call(_itemName, _itemPos, _myMenu))
                    default:
                        if (Type(_func) = "Func")
                            MsgBox("Function must be follow these format: `n`rFunc(*)`n`rFunc(itemName, *)`n`rFunc(ItemName, ItemPos, MyMenu)")
                        else if (Type(_func) = "Closure")
                            MsgBox("Closure must be follow these format: `n`r(*)=>`n`r(itemName, *)=>`n`r(ItemName, ItemPos, MyMenu)=>")
                        return false
                }

                return true
            }
            catch
            {
                if (Type(_func) = "Func")
                    MsgBox("Function must be follow these format: `n`rFunc(*)`n`rFunc(itemName, *)`n`rFunc(ItemName, ItemPos, MyMenu)")
                else if (Type(_func) = "Closure")
                    MsgBox("Closure must be follow these format: `n`r(*)=>`n`r(itemName, *)=>`n`r(ItemName, ItemPos, MyMenu)=>")
                return false
            }
        }
    }

    GenerateFunc(action, value){
        switch (action) {
            case "Copy":
                return (item, *) => A_Clipboard := value
            case "Open":
                return (item, *) => Run(value)
        }
    }

    static GlobalMenu()
    {
        _menu := [
            {Name: "Copy && Paste", SubMenu: [
                {Name: "🦄 | &1 Menu 1 ", SubMenu: [
                    {Name: "Hello World!", Action: "Copy"},
                    {Name: "Welcome", Action: "Copy"},
                    {Name: "_", Action: ""},
                    {Name: "Copy with value", Action: "Copy", Value: "my value"},
                    {Name: "https://google.com/", Action: "Open"}
                ]},
                {Name: "🐃 | &2 Other", SubMenu: [
                    {Name: "Test", Action: "Copy"},
                ]}
            ]}
        ]
        ContextMenu(_menu).ShowMenu()
    }
}


; Usage:
F1::ContextMenu.GlobalMenu()