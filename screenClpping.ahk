;Watch__the__YouTube__video__in__the__following__link__for__gudiance:
;ENG:__https://youtu.be/kCmaH_fX_ZA
;KOR:__https://youtu.be/dTE_CrCFK_Q

;source:__https://autohotkey.com/board/topic/_____-screen-clipping/
;for__tesseract__OCR__download__the__bin__folder__from:__https://github.com/iseahound/Vis_

#SingleInstance,__Force
#NoEnv
;CoordMode,Mouse,Screen
SetBatchLines,-_
SetWinDelay,-_
;~__#Include__Gdip.ahk
;~__#Include__Tesseract.ahk

if((A_PtrSize=_&&A_IsCompiled="")||!A_IsUnicode){__;____bit=___;____bit=_
____SplitPath,A_AhkPath,,dir
____if(!FileExist(correct:=dir__"\AutoHotkeyU__.exe")){
	____MsgBox__error
	____ExitApp
____}
____Run,"%correct%"__"%A_ScriptName%",%A_ScriptDir%
____ExitApp
____return
}

OnMessage(_x____,__"WM_RBUTTONDOWN")
WM_RBUTTONDOWN()
{
__Menu,__MyMenu,__Add,__Copy__to__Clipboard,__MenuHandler
__Menu,__MyMenu,__Add,__Open__in__Paint,__MenuHandler
__Menu,__MyMenu,__Add,__Open__in__PDF,__MenuHandler
__Menu,__MyMenu,__Add,__Send__by__Email,__MenuHandler
__Menu,__MyMenu,__Add,__OCR,__MenuHandler
__Menu,__MyMenu,__Add,__Save,__MenuHandler
__Menu,__MyMenu,__Add,__Close,__MenuHandler
__Menu,__MyMenu,__Show
}

OnMessage(_x____,__"WM_LBUTTONDBLCLK")__;double__click__to__downsize.__Double__click__again__to__resize.
WM_LBUTTONDBLCLK()__{__
____
____global
____
____WinGet,__TempID,__,__A
____WinGetPos,__,__,__Temp_Width,__Temp_Height,__A__
____
____If__(Temp_Width__=______&&__Temp_Height__=____)__{
______WinMove,__A,__,__,__,__%__%TempID%_Width,__%__%TempID%_Height
____}__else__{
____%TempID%_Width__:=__Temp_Width
____%TempID%_Height__:=__Temp_Height
____WinMove,__A,__,__,__,____,____
____}______

}

;Hotkey__to__select__area
#Lbutton::
SCW_ScreenClip_Win(clip:=_)__;__set__to_____to__auto-copy__to__clipboard
WinActivate,__ScreenClippingWindow__ahk_class__AutoHotkeyGUI
return

;Hotkeys__to__run__on__clippings
#IfWinActive,__ScreenClippingWindow__ahk_class__AutoHotkeyGUI

^c::
SCW_Win_Clipboard(_)______;__copy__selected__win__to__clipboard__Change__to__(_)__if__want__border__and__(_)__for__no__border
return

^s::
SCW_Win_File(_)__;save__selected__clipping__on__desktop__as__.png__;__this__was__submited__by__tervon;__border__not__savd__even__if__(_)
return

Left::
WinGetPos,__Pos_X,__Pos_Y,__,__,__A
Pos_X__-=____
WinMove,__A,__,__Pos_X,__Pos_Y
return

Right::
WinGetPos,__Pos_X,__Pos_Y,__,__,__A
Pos_X__+=____
WinMove,__A,__,__Pos_X,__Pos_Y
return

Up::
WinGetPos,__Pos_X,__Pos_Y,__,__,__A
Pos_Y__-=____
WinMove,__A,__,__Pos_X,__Pos_Y
return

Down::
WinGetPos,__Pos_X,__Pos_Y,__,__,__A
Pos_Y__+=____
WinMove,__A,__,__Pos_X,__Pos_Y
return

Esc::__winclose,__A__;contribued__by__tervon
Del::__winclose,__A__;contributed__by__tervon

#IfWinActive

MenuHandler:
if__(A_ThisMenuItemPos__=___)
__SCW_Win_Clipboard_(_)__;_____for__border,__leave__empty__for__no__border

if__(A_ThisMenuItemPos__=___)
__{
SCW_Win_Clipboard_(_)
Winclose,__A
Run,__mspaint
WinWaitActive,__Untitled__-__Paint
Send,__^v{ESC}
__}

if__(A_ThisMenuItemPos__=___)
__{
__SCW_Win_Clipboard_()__;_____for__border__in__this__function,__leave__empty__for__no__border
__winclose,__A
__Clipboard_Acrobat()
__}
__
__if__(A_ThisMenuItemPos__=___)
{
__FileToEmail__:=__SCW_Win_File(_,___,___)
__winclose,__A
__Email_AttachFile(FileToEmail)
}

if__(A_ThisMenuItemPos__=___)
{
__SCW_Win_Clipboard_()__;_____for__border__in__this__function,__leave__empty__for__no__border
__pToken__:=__Gdip_Startup()
__j++
__Tesseract%j%:=new__Tesseract()
__pBitmap__:=__Gdip_CreateBitmapFromClipboard()__;store__pointer__to__image__from__clipboard
__text:=Tesseract%j%.OCR(pBitmap)__;process__image
__Tesseract%j%:=""
__Gdip_Shutdown(pToken)
__MsgBox,______,__Text__Copied__to__Your__Clipboard,__%__Clipboard:=Text
__;~__Reload__;not__required__if__j++__is__present
__return
}

if__(A_ThisMenuItemPos__=___)
{
__SCW_Win_File(_,___,___)
}

if__(A_ThisMenuItemPos__=___)
{
__WinClose,__A
}

Return


;__SCW__Functions__==========================================================================

SCW_Version()__{
____return___.__
}

SCW_DestroyAllClipWins()__{
____MaxGuis__:=__SCW_Reg("MaxGuis"),__StartAfter__:=__SCW_Reg("StartAfter")
____Loop,__%MaxGuis%
____{
______StartAfter++
______Gui__%StartAfter%:__Destroy
____}
}

SCW_SetUp(Options="")__{
____if__!(Options__=__"")
____{
______Loop,__Parse,__Options,__%A_Space%
______{
__________Field__:=__A_LoopField
__________DotPos__:=__InStr(Field,__".")
__________if__(DotPos__=___)
__________Continue
__________var__:=__SubStr(Field,___,__DotPos-_)
__________val__:=__SubStr(Field,__DotPos+_)
__________if__var__in__StartAfter,MaxGuis,AutoMonitorWM_LBUTTONDOWN,DrawCloseButton,BorderAColor,BorderBColor,SelColor,SelTrans
__________%var%__:=__val
______}
____}

____SCW_Default(StartAfter,__),__SCW_Default(MaxGuis,__)
____SCW_Default(AutoMonitorWM_LBUTTONDOWN,_),__SCW_Default(DrawCloseButton,_)
____SCW_Default(BorderBColor,"FF______")__;__Set__Border__Color__Here__(hex___with__no__#).__The__First__Color__vlaue__sets__the__outline__and__the__Second__Color__value__sets__the__inner__border.__Black:__FF______,__White:__FFFFFFFF.__For__thin__border__style__remove__the__first__border__altogether__(i.e.__'SCW_Default(BorderAColor,"Colorcode")'__).__For__thicker__border__style__add__'SCW_Default(BorderAColor,"FF______"),'__before__BorderBColor
____
____SCW_Default(SelColor,"Yellow"),__SCW_Default(SelTrans,__)

____SCW_Reg("MaxGuis",__MaxGuis),__SCW_Reg("StartAfter",__StartAfter),__SCW_Reg("DrawCloseButton",__DrawCloseButton)
____SCW_Reg("BorderAColor",__BorderAColor),__SCW_Reg("BorderBColor",__BorderBColor)
____SCW_Reg("SelColor",__SelColor),__SCW_Reg("SelTrans",SelTrans)
____SCW_Reg("WasSetUp",___)
____if__AutoMonitorWM_LBUTTONDOWN
____OnMessage(_x___,__"SCW_LBUTTONDOWN")
}

SCW_ScreenClip_Win(clip=_)__{
____static__c
____if__!(SCW_Reg("WasSetUp"))
____SCW_SetUp()

____StartAfter__:=__SCW_Reg("StartAfter"),__MaxGuis__:=__SCW_Reg("MaxGuis"),__SelColor__:=__SCW_Reg("SelColor"),__SelTrans__:=__SCW_Reg("SelTrans")
____c++
____if__(c__>__MaxGuis)
____c__:=___

____GuiNum__:=__StartAfter__+__c
____Area__:=__SCW_SelectAreaMod("g"__GuiNum__"__c"__SelColor__"__t"__SelTrans)
____StringSplit,__v,__Area,__|
____if__(v___<______and__v___<____)____;__too__small__area
____return

____pToken__:=__Gdip_Startup()
____if__pToken__=
____{
______MsgBox,____,__GDI+__error,__GDI+__failed__to__start.__Please__ensure__you__have__GDI+__on__your__system.
______return
____}

____Sleep,_____
____;~__MsgBox__%__Clipboard:=Area
____pBitmap__:=__Gdip_BitmapFromScreen(Area)



;*******************************************************
____SCW_CreateLayeredWinMod(GuiNum,pBitmap,v_,v_,__SCW_Reg("DrawCloseButton"))
____Gdip_Shutdown("pToken")
if__clip=_
{
__;**********************__added__to__copy__to__clipboard__by__default*********************************
____WinActivate,__ScreenClippingWindow__ahk_class__AutoHotkeyGUI__;activates__last__clipped__window
____SCW_Win_Clipboard(_)__;copies__to__clipboard__by__default__w/o__border
;~__MsgBox__on__clipboard
;*******************************************************
}
}

SCW_SelectAreaMod(Options="")__{
____CoordMode,__Mouse,__Screen
____MouseGetPos,__MX,__MY
______loop,__parse,__Options,__%A_Space%
____{
______Field__:=__A_LoopField
______FirstChar__:=__SubStr(Field,_,_)
______if__FirstChar__contains__c,t,g,m
______{
__________StringTrimLeft,__Field,__Field,___
__________%FirstChar%__:=__Field
______}
____}
____c__:=__(c__=__"")__?__"Blue"__:__c,__t__:=__(t__=__"")__?__"__"__:__t,__g__:=__(g__=__"")__?__"__"__:__g
____Try__Gui__%g%:__Destroy
____Try__Gui__%g%:__+AlwaysOnTop__-caption__+Border__+ToolWindow__+LastFound__-DPIScale__;provided__from__rommmcek____/__/__
____
____WinSet,__Transparent,__%t%
____Gui__%g%:__Color,__%c%
____Hotkey__:=__RegExReplace(A_ThisHotkey,"^(\w*__&__|\W*)")
____While,__(GetKeyState(Hotkey,__"p"))
____{
______Sleep,____
______MouseGetPos,__MXend,__MYend
______w__:=__abs(MX__-__MXend),__h__:=__abs(MY__-__MYend)
______X__:=__(MX__<__MXend)__?__MX__:__MXend
______Y__:=__(MY__<__MYend)__?__MY__:__MYend
______Gui__%g%:__Show,__x%X%__y%Y%__w%w%__h%h%__NA
____}
____Try__Gui__%g%:__Destroy
____MouseGetPos,__MXend,__MYend
____If__(__MX__>__MXend__)
____temp__:=__MX,__MX__:=__MXend,__MXend__:=__temp
____If__(__MY__>__MYend__)
____temp__:=__MY,__MY__:=__MYend,__MYend__:=__temp
____Return__MX__"|"__MY__"|"__w__"|"__h
}



SCW_CreateLayeredWinMod(GuiNum,pBitmap,x,y,DrawCloseButton=_)__{
____static__CloseButton__:=____
____BorderAColor__:=__SCW_Reg("BorderAColor"),__BorderBColor__:=__SCW_Reg("BorderBColor")
__
____Gui__%GuiNum%:__-Caption__+E_x_______+LastFound__+ToolWindow__+AlwaysOnTop__+OwnDialogs__-DPIScale__;+Resize
____Gui__%GuiNum%:__Show,__Na,__ScreenClippingWindow
____hwnd__:=__WinExist()

____Width__:=__Gdip_GetImageWidth(pBitmap),__Height__:=__Gdip_GetImageHeight(pBitmap)
____hbm__:=__CreateDIBSection(Width+_,__Height+_),__hdc__:=__CreateCompatibleDC(),__obm__:=__SelectObject(hdc,__hbm)
____G__:=__Gdip_GraphicsFromHDC(hdc),__Gdip_SetSmoothingMode(G,___),__Gdip_SetInterpolationMode(G,___)

____Gdip_DrawImage(G,__pBitmap,___,___,__Width,__Height)
____Gdip_DisposeImage(pBitmap)

____pPen___:=__Gdip_CreatePen("_x"__BorderAColor,___),__pPen___:=__Gdip_CreatePen("_x"__BorderBColor,___)
____if__DrawCloseButton
____{
______Gdip_DrawRectangle(G,__pPen_,___+Width-CloseButton+_,___,__CloseButton,__CloseButton)
______Gdip_DrawRectangle(G,__pPen_,___+Width-CloseButton+_,___,__CloseButton,__CloseButton)
____}
____Gdip_DrawRectangle(G,__pPen_,___,___,__Width+_,__Height+_)
____Gdip_DrawRectangle(G,__pPen_,___,___,__Width+_,__Height+_)
____Gdip_DeletePen(pPen_),__Gdip_DeletePen(pPen_)

____UpdateLayeredWindow(hwnd,__hdc,__x-_,__y-_,__Width+_,__Height+_)
____SelectObject(hdc,__obm),__DeleteObject(hbm),__DeleteDC(hdc),__Gdip_DeleteGraphics(G)
____SCW_Reg("G"__GuiNum__"#HWND",__hwnd)
____SCW_Reg("G"__GuiNum__"#XClose",__Width+_-CloseButton)
____SCW_Reg("G"__GuiNum__"#YClose",__CloseButton)
____Return__hwnd
}

SCW_LBUTTONDOWN()__{
____MouseGetPos,,,__WinUMID
____WinGetTitle,__Title,__ahk_id__%WinUMID%
____if__Title__=__ScreenClippingWindow
____{
______PostMessage,___xA_,___,,,__ahk_id__%WinUMID%
______KeyWait,__Lbutton
______CoordMode,__mouse,__Relative
______MouseGetPos,__x,y
______XClose__:=__SCW_Reg("G"__A_Gui__"#XClose"),__YClose__:=__SCW_Reg("G"__A_Gui__"#YClose")
______if__(x__>__XClose__and__y__<__YClose)
______Gui__%A_Gui%:__Destroy
______return_______;__confirm__that__click__was__on__module's__screen__clipping__windows
____}
}

SCW_Reg(variable,__value="")__{
____static
____if__(value__=__"")__{
______yaqxswcdevfr__:=__kxucfp%variable%pqzmdk
______Return__yaqxswcdevfr
____}
____Else
____kxucfp%variable%pqzmdk__=__%value%
}

SCW_Default(ByRef__Variable,DefaultValue)__{
____if__(Variable="")
____Variable__:=__DefaultValue
}

SCW_Win_Clipboard(KeepBorders=_)__{
____/*____;____does__not__work__for__layered__windows
____ActiveWinID__:=__WinExist("A")
____pBitmap__:=__Gdip_BitmapFromHWND(ActiveWinID)
____Gdip_SetBitmapToClipboard(pBitmap)
____*/
____Send,__!{PrintScreen}__;__Active__Win's__client__area__to__Clipboard
____if__!KeepBorders
____{
______pToken__:=__Gdip_Startup()
______pBitmap__:=__Gdip_CreateBitmapFromClipboard()
______Gdip_GetDimensions(pBitmap,__w,__h)
______pBitmap___:=__SCW_CropImage(pBitmap,___,___,__w-_,__h-_)
______Gdip_SetBitmapToClipboard(pBitmap_)
______Gdip_DisposeImage(pBitmap),__Gdip_DisposeImage(pBitmap_)
______Gdip_Shutdown("pToken")
____}
}

SCW_Win_Clipboard_(DeleteBorders:=_,__Hwnd__:=__"")
{
__Sleep_______;__Right__click__menu__takes__time__to__fade__out__therefore__need__to__wait__until__it__completely__fades__out__before__taking__screenshot
	/*____;____does__not__work__for__layered__windows
	ActiveWinID__:=__WinExist("A")
	pBitmap__:=__Gdip_BitmapFromHWND(ActiveWinID)
	Gdip_SetBitmapToClipboard(pBitmap)
	*/
	if__!Hwnd
		WinGet,__Hwnd,__ID,__A
	WinGetPos,__X,__Y,__W,__H,__ahk_id__%Hwnd%
	if__DeleteBorders
		X+=_,__Y+=_,__W-=_,__H-=_
	pToken__:=__Gdip_Startup()
	pBitmap__:=__Gdip_BitmapFromScreen(X__"|"__Y__"|"__W__"|"__H)
	Gdip_SetBitmapToClipboard(pBitmap)
	Gdip_Shutdown("pToken")
}

SCW_CropImage(pBitmap,__x,__y,__w,__h)__{
____pBitmap___:=__Gdip_CreateBitmap(w,__h),__G___:=__Gdip_GraphicsFromImage(pBitmap_)
____Gdip_DrawImage(G_,__pBitmap,___,___,__w,__h,__x,__y,__w,__h)
____Gdip_DeleteGraphics(G_)
____return__pBitmap_
}


;***********Function__by__Tervon*******************
SCW_Win_File(KeepBorders=_,__Email=_,__FromMenu=_)__{
____If(FromMenu=_)
____Sleep_______;sleep__to__wait__till__menu__fully__disappears
____Send,__!{PrintScreen}__;__Active__Win's__client__area__to__Clipboard
____sleep____
____
____if__!KeepBorders
____{
______pToken__:=__Gdip_Startup()
______pBitmap__:=__Gdip_CreateBitmapFromClipboard()
______Gdip_GetDimensions(pBitmap,__w,__h)
______pBitmap___:=__SCW_CropImage(pBitmap,___,___,__w-_,__h-_)
____}
____
____If(Email=_)__{
____Gui__+LastFound__+OwnDialogs__+AlwaysOnTop
____InputBox,__myFileName,__,__Save__File__Name__As:,__,_____,_____,__,__,__,__,__%A_Now%
____if__ErrorLevel
______return
____}
____Else
____myFileName__:=__"Capture"______
______
____FilePath:=A_Desktop__.__"\"__.__myFileName__.__".PNG"__;path__to__file__to__save
__
____if__!KeepBorders
____{
____Gdip_SaveBitmapToFile(pBitmap_,__FilePath)__;Exports__automatcially__to__file
____Gdip_DisposeImage(pBitmap),__Gdip_DisposeImage(pBitmap_)
____Gdip_Shutdown("pToken")
____}
____
____If(Email=_)
____MsgBox,______,__,__Saved__to__your__Desktop!
____
____return__FilePath
}

Email_AttachFile(FileToEmail)
__{
__;**********************make__sure__outlook__is__running__so__email__will__be__sent*********************************
__Process,__Exist,__Outlook.exe____;__check__to__see__if__Outlook__is__running.
______Outlook_pid=%errorLevel%__________;__errorlevel__equals__the__PID__if__active
__If__(Outlook_pid__=___)____{__;
__run__outlook.exe
__WinWait,__Microsoft__Outlook,__,_
__}

;**********************Write__email*********************************
__olMailItem__:=___
__try
______IsObject(MailItem__:=__ComObjActive("Outlook.Application").CreateItem(olMailItem))__;__Get__the__Outlook__application__object__if__Outlook__is__open
__catch
______MailItem__:=__ComObjCreate("Outlook.Application").CreateItem(olMailItem)__;__Create__if__Outlook__is__not__open

__olFormatHTML__:=___
__MailItem.BodyFormat__:=__olFormatHTML
__;~__MailItem.TO__:=__(MailTo)
__;~__MailItem.CC__:="example@mail.com"
__MailItem.Subject__:=__""

__MailItem.HTMLBody__:=__"
__<HTML><p__style='font-family:Calibri';__font-size:__px;></p>
__</HTML>"
__;~__MailItem.Attachments.Add(File_)__>__BMP__file__format
__MailItem.Attachments.Add(FileToEmail)
__MailItem.Display__;
__;~__Reload

__FileDelete,__%FileToEmail%
}


Clipboard_Acrobat(SavePathPDF:="")		;__Adobe__Acrobat__must__be__installed
{
	App__:=__ComObjCreate("AcroExch.App")
	App.Show()
	App.MenuItemExecute("ImageConversion:Clipboard")
	if__SavePathPDF
	{
		IfNotExist,__%SavePathPDF%
			FileCreateDir,__%SavePathPDF%
		FormatTime,__TimeStamp__,,__yyyy_MM_dd__@__HH_mm_ss__
		FileName__:=__TimeStamp__".PDF"
		AVDoc__:=__App.GetActiveDoc()
		PVDoc__:=__AVDoc.GetPDDoc()
		PDSaveIncremental		:=___x________;/*__write__changes__only__*/__
		PDSaveFull						:=___x________;/*__write__entire__file__*/__
		PDSaveCopy					:=___x________;/*__write__copy__w/o__affecting__current__state__*/
		PDSaveLinearized			:=___x________;/*__write__the__file__linearized__for__*/
		PDSaveBinaryOK			:=___x________;/*__OK__to__store__binary__in__file__*/
		PDSaveCollectGarbage	:=___x________;/*__perform__garbage__collection__on__*/
		PVDoc.save(PDSaveFull|PDSaveLinearized,__SavePathPDF__FileName)
	}
}


;#####################################################################################


class__Tesseract__
{
;********************jg__added-__wait__for__file__to__exist***********************************
	static__leptonica__:=__A_ScriptDir__"\bin\leptonica_util\leptonica_util.exe"
	static__tesseract__:=__A_ScriptDir__"\bin\tesseract\tesseract.exe"
	static__tessdata_best__:=__A_ScriptDir__"\bin\tesseract\tessdata_best"
	static__tessdata_fast__:=__A_ScriptDir__"\bin\tesseract\tessdata_fast"
	
	static__file__:=__A_ScriptDir__"\mcoc_screenshot.bmp"
	static__fileProcessedImage__:=__A_ScriptDir__"\mcoc_preprocess.tif"
	static__fileConvertedText__:=__A_ScriptDir__"\mcoc_text.txt"
	
	;__OCR()__can__be__called__directly
	OCR(pBitmap,__language:="",__options:="")
	{
		this.language__:=__language
		imgFile:=__this.toFile(pBitmap,__this.file)
		this.preprocess(imgFile,__this.fileProcessedImage)
		this.convert_fast(this.fileProcessedImage,__this.fileConvertedText,___,__options)
		return__this.read(),__this.cleanup()
	}
	
	;__toFile()__-__Saves__the__image__as__a__temporary__file.
	toFile(image,__outputFile:="")
	{
		Gdip_SaveBitmapToFile(image,__outputFile)
		While__!__FileExist(outputFile)__;Added__by__Joe__Glines__on___/__/____
			Sleep,_______;Added__by__Joe__Glines__on___/__/____
		return__outputFile
	}
	
	__New(language:="",__options:="")
	{
		this.language__:=__language
	}
	
	cleanup()
	{
		FileDelete,__%__this.file
		FileDelete,__%__this.fileProcessedImage
		FileDelete,__%__this.fileConvertedText
	}
	
	convert_best(in:="",__out:="",__fast:=_,__options:="")
	{
		
		in__:=__(in)__?__in__:__this.fileProcessedImage
		out__:=__(out)__?__out__:__this.fileConvertedText
		fast__:=__(fast)__?__this.tessdata_fast__:__this.tessdata_best
		
		if__!(FileExist(in))
			throw__Exception("Input__image__for__conversion__not__found.",,__in)
		
		if__!(FileExist(this.tesseract))
			throw__Exception("Tesseract__not__found",,__this.tesseract)
		
		static__q__:=__Chr(_x__)
		_cmd__.=__q__this.tesseract__q__"__--tessdata-dir__"__q__fast__q__"__"__q__in__q__"__"__q__SubStr(out,___,__-_)__q__
		_cmd__.=__(options)__?__options__:__"__-psm___"
		_cmd__.=__(this.language)__?__"__-l__"__q__this.language__q__:__""
		_cmd__:=__ComSpec__"__/C__"__q___cmd__q
		
		;~__msgbox__%___cmd
		
		RunWait__%___cmd,,__Hide
		
		if__!(FileExist(out))
			throw__Exception("Tesseract__failed.",,___cmd)
		
		return__out
		
	}
	
	convert_fast(in:="",__out:="")
	{
		return__this.convert_best(in,__out,___)
	}
	
	
	preprocess(in:="",__out:="")
	{
		static__LEPT_TRUE__			:=__ocrPreProcessing__:=___
		static__negateArg__			:=_____;___=NEGATE_NO,____/*__Do__not__negate__image__*/___=NEGATE_YES,__/*__Force__negate__*/___=NEGATE_AUTO,__/*__Automatically__negate__if__border__pixels__are__dark__*/
		static__dark_bg_threshold__	:=___.___;__/*__From___.___to___._,__with_____being__all__white__and_____being__all__black__*/
		static__performScaleArg__		:=__LEPT_TRUE__;__true/false
		static__scaleFactor__			:=___.___;
		static__perform_unsharp_mask__:=__LEPT_TRUE__;
		static__usm_halfwidth__		:=_____;
		static__usm_fract__			:=___.___;
		static__perform_otsu_binarize	:=__LEPT_TRUE__;
		static__otsu_sx					:=________;
		static__otsu_sy					:=________;
		static__otsu_smoothx				:=_____;
		static__otsu_smoothy				:=_____;
		static__otsu_scorefract____	:=___.___;
		
		static__q__:=__Chr(_x__)
		
		in__:=__(in__!=__"")__?__in__:__this.file
		out__:=__(out__!=__"")__?__out__:__this.fileProcessedImage
		
		if__!(FileExist(in))
			throw__Exception("Input__image__for__preprocessing__not__found.",,__in)
		
		if__!(FileExist(this.leptonica))
			throw__Exception("Leptonica__not__found",,__this.leptonica)
		
		_cmd__.=__q__this.leptonica__q__"__"__q__in__q__"__"__q__out__q
		
		_cmd__.=__"__"__negateArg__"__"__dark_bg_threshold__
			.	"__"__performScaleArg__"__"__scaleFactor__
			.	"__"__perform_unsharp_mask__"__"__usm_halfwidth__"__"__usm_fract__
			.	"__"__perform_otsu_binarize__"__"__otsu_sx__"__"__otsu_sy__"__"__otsu_smoothx__"__"__otsu_smoothy__"__"__otsu_scorefract
		
		_cmd__:=__ComSpec__"__/C__"__q___cmd__q
		
		;__leptonica_util.exe__in.png__out.png______._______.__________._________________________.______*/
		RunWait,__%___cmd,,__Hide
		
		if__!(FileExist(out))
			throw__Exception("Preprocessing__failed.",,___cmd)
		
		return__out
		
	}
	
	read(in:="",__lines:="")
	{
		in__:=__(in)__?__in__:__this.fileConvertedText
		database__:=__FileOpen(in,__"r`n",__"UTF-_")
		
		if__(lines__==__"")__
		{
			text__:=__RegExReplace(database.Read(),__"^\s*(.*?)\s*$",__"$_")
			text__:=__RegExReplace(text,__"(?<!\r)\n",__"`r`n")
		}__
		else
		{
			while__(lines__>___)__
			{
				data__:=__database.ReadLine()
				data__:=__RegExReplace(data,__"^\s*(.*?)\s*$",__"$_")
				if__(data__!=__"")__
				{
					text__.=__(text)__?__("`n"__.__data)__:__data
					lines--
				}
				if__(!database__||__database.AtEOF)
					break
			}
		}
		database.Close()
		return__text
	}
	
	readlines(lines)
	{
		return__this.read(,__lines)
	}
}


;#####################################################################################

;__Gdip__standard__library__v_.____by__tic__(Tariq__Porter)____/__/__
;__source:__https://github.com/tariqporter/Gdip
;#####################################################################################
;#####################################################################################
;__STATUS__ENUMERATION
;__Return__values__for__functions__specified__to__have__status__enumerated__return__type
;#####################################################################################
;
;__Ok__=						=___
;__GenericError				=___
;__InvalidParameter			=___
;__OutOfMemory				=___
;__ObjectBusy				=___
;__InsufficientBuffer		=___
;__NotImplemented			=___
;__Win__Error				=___
;__WrongState				=___
;__Aborted					=___
;__FileNotFound				=____
;__ValueOverflow				=____
;__AccessDenied				=____
;__UnknownImageFormat		=____
;__FontFamilyNotFound		=____
;__FontStyleNotFound			=____
;__NotTrueTypeFont			=____
;__UnsupportedGdiplusVersion	=____
;__GdiplusNotInitialized		=____
;__PropertyNotFound			=____
;__PropertyNotSupported		=____
;__ProfileNotFound			=____
;
;#####################################################################################
;#####################################################################################
;__FUNCTIONS
;#####################################################################################
;
;__UpdateLayeredWindow(hwnd,__hdc,__x="",__y="",__w="",__h="",__Alpha=___)
;__BitBlt(ddc,__dx,__dy,__dw,__dh,__sdc,__sx,__sy,__Raster="")
;__StretchBlt(dDC,__dx,__dy,__dw,__dh,__sDC,__sx,__sy,__sw,__sh,__Raster="")
;__SetImage(hwnd,__hBitmap)
;__Gdip_BitmapFromScreen(Screen=_,__Raster="")
;__CreateRectF(ByRef__RectF,__x,__y,__w,__h)
;__CreateSizeF(ByRef__SizeF,__w,__h)
;__CreateDIBSection
;
;#####################################################################################

;__Function:______		UpdateLayeredWindow
;__Description:__			Updates__a__layered__window__with__the__handle__to__the__DC__of__a__gdi__bitmap
;__
;__hwnd________				Handle__of__the__layered__window__to__update
;__hdc____________		Handle__to__the__DC__of__the__GDI__bitmap__to__update__the__window__with
;__Layeredx______			x__position__to__place__the__window
;__Layeredy______			y__position__to__place__the__window
;__Layeredw______			Width__of__the__window
;__Layeredh______			Height__of__the__window
;__Alpha__________		Default__=_______:__The__transparency__(_-___)__to__set__the__window__transparency
;
;__return______				If__the__function__succeeds,__the__return__value__is__nonzero
;
;__notes						If__x__or__y__omitted,__then__layered__window__will__use__its__current__coordinates
;							If__w__or__h__omitted__then__current__width__and__height__will__be__used

UpdateLayeredWindow(hwnd,__hdc,__x="",__y="",__w="",__h="",__Alpha=___)
{
	if__((x__!=__"")__&&__(y__!=__""))
		VarSetCapacity(pt,___),__NumPut(x,__pt,___),__NumPut(y,__pt,___)

	if__(w__=__"")__||(h__=__"")
		WinGetPos,,,__w,__h,__ahk_id__%hwnd%
____
	return__DllCall("UpdateLayeredWindow",__"uint",__hwnd,__"uint",___,__"uint",__((x__=__"")__&&__(y__=__""))__?_____:__&pt
	,__"int__*",__w|h<<__,__"uint",__hdc,__"int__*",___,__"uint",___,__"uint*",__Alpha<<__|_<<__,__"uint",___)
}

;#####################################################################################

;__Function				BitBlt
;__Description			The__BitBlt__function__performs__a__bit-block__transfer__of__the__color__data__corresponding__to__a__rectangle__
;						of__pixels__from__the__specified__source__device__context__into__a__destination__device__context.
;
;__dDC					handle__to__destination__DC
;__dx					x-coord__of__destination__upper-left__corner
;__dy					y-coord__of__destination__upper-left__corner
;__dw					width__of__the__area__to__copy
;__dh					height__of__the__area__to__copy
;__sDC					handle__to__source__DC
;__sx					x-coordinate__of__source__upper-left__corner
;__sy					y-coordinate__of__source__upper-left__corner
;__Raster				raster__operation__code
;
;__return				If__the__function__succeeds,__the__return__value__is__nonzero
;
;__notes					If__no__raster__operation__is__specified,__then__SRCCOPY__is__used,__which__copies__the__source__directly__to__the__destination__rectangle
;
;__BLACKNESS				=___x________
;__NOTSRCERASE			=___x______A_
;__NOTSRCCOPY			=___x________
;__SRCERASE				=___x________
;__DSTINVERT				=___x________
;__PATINVERT				=___x___A____
;__SRCINVERT				=___x________
;__SRCAND				=___x______C_
;__MERGEPAINT			=___x__BB____
;__MERGECOPY				=___x__C___CA
;__SRCCOPY				=___x__CC____
;__SRCPAINT				=___x__EE____
;__PATCOPY				=___x__F_____
;__PATPAINT				=___x__FB_A__
;__WHITENESS				=___x__FF____
;__CAPTUREBLT			=___x________
;__NOMIRRORBITMAP		=___x________

BitBlt(ddc,__dx,__dy,__dw,__dh,__sdc,__sx,__sy,__Raster="")
{
	return__DllCall("gdi__\BitBlt",__"uint",__dDC,__"int",__dx,__"int",__dy,__"int",__dw,__"int",__dh
	,__"uint",__sDC,__"int",__sx,__"int",__sy,__"uint",__Raster__?__Raster__:___x__CC____)
}

;#####################################################################################

;__Function				StretchBlt
;__Description			The__StretchBlt__function__copies__a__bitmap__from__a__source__rectangle__into__a__destination__rectangle,__
;						stretching__or__compressing__the__bitmap__to__fit__the__dimensions__of__the__destination__rectangle,__if__necessary.
;						The__system__stretches__or__compresses__the__bitmap__according__to__the__stretching__mode__currently__set__in__the__destination__device__context.
;
;__ddc					handle__to__destination__DC
;__dx					x-coord__of__destination__upper-left__corner
;__dy					y-coord__of__destination__upper-left__corner
;__dw					width__of__destination__rectangle
;__dh					height__of__destination__rectangle
;__sdc					handle__to__source__DC
;__sx					x-coordinate__of__source__upper-left__corner
;__sy					y-coordinate__of__source__upper-left__corner
;__sw					width__of__source__rectangle
;__sh					height__of__source__rectangle
;__Raster				raster__operation__code
;
;__return				If__the__function__succeeds,__the__return__value__is__nonzero
;
;__notes					If__no__raster__operation__is__specified,__then__SRCCOPY__is__used.__It__uses__the__same__raster__operations__as__BitBlt		

StretchBlt(ddc,__dx,__dy,__dw,__dh,__sdc,__sx,__sy,__sw,__sh,__Raster="")
{
	return__DllCall("gdi__\StretchBlt",__"uint",__ddc,__"int",__dx,__"int",__dy,__"int",__dw,__"int",__dh
	,__"uint",__sdc,__"int",__sx,__"int",__sy,__"int",__sw,__"int",__sh,__"uint",__Raster__?__Raster__:___x__CC____)
}

;#####################################################################################

;__Function				SetStretchBltMode
;__Description			The__SetStretchBltMode__function__sets__the__bitmap__stretching__mode__in__the__specified__device__context
;
;__hdc					handle__to__the__DC
;__iStretchMode			The__stretching__mode,__describing__how__the__target__will__be__stretched
;
;__return				If__the__function__succeeds,__the__return__value__is__the__previous__stretching__mode.__If__it__fails__it__will__return___
;
;__STRETCH_ANDSCANS__	=___x__
;__STRETCH_ORSCANS__	=___x__
;__STRETCH_DELETESCANS__=___x__
;__STRETCH_HALFTONE__	=___x__

SetStretchBltMode(hdc,__iStretchMode=_)
{
	return__DllCall("gdi__\SetStretchBltMode",__"uint",__hdc,__"int",__iStretchMode)
}

;#####################################################################################

;__Function				SetImage
;__Description			Associates__a__new__image__with__a__static__control
;
;__hwnd					handle__of__the__control__to__update
;__hBitmap				a__gdi__bitmap__to__associate__the__static__control__with
;
;__return				If__the__function__succeeds,__the__return__value__is__nonzero

SetImage(hwnd,__hBitmap)
{
	SendMessage,___x___,___x_,__hBitmap,,__ahk_id__%hwnd%
	E__:=__ErrorLevel
	DeleteObject(E)
	return__E
}

;#####################################################################################

;__Function				SetSysColorToControl
;__Description			Sets__a__solid__colour__to__a__control
;
;__hwnd					handle__of__the__control__to__update
;__SysColor				A__system__colour__to__set__to__the__control
;
;__return				If__the__function__succeeds,__the__return__value__is__zero
;
;__notes					A__control__must__have__the___xE__style__set__to__it__so__it__is__recognised__as__a__bitmap
;						By__default__SysColor=____is__used__which__is__COLOR__DFACE.__This__is__the__standard__background__for__a__control
;
;__COLOR__DDKSHADOW				=____
;__COLOR__DFACE					=____
;__COLOR__DHIGHLIGHT				=____
;__COLOR__DHILIGHT				=____
;__COLOR__DLIGHT					=____
;__COLOR__DSHADOW				=____
;__COLOR_ACTIVEBORDER			=____
;__COLOR_ACTIVECAPTION			=___
;__COLOR_APPWORKSPACE			=____
;__COLOR_BACKGROUND				=___
;__COLOR_BTNFACE					=____
;__COLOR_BTNHIGHLIGHT			=____
;__COLOR_BTNHILIGHT				=____
;__COLOR_BTNSHADOW				=____
;__COLOR_BTNTEXT					=____
;__COLOR_CAPTIONTEXT				=___
;__COLOR_DESKTOP					=___
;__COLOR_GRADIENTACTIVECAPTION	=____
;__COLOR_GRADIENTINACTIVECAPTION	=____
;__COLOR_GRAYTEXT				=____
;__COLOR_HIGHLIGHT				=____
;__COLOR_HIGHLIGHTTEXT			=____
;__COLOR_HOTLIGHT				=____
;__COLOR_INACTIVEBORDER			=____
;__COLOR_INACTIVECAPTION			=___
;__COLOR_INACTIVECAPTIONTEXT		=____
;__COLOR_INFOBK					=____
;__COLOR_INFOTEXT				=____
;__COLOR_MENU					=___
;__COLOR_MENUHILIGHT				=____
;__COLOR_MENUBAR					=____
;__COLOR_MENUTEXT				=___
;__COLOR_SCROLLBAR				=___
;__COLOR_WINDOW					=___
;__COLOR_WINDOWFRAME				=___
;__COLOR_WINDOWTEXT				=___

SetSysColorToControl(hwnd,__SysColor=__)
{
____WinGetPos,,,__w,__h,__ahk_id__%hwnd%
____bc__:=__DllCall("GetSysColor",__"Int",__SysColor)
____pBrushClear__:=__Gdip_BrushCreateSolid(_xff________|__(bc__>>______|__bc__&___xff____|__(bc__&___xff)__<<____))
____pBitmap__:=__Gdip_CreateBitmap(w,__h),__G__:=__Gdip_GraphicsFromImage(pBitmap)
____Gdip_FillRectangle(G,__pBrushClear,___,___,__w,__h)
____hBitmap__:=__Gdip_CreateHBITMAPFromBitmap(pBitmap)
____SetImage(hwnd,__hBitmap)
____Gdip_DeleteBrush(pBrushClear)
____Gdip_DeleteGraphics(G),__Gdip_DisposeImage(pBitmap),__DeleteObject(hBitmap)
____return___
}

;#####################################################################################

;__Function				Gdip_BitmapFromScreen
;__Description			Gets__a__gdi+__bitmap__from__the__screen
;
;__Screen				___=__All__screens
;						Any__numerical__value__=__Just__that__screen
;						x|y|w|h__=__Take__specific__coordinates__with__a__width__and__height
;__Raster				raster__operation__code
;
;__return______			If__the__function__succeeds,__the__return__value__is__a__pointer__to__a__gdi+__bitmap
;						-_:		one__or__more__of__x,y,w,h__not__passed__properly
;
;__notes					If__no__raster__operation__is__specified,__then__SRCCOPY__is__used__to__the__returned__bitmap

Gdip_BitmapFromScreen(Screen=_,__Raster="")
{
	if__(Screen__=___)
	{
		Sysget,__x,____
		Sysget,__y,____	
		Sysget,__w,____
		Sysget,__h,____
	}
	else__if__(SubStr(Screen,___,___)__=__"hwnd:")
	{
		Screen__:=__SubStr(Screen,___)
		if__!WinExist(__"ahk_id__"__Screen)
			return__-_
		WinGetPos,,,__w,__h,__ahk_id__%Screen%
		x__:=__y__:=___
		hhdc__:=__GetDCEx(Screen,___)
	}
	else__if__(Screen&___!=__"")
	{
		Sysget,__M,__Monitor,__%Screen%
		x__:=__MLeft,__y__:=__MTop,__w__:=__MRight-MLeft,__h__:=__MBottom-MTop
	}
	else
	{
		StringSplit,__S,__Screen,__|
		x__:=__S_,__y__:=__S_,__w__:=__S_,__h__:=__S_
	}

	if__(x__=__"")__||__(y__=__"")__||__(w__=__"")__||__(h__=__"")
		return__-_

	chdc__:=__CreateCompatibleDC(),__hbm__:=__CreateDIBSection(w,__h,__chdc),__obm__:=__SelectObject(chdc,__hbm),__hhdc__:=__hhdc__?__hhdc__:__GetDC()
	BitBlt(chdc,___,___,__w,__h,__hhdc,__x,__y,__Raster)
	ReleaseDC(hhdc)
	
	pBitmap__:=__Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc,__obm),__DeleteObject(hbm),__DeleteDC(hhdc),__DeleteDC(chdc)
	return__pBitmap
}

;#####################################################################################

;__Function				Gdip_BitmapFromHWND
;__Description			Uses__PrintWindow__to__get__a__handle__to__the__specified__window__and__return__a__bitmap__from__it
;
;__hwnd					handle__to__the__window__to__get__a__bitmap__from
;
;__return				If__the__function__succeeds,__the__return__value__is__a__pointer__to__a__gdi+__bitmap
;
;__notes					Window__must__not__be__not__minimised__in__order__to__get__a__handle__to__it's__client__area

Gdip_BitmapFromHWND(hwnd)
{
	WinGetPos,,,__Width,__Height,__ahk_id__%hwnd%
	hbm__:=__CreateDIBSection(Width,__Height),__hdc__:=__CreateCompatibleDC(),__obm__:=__SelectObject(hdc,__hbm)
	PrintWindow(hwnd,__hdc)
	pBitmap__:=__Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc,__obm),__DeleteObject(hbm),__DeleteDC(hdc)
	return__pBitmap
}

;#####################################################################################

;__Function____			CreateRectF
;__Description			Creates__a__RectF__object,__containing__a__the__coordinates__and__dimensions__of__a__rectangle
;
;__RectF________		Name__to__call__the__RectF__object
;__x____________			x-coordinate__of__the__upper__left__corner__of__the__rectangle
;__y____________			y-coordinate__of__the__upper__left__corner__of__the__rectangle
;__w____________			Width__of__the__rectangle
;__h____________			Height__of__the__rectangle
;
;__return______			No__return__value

CreateRectF(ByRef__RectF,__x,__y,__w,__h)
{
____VarSetCapacity(RectF,____)
____NumPut(x,__RectF,___,__"float"),__NumPut(y,__RectF,___,__"float"),__NumPut(w,__RectF,___,__"float"),__NumPut(h,__RectF,____,__"float")
}

;#####################################################################################

;__Function____			CreateRect
;__Description			Creates__a__Rect__object,__containing__a__the__coordinates__and__dimensions__of__a__rectangle
;
;__RectF________		Name__to__call__the__RectF__object
;__x____________			x-coordinate__of__the__upper__left__corner__of__the__rectangle
;__y____________			y-coordinate__of__the__upper__left__corner__of__the__rectangle
;__w____________			Width__of__the__rectangle
;__h____________			Height__of__the__rectangle
;
;__return______			No__return__value

CreateRect(ByRef__Rect,__x,__y,__w,__h)
{
	VarSetCapacity(Rect,____)
	NumPut(x,__Rect,___,__"uint"),__NumPut(y,__Rect,___,__"uint"),__NumPut(w,__Rect,___,__"uint"),__NumPut(h,__Rect,____,__"uint")
}
;#####################################################################################

;__Function		____	CreateSizeF
;__Description			Creates__a__SizeF__object,__containing__an_____values
;
;__SizeF__________	Name__to__call__the__SizeF__object
;__w____________			w-value__for__the__SizeF__object
;__h____________			h-value__for__the__SizeF__object
;
;__return______			No__Return__value

CreateSizeF(ByRef__SizeF,__w,__h)
{
____VarSetCapacity(SizeF,___)
____NumPut(w,__SizeF,___,__"float"),__NumPut(h,__SizeF,___,__"float")______
}
;#####################################################################################

;__Function		____	CreatePointF
;__Description			Creates__a__SizeF__object,__containing__an_____values
;
;__SizeF__________	Name__to__call__the__SizeF__object
;__w____________			w-value__for__the__SizeF__object
;__h____________			h-value__for__the__SizeF__object
;
;__return______			No__Return__value

CreatePointF(ByRef__PointF,__x,__y)
{
____VarSetCapacity(PointF,___)
____NumPut(x,__PointF,___,__"float"),__NumPut(y,__PointF,___,__"float")______
}
;#####################################################################################

;__Function				CreateDIBSection
;__Description			The__CreateDIBSection__function__creates__a__DIB__(Device__Independent__Bitmap)__that__applications__can__write__to__directly
;
;__w						width__of__the__bitmap__to__create
;__h						height__of__the__bitmap__to__create
;__hdc					a__handle__to__the__device__context__to__use__the__palette__from
;__bpp					bits__per__pixel__(____=__ARGB)
;__ppvBits				A__pointer__to__a__variable__that__receives__a__pointer__to__the__location__of__the__DIB__bit__values
;
;__return				returns__a__DIB.__A__gdi__bitmap
;
;__notes					ppvBits__will__receive__the__location__of__the__pixels__in__the__DIB

CreateDIBSection(w,__h,__hdc="",__bpp=__,__ByRef__ppvBits=_)
{
	hdc___:=__hdc__?__hdc__:__GetDC()
	VarSetCapacity(bi,____,___)
	NumPut(w,__bi,___),__NumPut(h,__bi,___),__NumPut(__,__bi,___),__NumPut(_,__bi,____,__"ushort"),__NumPut(_,__bi,____),__NumPut(bpp,__bi,____,__"ushort")
	hbm__:=__DllCall("CreateDIBSection",__"uint"__,__hdc_,__"uint"__,__&bi,__"uint"__,___,__"uint*",__ppvBits,__"uint"__,___,__"uint"__,___)

	if__!hdc
		ReleaseDC(hdc_)
	return__hbm
}

;#####################################################################################

;__Function				PrintWindow
;__Description			The__PrintWindow__function__copies__a__visual__window__into__the__specified__device__context__(DC),__typically__a__printer__DC
;
;__hwnd					A__handle__to__the__window__that__will__be__copied
;__hdc					A__handle__to__the__device__context
;__Flags					Drawing__options
;
;__return				If__the__function__succeeds,__it__returns__a__nonzero__value
;
;__PW_CLIENTONLY			=___

PrintWindow(hwnd,__hdc,__Flags=_)
{
	return__DllCall("PrintWindow",__"uint",__hwnd,__"uint",__hdc,__"uint",__Flags)
}

;#####################################################################################

;__Function				DestroyIcon
;__Description			Destroys__an__icon__and__frees__any__memory__the__icon__occupied
;
;__hIcon					Handle__to__the__icon__to__be__destroyed.__The__icon__must__not__be__in__use
;
;__return				If__the__function__succeeds,__the__return__value__is__nonzero

DestroyIcon(hIcon)
{
____return__DllCall("DestroyIcon",__"uint",__hIcon)
}

;#####################################################################################

PaintDesktop(hdc)
{
	return__DllCall("PaintDesktop",__"uint",__hdc)
}

;#####################################################################################

CreateCompatibleBitmap(hdc,__w,__h)
{
	return__DllCall("gdi__\CreateCompatibleBitmap",__"uint",__hdc,__"int",__w,__"int",__h)
}

;#####################################################################################

;__Function				CreateCompatibleDC
;__Description			This__function__creates__a__memory__device__context__(DC)__compatible__with__the__specified__device
;
;__hdc					Handle__to__an__existing__device__context					
;
;__return				returns__the__handle__to__a__device__context__or_____on__failure
;
;__notes					If__this__handle__is_____(by__default),__the__function__creates__a__memory__device__context__compatible__with__the__application's__current__screen

CreateCompatibleDC(hdc=_)
{
____return__DllCall("CreateCompatibleDC",__"uint",__hdc)
}

;#####################################################################################

;__Function				SelectObject
;__Description			The__SelectObject__function__selects__an__object__into__the__specified__device__context__(DC).__The__new__object__replaces__the__previous__object__of__the__same__type
;
;__hdc					Handle__to__a__DC
;__hgdiobj				A__handle__to__the__object__to__be__selected__into__the__DC
;
;__return				If__the__selected__object__is__not__a__region__and__the__function__succeeds,__the__return__value__is__a__handle__to__the__object__being__replaced
;
;__notes					The__specified__object__must__have__been__created__by__using__one__of__the__following__functions
;						Bitmap__-__CreateBitmap,__CreateBitmapIndirect,__CreateCompatibleBitmap,__CreateDIBitmap,__CreateDIBSection__(A__single__bitmap__cannot__be__selected__into__more__than__one__DC__at__the__same__time)
;						Brush__-__CreateBrushIndirect,__CreateDIBPatternBrush,__CreateDIBPatternBrushPt,__CreateHatchBrush,__CreatePatternBrush,__CreateSolidBrush
;						Font__-__CreateFont,__CreateFontIndirect
;						Pen__-__CreatePen,__CreatePenIndirect
;						Region__-__CombineRgn,__CreateEllipticRgn,__CreateEllipticRgnIndirect,__CreatePolygonRgn,__CreateRectRgn,__CreateRectRgnIndirect
;
;__notes					If__the__selected__object__is__a__region__and__the__function__succeeds,__the__return__value__is__one__of__the__following__value
;
;__SIMPLEREGION			=_____Region__consists__of__a__single__rectangle
;__COMPLEXREGION			=_____Region__consists__of__more__than__one__rectangle
;__NULLREGION			=_____Region__is__empty

SelectObject(hdc,__hgdiobj)
{
____return__DllCall("SelectObject",__"uint",__hdc,__"uint",__hgdiobj)
}

;#####################################################################################

;__Function				DeleteObject
;__Description			This__function__deletes__a__logical__pen,__brush,__font,__bitmap,__region,__or__palette,__freeing__all__system__resources__associated__with__the__object
;						After__the__object__is__deleted,__the__specified__handle__is__no__longer__valid
;
;__hObject				Handle__to__a__logical__pen,__brush,__font,__bitmap,__region,__or__palette__to__delete
;
;__return				Nonzero__indicates__success.__Zero__indicates__that__the__specified__handle__is__not__valid__or__that__the__handle__is__currently__selected__into__a__device__context

DeleteObject(hObject)
{
____return__DllCall("DeleteObject",__"uint",__hObject)
}

;#####################################################################################

;__Function				GetDC
;__Description			This__function__retrieves__a__handle__to__a__display__device__context__(DC)__for__the__client__area__of__the__specified__window.
;						The__display__device__context__can__be__used__in__subsequent__graphics__display__interface__(GDI)__functions__to__draw__in__the__client__area__of__the__window.__
;
;__hwnd					Handle__to__the__window__whose__device__context__is__to__be__retrieved.__If__this__value__is__NULL,__GetDC__retrieves__the__device__context__for__the__entire__screen					
;
;__return				The__handle__the__device__context__for__the__specified__window's__client__area__indicates__success.__NULL__indicates__failure

GetDC(hwnd=_)
{
	return__DllCall("GetDC",__"uint",__hwnd)
}

;#####################################################################################

;__DCX_CACHE__=___x_
;__DCX_CLIPCHILDREN__=___x_
;__DCX_CLIPSIBLINGS__=___x__
;__DCX_EXCLUDERGN__=___x__
;__DCX_EXCLUDEUPDATE__=___x___
;__DCX_INTERSECTRGN__=___x__
;__DCX_INTERSECTUPDATE__=___x___
;__DCX_LOCKWINDOWUPDATE__=___x___
;__DCX_NORECOMPUTE__=___x______
;__DCX_NORESETATTRS__=___x_
;__DCX_PARENTCLIP__=___x__
;__DCX_VALIDATE__=___x______
;__DCX_WINDOW__=___x_

GetDCEx(hwnd,__flags=_,__hrgnClip=_)
{
____return__DllCall("GetDCEx",__"uint",__hwnd,__"uint",__hrgnClip,__"int",__flags)
}

;#####################################################################################

;__Function				ReleaseDC
;__Description			This__function__releases__a__device__context__(DC),__freeing__it__for__use__by__other__applications.__The__effect__of__ReleaseDC__depends__on__the__type__of__device__context
;
;__hdc					Handle__to__the__device__context__to__be__released
;__hwnd					Handle__to__the__window__whose__device__context__is__to__be__released
;
;__return				___=__released
;						___=__not__released
;
;__notes					The__application__must__call__the__ReleaseDC__function__for__each__call__to__the__GetWindowDC__function__and__for__each__call__to__the__GetDC__function__that__retrieves__a__common__device__context
;						An__application__cannot__use__the__ReleaseDC__function__to__release__a__device__context__that__was__created__by__calling__the__CreateDC__function;__instead,__it__must__use__the__DeleteDC__function.__

ReleaseDC(hdc,__hwnd=_)
{
____return__DllCall("ReleaseDC",__"uint",__hwnd,__"uint",__hdc)
}

;#####################################################################################

;__Function				DeleteDC
;__Description			The__DeleteDC__function__deletes__the__specified__device__context__(DC)
;
;__hdc					A__handle__to__the__device__context
;
;__return				If__the__function__succeeds,__the__return__value__is__nonzero
;
;__notes					An__application__must__not__delete__a__DC__whose__handle__was__obtained__by__calling__the__GetDC__function.__Instead,__it__must__call__the__ReleaseDC__function__to__free__the__DC

DeleteDC(hdc)
{
____return__DllCall("DeleteDC",__"uint",__hdc)
}
;#####################################################################################

;__Function				Gdip_LibraryVersion
;__Description			Get__the__current__library__version
;
;__return				the__library__version
;
;__notes					This__is__useful__for__non__compiled__programs__to__ensure__that__a__person__doesn't__run__an__old__version__when__testing__your__scripts

Gdip_LibraryVersion()
{
	return___.__
}

;#####################################################################################

;__Function:____			Gdip_BitmapFromBRA
;__Description:__		Gets__a__pointer__to__a__gdi+__bitmap__from__a__BRA__file
;
;__BRAFromMemIn			The__variable__for__a__BRA__file__read__to__memory
;__File					The__name__of__the__file,__or__its__number__that__you__would__like__(This__depends__on__alternate__parameter)
;__Alternate				Changes__whether__the__File__parameter__is__the__file__name__or__its__number
;
;__return______			If__the__function__succeeds,__the__return__value__is__a__pointer__to__a__gdi+__bitmap
;						-___=__The__BRA__variable__is__empty
;						-___=__The__BRA__has__an__incorrect__header
;						-___=__The__BRA__has__information__missing
;						-___=__Could__not__find__file__inside__the__BRA

Gdip_BitmapFromBRA(ByRef__BRAFromMemIn,__File,__Alternate=_)
{
	if__!BRAFromMemIn
		return__-_
	Loop,__Parse,__BRAFromMemIn,__`n
	{
		if__(A_Index__=___)
		{
			StringSplit,__Header,__A_LoopField,__|
			if__(Header___!=_____||__Header___!=__"BRA!")
				return__-_
		}
		else__if__(A_Index__=___)
		{
			StringSplit,__Info,__A_LoopField,__|
			if__(Info___!=___)
				return__-_
		}
		else
			break
	}
	if__!Alternate
		StringReplace,__File,__File,__\,__\\,__All
	RegExMatch(BRAFromMemIn,__"mi`n)^"__(Alternate__?__File__"\|.+?\|(\d+)\|(\d+)"__:__"\d+\|"__File__"\|(\d+)\|(\d+)")__"$",__FileInfo)
	if__!FileInfo
		return__-_

	hData__:=__DllCall("GlobalAlloc",__"uint",___,__"uint",__FileInfo_)
	pData__:=__DllCall("GlobalLock",__"uint",__hData)
	DllCall("RtlMoveMemory",__"uint",__pData,__"uint",__&BRAFromMemIn+Info_+FileInfo_,__"uint",__FileInfo_)
	DllCall("GlobalUnlock",__"uint",__hData)
	DllCall("ole__\CreateStreamOnHGlobal",__"uint",__hData,__"int",___,__"uint*",__pStream)
	DllCall("gdiplus\GdipCreateBitmapFromStream",__"uint",__pStream,__"uint*",__pBitmap)
	DllCall(NumGet(NumGet(_*pStream)+_),__"uint",__pStream)
	return__pBitmap
}

;#####################################################################################

;__Function				Gdip_DrawRectangle
;__Description			This__function__uses__a__pen__to__draw__the__outline__of__a__rectangle__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x						x-coordinate__of__the__top__left__of__the__rectangle
;__y						y-coordinate__of__the__top__left__of__the__rectangle
;__w						width__of__the__rectanlge
;__h						height__of__the__rectangle
;
;__return				status__enumeration._____=__success
;
;__notes					as__all__coordinates__are__taken__from__the__top__left__of__each__pixel,__then__the__entire__width/height__should__be__specified__as__subtracting__the__pen__width

Gdip_DrawRectangle(pGraphics,__pPen,__x,__y,__w,__h)
{
____return__DllCall("gdiplus\GdipDrawRectangle",__"uint",__pGraphics,__"uint",__pPen,__"float",__x,__"float",__y,__"float",__w,__"float",__h)
}

;#####################################################################################

;__Function				Gdip_DrawRoundedRectangle
;__Description			This__function__uses__a__pen__to__draw__the__outline__of__a__rounded__rectangle__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x						x-coordinate__of__the__top__left__of__the__rounded__rectangle
;__y						y-coordinate__of__the__top__left__of__the__rounded__rectangle
;__w						width__of__the__rectanlge
;__h						height__of__the__rectangle
;__r						radius__of__the__rounded__corners
;
;__return				status__enumeration._____=__success
;
;__notes					as__all__coordinates__are__taken__from__the__top__left__of__each__pixel,__then__the__entire__width/height__should__be__specified__as__subtracting__the__pen__width

Gdip_DrawRoundedRectangle(pGraphics,__pPen,__x,__y,__w,__h,__r)
{
	Gdip_SetClipRect(pGraphics,__x-r,__y-r,___*r,___*r,___)
	Gdip_SetClipRect(pGraphics,__x+w-r,__y-r,___*r,___*r,___)
	Gdip_SetClipRect(pGraphics,__x-r,__y+h-r,___*r,___*r,___)
	Gdip_SetClipRect(pGraphics,__x+w-r,__y+h-r,___*r,___*r,___)
	E__:=__Gdip_DrawRectangle(pGraphics,__pPen,__x,__y,__w,__h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics,__x-(_*r),__y+r,__w+(_*r),__h-(_*r),___)
	Gdip_SetClipRect(pGraphics,__x+r,__y-(_*r),__w-(_*r),__h+(_*r),___)
	Gdip_DrawEllipse(pGraphics,__pPen,__x,__y,___*r,___*r)
	Gdip_DrawEllipse(pGraphics,__pPen,__x+w-(_*r),__y,___*r,___*r)
	Gdip_DrawEllipse(pGraphics,__pPen,__x,__y+h-(_*r),___*r,___*r)
	Gdip_DrawEllipse(pGraphics,__pPen,__x+w-(_*r),__y+h-(_*r),___*r,___*r)
	Gdip_ResetClip(pGraphics)
	return__E
}

;#####################################################################################

;__Function				Gdip_DrawEllipse
;__Description			This__function__uses__a__pen__to__draw__the__outline__of__an__ellipse__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x						x-coordinate__of__the__top__left__of__the__rectangle__the__ellipse__will__be__drawn__into
;__y						y-coordinate__of__the__top__left__of__the__rectangle__the__ellipse__will__be__drawn__into
;__w						width__of__the__ellipse
;__h						height__of__the__ellipse
;
;__return				status__enumeration._____=__success
;
;__notes					as__all__coordinates__are__taken__from__the__top__left__of__each__pixel,__then__the__entire__width/height__should__be__specified__as__subtracting__the__pen__width

Gdip_DrawEllipse(pGraphics,__pPen,__x,__y,__w,__h)
{
____return__DllCall("gdiplus\GdipDrawEllipse",__"uint",__pGraphics,__"uint",__pPen,__"float",__x,__"float",__y,__"float",__w,__"float",__h)
}

;#####################################################################################

;__Function				Gdip_DrawBezier
;__Description			This__function__uses__a__pen__to__draw__the__outline__of__a__bezier__(a__weighted__curve)__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x_					x-coordinate__of__the__start__of__the__bezier
;__y_					y-coordinate__of__the__start__of__the__bezier
;__x_					x-coordinate__of__the__first__arc__of__the__bezier
;__y_					y-coordinate__of__the__first__arc__of__the__bezier
;__x_					x-coordinate__of__the__second__arc__of__the__bezier
;__y_					y-coordinate__of__the__second__arc__of__the__bezier
;__x_					x-coordinate__of__the__end__of__the__bezier
;__y_					y-coordinate__of__the__end__of__the__bezier
;
;__return				status__enumeration._____=__success
;
;__notes					as__all__coordinates__are__taken__from__the__top__left__of__each__pixel,__then__the__entire__width/height__should__be__specified__as__subtracting__the__pen__width

Gdip_DrawBezier(pGraphics,__pPen,__x_,__y_,__x_,__y_,__x_,__y_,__x_,__y_)
{
____return__DllCall("gdiplus\GdipDrawBezier",__"uint",__pgraphics,__"uint",__pPen
____,__"float",__x_,__"float",__y_,__"float",__x_,__"float",__y_
____,__"float",__x_,__"float",__y_,__"float",__x_,__"float",__y_)
}

;#####################################################################################

;__Function				Gdip_DrawArc
;__Description			This__function__uses__a__pen__to__draw__the__outline__of__an__arc__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x						x-coordinate__of__the__start__of__the__arc
;__y						y-coordinate__of__the__start__of__the__arc
;__w						width__of__the__arc
;__h						height__of__the__arc
;__StartAngle			specifies__the__angle__between__the__x-axis__and__the__starting__point__of__the__arc
;__SweepAngle			specifies__the__angle__between__the__starting__and__ending__points__of__the__arc
;
;__return				status__enumeration._____=__success
;
;__notes					as__all__coordinates__are__taken__from__the__top__left__of__each__pixel,__then__the__entire__width/height__should__be__specified__as__subtracting__the__pen__width

Gdip_DrawArc(pGraphics,__pPen,__x,__y,__w,__h,__StartAngle,__SweepAngle)
{
____return__DllCall("gdiplus\GdipDrawArc",__"uint",__pGraphics,__"uint",__pPen,__"float",__x
____,__"float",__y,__"float",__w,__"float",__h,__"float",__StartAngle,__"float",__SweepAngle)
}

;#####################################################################################

;__Function				Gdip_DrawPie
;__Description			This__function__uses__a__pen__to__draw__the__outline__of__a__pie__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x						x-coordinate__of__the__start__of__the__pie
;__y						y-coordinate__of__the__start__of__the__pie
;__w						width__of__the__pie
;__h						height__of__the__pie
;__StartAngle			specifies__the__angle__between__the__x-axis__and__the__starting__point__of__the__pie
;__SweepAngle			specifies__the__angle__between__the__starting__and__ending__points__of__the__pie
;
;__return				status__enumeration._____=__success
;
;__notes					as__all__coordinates__are__taken__from__the__top__left__of__each__pixel,__then__the__entire__width/height__should__be__specified__as__subtracting__the__pen__width

Gdip_DrawPie(pGraphics,__pPen,__x,__y,__w,__h,__StartAngle,__SweepAngle)
{
____return__DllCall("gdiplus\GdipDrawPie",__"uint",__pGraphics,__"uint",__pPen,__"float",__x,__"float",__y,__"float",__w,__"float",__h,__"float",__StartAngle,__"float",__SweepAngle)
}

;#####################################################################################

;__Function				Gdip_DrawLine
;__Description			This__function__uses__a__pen__to__draw__a__line__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__x_					x-coordinate__of__the__start__of__the__line
;__y_					y-coordinate__of__the__start__of__the__line
;__x_					x-coordinate__of__the__end__of__the__line
;__y_					y-coordinate__of__the__end__of__the__line
;
;__return				status__enumeration._____=__success		

Gdip_DrawLine(pGraphics,__pPen,__x_,__y_,__x_,__y_)
{
____return__DllCall("gdiplus\GdipDrawLine",__"uint",__pGraphics,__"uint",__pPen
____,__"float",__x_,__"float",__y_,__"float",__x_,__"float",__y_)
}

;#####################################################################################

;__Function				Gdip_DrawLines
;__Description			This__function__uses__a__pen__to__draw__a__series__of__joined__lines__into__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pPen					Pointer__to__a__pen
;__Points				the__coordinates__of__all__the__points__passed__as__x_,y_|x_,y_|x_,y_.....
;
;__return				status__enumeration._____=__success				

Gdip_DrawLines(pGraphics,__pPen,__Points)
{
____StringSplit,__Points,__Points,__|
____VarSetCapacity(PointF,___*Points_)____
____Loop,__%Points_%
____{
______StringSplit,__Coord,__Points%A_Index%,__`,
______NumPut(Coord_,__PointF,___*(A_Index-_),__"float"),__NumPut(Coord_,__PointF,__(_*(A_Index-_))+_,__"float")
____}
____return__DllCall("gdiplus\GdipDrawLines",__"uint",__pGraphics,__"uint",__pPen,__"uint",__&PointF,__"int",__Points_)
}

;#####################################################################################

;__Function				Gdip_FillRectangle
;__Description			This__function__uses__a__brush__to__fill__a__rectangle__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__x						x-coordinate__of__the__top__left__of__the__rectangle
;__y						y-coordinate__of__the__top__left__of__the__rectangle
;__w						width__of__the__rectanlge
;__h						height__of__the__rectangle
;
;__return				status__enumeration._____=__success

Gdip_FillRectangle(pGraphics,__pBrush,__x,__y,__w,__h)
{
____return__DllCall("gdiplus\GdipFillRectangle",__"uint",__pGraphics,__"int",__pBrush
____,__"float",__x,__"float",__y,__"float",__w,__"float",__h)
}

;#####################################################################################

;__Function				Gdip_FillRoundedRectangle
;__Description			This__function__uses__a__brush__to__fill__a__rounded__rectangle__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__x						x-coordinate__of__the__top__left__of__the__rounded__rectangle
;__y						y-coordinate__of__the__top__left__of__the__rounded__rectangle
;__w						width__of__the__rectanlge
;__h						height__of__the__rectangle
;__r						radius__of__the__rounded__corners
;
;__return				status__enumeration._____=__success

Gdip_FillRoundedRectangle(pGraphics,__pBrush,__x,__y,__w,__h,__r)
{
	Region__:=__Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics,__x-r,__y-r,___*r,___*r,___)
	Gdip_SetClipRect(pGraphics,__x+w-r,__y-r,___*r,___*r,___)
	Gdip_SetClipRect(pGraphics,__x-r,__y+h-r,___*r,___*r,___)
	Gdip_SetClipRect(pGraphics,__x+w-r,__y+h-r,___*r,___*r,___)
	E__:=__Gdip_FillRectangle(pGraphics,__pBrush,__x,__y,__w,__h)
	Gdip_SetClipRegion(pGraphics,__Region,___)
	Gdip_SetClipRect(pGraphics,__x-(_*r),__y+r,__w+(_*r),__h-(_*r),___)
	Gdip_SetClipRect(pGraphics,__x+r,__y-(_*r),__w-(_*r),__h+(_*r),___)
	Gdip_FillEllipse(pGraphics,__pBrush,__x,__y,___*r,___*r)
	Gdip_FillEllipse(pGraphics,__pBrush,__x+w-(_*r),__y,___*r,___*r)
	Gdip_FillEllipse(pGraphics,__pBrush,__x,__y+h-(_*r),___*r,___*r)
	Gdip_FillEllipse(pGraphics,__pBrush,__x+w-(_*r),__y+h-(_*r),___*r,___*r)
	Gdip_SetClipRegion(pGraphics,__Region,___)
	Gdip_DeleteRegion(Region)
	return__E
}

;#####################################################################################

;__Function				Gdip_FillPolygon
;__Description			This__function__uses__a__brush__to__fill__a__polygon__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__Points				the__coordinates__of__all__the__points__passed__as__x_,y_|x_,y_|x_,y_.....
;
;__return				status__enumeration._____=__success
;
;__notes					Alternate__will__fill__the__polygon__as__a__whole,__wheras__winding__will__fill__each__new__"segment"
;__Alternate__		=___
;__Winding__			=___

Gdip_FillPolygon(pGraphics,__pBrush,__Points,__FillMode=_)
{
____StringSplit,__Points,__Points,__|
____VarSetCapacity(PointF,___*Points_)____
____Loop,__%Points_%
____{
______StringSplit,__Coord,__Points%A_Index%,__`,
______NumPut(Coord_,__PointF,___*(A_Index-_),__"float"),__NumPut(Coord_,__PointF,__(_*(A_Index-_))+_,__"float")
____}____
____return__DllCall("gdiplus\GdipFillPolygon",__"uint",__pGraphics,__"uint",__pBrush,__"uint",__&PointF,__"int",__Points_,__"int",__FillMode)
}

;#####################################################################################

;__Function				Gdip_FillPie
;__Description			This__function__uses__a__brush__to__fill__a__pie__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__x						x-coordinate__of__the__top__left__of__the__pie
;__y						y-coordinate__of__the__top__left__of__the__pie
;__w						width__of__the__pie
;__h						height__of__the__pie
;__StartAngle			specifies__the__angle__between__the__x-axis__and__the__starting__point__of__the__pie
;__SweepAngle			specifies__the__angle__between__the__starting__and__ending__points__of__the__pie
;
;__return				status__enumeration._____=__success

Gdip_FillPie(pGraphics,__pBrush,__x,__y,__w,__h,__StartAngle,__SweepAngle)
{
____return__DllCall("gdiplus\GdipFillPie",__"uint",__pGraphics,__"uint",__pBrush
____,__"float",__x,__"float",__y,__"float",__w,__"float",__h,__"float",__StartAngle,__"float",__SweepAngle)
}

;#####################################################################################

;__Function				Gdip_FillEllipse
;__Description			This__function__uses__a__brush__to__fill__an__ellipse__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__x						x-coordinate__of__the__top__left__of__the__ellipse
;__y						y-coordinate__of__the__top__left__of__the__ellipse
;__w						width__of__the__ellipse
;__h						height__of__the__ellipse
;
;__return				status__enumeration._____=__success

Gdip_FillEllipse(pGraphics,__pBrush,__x,__y,__w,__h)
{
	return__DllCall("gdiplus\GdipFillEllipse",__"uint",__pGraphics,__"uint",__pBrush,__"float",__x,__"float",__y,__"float",__w,__"float",__h)
}

;#####################################################################################

;__Function				Gdip_FillRegion
;__Description			This__function__uses__a__brush__to__fill__a__region__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__Region				Pointer__to__a__Region
;
;__return				status__enumeration._____=__success
;
;__notes					You__can__create__a__region__Gdip_CreateRegion()__and__then__add__to__this

Gdip_FillRegion(pGraphics,__pBrush,__Region)
{
	return__DllCall("gdiplus\GdipFillRegion",__"uint",__pGraphics,__"uint",__pBrush,__"uint",__Region)
}

;#####################################################################################

;__Function				Gdip_FillPath
;__Description			This__function__uses__a__brush__to__fill__a__path__in__the__Graphics__of__a__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBrush				Pointer__to__a__brush
;__Region				Pointer__to__a__Path
;
;__return				status__enumeration._____=__success

Gdip_FillPath(pGraphics,__pBrush,__Path)
{
	return__DllCall("gdiplus\GdipFillPath",__"uint",__pGraphics,__"uint",__pBrush,__"uint",__Path)
}

;#####################################################################################

;__Function				Gdip_DrawImagePointsRect
;__Description			This__function__draws__a__bitmap__into__the__Graphics__of__another__bitmap__and__skews__it
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBitmap				Pointer__to__a__bitmap__to__be__drawn
;__Points				Points__passed__as__x_,y_|x_,y_|x_,y___(___points:__top__left,__top__right,__bottom__left)__describing__the__drawing__of__the__bitmap
;__sx					x-coordinate__of__source__upper-left__corner
;__sy					y-coordinate__of__source__upper-left__corner
;__sw					width__of__source__rectangle
;__sh					height__of__source__rectangle
;__Matrix				a__matrix__used__to__alter__image__attributes__when__drawing
;
;__return				status__enumeration._____=__success
;
;__notes					if__sx,sy,sw,sh__are__missed__then__the__entire__source__bitmap__will__be__used
;						Matrix__can__be__omitted__to__just__draw__with__no__alteration__to__ARGB
;						Matrix__may__be__passed__as__a__digit__from_____-_____to__change__just__transparency
;						Matrix__can__be__passed__as__a__matrix__with__any__delimiter

Gdip_DrawImagePointsRect(pGraphics,__pBitmap,__Points,__sx="",__sy="",__sw="",__sh="",__Matrix=_)
{
	StringSplit,__Points,__Points,__|
	VarSetCapacity(PointF,___*Points_)____
	Loop,__%Points_%
	{
		StringSplit,__Coord,__Points%A_Index%,__`,
		NumPut(Coord_,__PointF,___*(A_Index-_),__"float"),__NumPut(Coord_,__PointF,__(_*(A_Index-_))+_,__"float")
	}

	if__(Matrix&___=__"")
		ImageAttr__:=__Gdip_SetImageAttributesColorMatrix(Matrix)
	else__if__(Matrix__!=___)
		ImageAttr__:=__Gdip_SetImageAttributesColorMatrix("_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|"__Matrix__"|_|_|_|_|_|_")
		
	if__(sx__=__""__&&__sy__=__""__&&__sw__=__""__&&__sh__=__"")
	{
		sx__:=___,__sy__:=___
		sw__:=__Gdip_GetImageWidth(pBitmap)
		sh__:=__Gdip_GetImageHeight(pBitmap)
	}

	E__:=__DllCall("gdiplus\GdipDrawImagePointsRect",__"uint",__pGraphics,__"uint",__pBitmap
	,__"uint",__&PointF,__"int",__Points_,__"float",__sx,__"float",__sy,__"float",__sw,__"float",__sh
	,__"int",___,__"uint",__ImageAttr,__"uint",___,__"uint",___)
	if__ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return__E
}

;#####################################################################################

;__Function				Gdip_DrawImage
;__Description			This__function__draws__a__bitmap__into__the__Graphics__of__another__bitmap
;
;__pGraphics				Pointer__to__the__Graphics__of__a__bitmap
;__pBitmap				Pointer__to__a__bitmap__to__be__drawn
;__dx					x-coord__of__destination__upper-left__corner
;__dy					y-coord__of__destination__upper-left__corner
;__dw					width__of__destination__image
;__dh					height__of__destination__image
;__sx					x-coordinate__of__source__upper-left__corner
;__sy					y-coordinate__of__source__upper-left__corner
;__sw					width__of__source__image
;__sh					height__of__source__image
;__Matrix				a__matrix__used__to__alter__image__attributes__when__drawing
;
;__return				status__enumeration._____=__success
;
;__notes					if__sx,sy,sw,sh__are__missed__then__the__entire__source__bitmap__will__be__used
;						Gdip_DrawImage__performs__faster
;						Matrix__can__be__omitted__to__just__draw__with__no__alteration__to__ARGB
;						Matrix__may__be__passed__as__a__digit__from_____-_____to__change__just__transparency
;						Matrix__can__be__passed__as__a__matrix__with__any__delimiter.__For__example:
;						MatrixBright=
;						(
;						_._		|_		|_		|_		|_
;						_		|_._	|_		|_		|_
;						_		|_		|_._	|_		|_
;						_		|_		|_		|_		|_
;						_.__	|_.__	|_.__	|_		|_
;						)
;
;__notes					MatrixBright__=___._|_|_|_|_|_|_._|_|_|_|_|_|_._|_|_|_|_|_|_|_|_.__|_.__|_.__|_|_
;						MatrixGreyScale__=___.___|_.___|_.___|_|_|_.___|_.___|_.___|_|_|_.___|_.___|_.___|_|_|_|_|_|_|_|_|_|_|_|_
;						MatrixNegative__=__-_|_|_|_|_|_|-_|_|_|_|_|_|-_|_|_|_|_|_|_|_|_|_|_|_|_

Gdip_DrawImage(pGraphics,__pBitmap,__dx="",__dy="",__dw="",__dh="",__sx="",__sy="",__sw="",__sh="",__Matrix=_)
{
	if__(Matrix&___=__"")
		ImageAttr__:=__Gdip_SetImageAttributesColorMatrix(Matrix)
	else__if__(Matrix__!=___)
		ImageAttr__:=__Gdip_SetImageAttributesColorMatrix("_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|"__Matrix__"|_|_|_|_|_|_")

	if__(sx__=__""__&&__sy__=__""__&&__sw__=__""__&&__sh__=__"")
	{
		if__(dx__=__""__&&__dy__=__""__&&__dw__=__""__&&__dh__=__"")
		{
			sx__:=__dx__:=___,__sy__:=__dy__:=___
			sw__:=__dw__:=__Gdip_GetImageWidth(pBitmap)
			sh__:=__dh__:=__Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx__:=__sy__:=___
			sw__:=__Gdip_GetImageWidth(pBitmap)
			sh__:=__Gdip_GetImageHeight(pBitmap)
		}
	}

	E__:=__DllCall("gdiplus\GdipDrawImageRectRect",__"uint",__pGraphics,__"uint",__pBitmap
	,__"float",__dx,__"float",__dy,__"float",__dw,__"float",__dh
	,__"float",__sx,__"float",__sy,__"float",__sw,__"float",__sh
	,__"int",___,__"uint",__ImageAttr,__"uint",___,__"uint",___)
	if__ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return__E
}

;#####################################################################################

;__Function				Gdip_SetImageAttributesColorMatrix
;__Description			This__function__creates__an__image__matrix__ready__for__drawing
;
;__Matrix				a__matrix__used__to__alter__image__attributes__when__drawing
;						passed__with__any__delimeter
;
;__return				returns__an__image__matrix__on__sucess__or_____if__it__fails
;
;__notes					MatrixBright__=___._|_|_|_|_|_|_._|_|_|_|_|_|_._|_|_|_|_|_|_|_|_.__|_.__|_.__|_|_
;						MatrixGreyScale__=___.___|_.___|_.___|_|_|_.___|_.___|_.___|_|_|_.___|_.___|_.___|_|_|_|_|_|_|_|_|_|_|_|_
;						MatrixNegative__=__-_|_|_|_|_|_|-_|_|_|_|_|_|-_|_|_|_|_|_|_|_|_|_|_|_|_

Gdip_SetImageAttributesColorMatrix(Matrix)
{
	VarSetCapacity(ColourMatrix,_____,___)
	Matrix__:=__RegExReplace(RegExReplace(Matrix,__"^[^\d-\.]+([\d\.])",__"$_",__"",___),__"[^\d-\.]+",__"|")
	StringSplit,__Matrix,__Matrix,__|
	Loop,____
	{
		Matrix__:=__(Matrix%A_Index%__!=__"")__?__Matrix%A_Index%__:__Mod(A_Index-_,___)__?_____:___
		NumPut(Matrix,__ColourMatrix,__(A_Index-_)*_,__"float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes",__"uint*",__ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix",__"uint",__ImageAttr,__"int",___,__"int",___,__"uint",__&ColourMatrix,__"int",___,__"int",___)
	return__ImageAttr
}

;#####################################################################################

;__Function				Gdip_GraphicsFromImage
;__Description			This__function__gets__the__graphics__for__a__bitmap__used__for__drawing__functions
;
;__pBitmap				Pointer__to__a__bitmap__to__get__the__pointer__to__its__graphics
;
;__return				returns__a__pointer__to__the__graphics__of__a__bitmap
;
;__notes					a__bitmap__can__be__drawn__into__the__graphics__of__another__bitmap

Gdip_GraphicsFromImage(pBitmap)
{
____DllCall("gdiplus\GdipGetImageGraphicsContext",__"uint",__pBitmap,__"uint*",__pGraphics)
____return__pGraphics
}

;#####################################################################################

;__Function				Gdip_GraphicsFromHDC
;__Description			This__function__gets__the__graphics__from__the__handle__to__a__device__context
;
;__hdc					This__is__the__handle__to__the__device__context
;
;__return				returns__a__pointer__to__the__graphics__of__a__bitmap
;
;__notes					You__can__draw__a__bitmap__into__the__graphics__of__another__bitmap

Gdip_GraphicsFromHDC(hdc)
{
____DllCall("gdiplus\GdipCreateFromHDC",__"uint",__hdc,__"uint*",__pGraphics)
____return__pGraphics
}

;#####################################################################################

;__Function				Gdip_GetDC
;__Description			This__function__gets__the__device__context__of__the__passed__Graphics
;
;__hdc					This__is__the__handle__to__the__device__context
;
;__return				returns__the__device__context__for__the__graphics__of__a__bitmap

Gdip_GetDC(pGraphics)
{
	DllCall("gdiplus\GdipGetDC",__"uint",__pGraphics,__"uint*",__hdc)
	return__hdc
}

;#####################################################################################

;__Function				Gdip_ReleaseDC
;__Description			This__function__releases__a__device__context__from__use__for__further__use
;
;__pGraphics				Pointer__to__the__graphics__of__a__bitmap
;__hdc					This__is__the__handle__to__the__device__context
;
;__return				status__enumeration._____=__success

Gdip_ReleaseDC(pGraphics,__hdc)
{
	return__DllCall("gdiplus\GdipReleaseDC",__"uint",__pGraphics,__"uint",__hdc)
}

;#####################################################################################

;__Function				Gdip_GraphicsClear
;__Description			Clears__the__graphics__of__a__bitmap__ready__for__further__drawing
;
;__pGraphics				Pointer__to__the__graphics__of__a__bitmap
;__ARGB					The__colour__to__clear__the__graphics__to
;
;__return				status__enumeration._____=__success
;
;__notes					By__default__this__will__make__the__background__invisible
;						Using__clipping__regions__you__can__clear__a__particular__area__on__the__graphics__rather__than__clearing__the__entire__graphics

Gdip_GraphicsClear(pGraphics,__ARGB=_x__ffffff)
{
____return__DllCall("gdiplus\GdipGraphicsClear",__"uint",__pGraphics,__"int",__ARGB)
}

;#####################################################################################

;__Function				Gdip_BlurBitmap
;__Description			Gives__a__pointer__to__a__blurred__bitmap__from__a__pointer__to__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap__to__be__blurred
;__Blur					The__Amount__to__blur__a__bitmap__by__from_____(least__blur)__to_______(most__blur)
;
;__return				If__the__function__succeeds,__the__return__value__is__a__pointer__to__the__new__blurred__bitmap
;						-___=__The__blur__parameter__is__outside__the__range___-___
;
;__notes					This__function__will__not__dispose__of__the__original__bitmap

Gdip_BlurBitmap(pBitmap,__Blur)
{
	if__(Blur__>_____)__||__(Blur__<___)
		return__-_	
	
	sWidth__:=__Gdip_GetImageWidth(pBitmap),__sHeight__:=__Gdip_GetImageHeight(pBitmap)
	dWidth__:=__sWidth//Blur,__dHeight__:=__sHeight//Blur

	pBitmap___:=__Gdip_CreateBitmap(dWidth,__dHeight)
	G___:=__Gdip_GraphicsFromImage(pBitmap_)
	Gdip_SetInterpolationMode(G_,___)
	Gdip_DrawImage(G_,__pBitmap,___,___,__dWidth,__dHeight,___,___,__sWidth,__sHeight)

	Gdip_DeleteGraphics(G_)

	pBitmap___:=__Gdip_CreateBitmap(sWidth,__sHeight)
	G___:=__Gdip_GraphicsFromImage(pBitmap_)
	Gdip_SetInterpolationMode(G_,___)
	Gdip_DrawImage(G_,__pBitmap_,___,___,__sWidth,__sHeight,___,___,__dWidth,__dHeight)

	Gdip_DeleteGraphics(G_)
	Gdip_DisposeImage(pBitmap_)
	return__pBitmap_
}

;#####################################################################################

;__Function:______	Gdip_SaveBitmapToFile
;__Description:__		Saves__a__bitmap__to__a__file__in__any__supported__format__onto__disk
;____
;__pBitmap				Pointer__to__a__bitmap
;__sOutput______			The__name__of__the__file__that__the__bitmap__will__be__saved__to.__Supported__extensions__are:__.BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
;__Quality______			If__saving__as__jpg__(.JPG,.JPEG,.JPE,.JFIF)__then__quality__can__be___-_____with__default__at__maximum__quality
;
;__return______			If__the__function__succeeds,__the__return__value__is__zero,__otherwise:
;						-___=__Extension__supplied__is__not__a__supported__file__format
;						-___=__Could__not__get__a__list__of__encoders__on__system
;						-___=__Could__not__find__matching__encoder__for__specified__file__format
;						-___=__Could__not__get__WideChar__name__of__output__file
;						-___=__Could__not__save__file__to__disk
;
;__notes					This__function__will__use__the__extension__supplied__from__the__sOutput__parameter__to__determine__the__output__format

Gdip_SaveBitmapToFile(pBitmap,__sOutput,__Quality=__)
{
	SplitPath,__sOutput,,,__Extension
	if__Extension__not__in__BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return__-_
	Extension__:=__"."__Extension

	DllCall("gdiplus\GdipGetImageEncodersSize",__"uint*",__nCount,__"uint*",__nSize)
	VarSetCapacity(ci,__nSize)
	DllCall("gdiplus\GdipGetImageEncoders",__"uint",__nCount,__"uint",__nSize,__"uint",__&ci)
	if__!(nCount__&&__nSize)
		return__-_
____
	Loop,__%nCount%
	{
		Location__:=__NumGet(ci,____*(A_Index-_)+__)
		if__!A_IsUnicode
		{
			nSize__:=__DllCall("WideCharToMultiByte",__"uint",___,__"uint",___,__"uint",__Location,__"int",__-_,__"uint",___,__"int",___,__"uint",___,__"uint",___)
			VarSetCapacity(sString,__nSize)
			DllCall("WideCharToMultiByte",__"uint",___,__"uint",___,__"uint",__Location,__"int",__-_,__"str",__sString,__"int",__nSize,__"uint",___,__"uint",___)
			if__!InStr(sString,__"*"__Extension)
				continue
		}
		else
		{
			nSize__:=__DllCall("WideCharToMultiByte",__"uint",___,__"uint",___,__"uint",__Location,__"int",__-_,__"uint",___,__"int",___,__"uint",___,__"uint",___)
			sString__:=__""
			Loop,__%nSize%
				sString__.=__Chr(NumGet(Location+_,___*(A_Index-_),__"char"))
			if__!InStr(sString,__"*"__Extension)
				continue
		}
		pCodec__:=__&ci+__*(A_Index-_)
		break
	}
	if__!pCodec
		return__-_

	if__(Quality__!=____)
	{
		Quality__:=__(Quality__<___)__?_____:__(Quality__>_____)__?_______:__Quality
		if__Extension__in__.JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize",__"uint",__pBitmap,__"uint",__pCodec,__"uint*",__nSize)
			VarSetCapacity(EncoderParameters,__nSize,___)
			DllCall("gdiplus\GdipGetEncoderParameterList",__"uint",__pBitmap,__"uint",__pCodec,__"uint",__nSize,__"uint",__&EncoderParameters)
			Loop,__%__NumGet(EncoderParameters)______;%
			{
				if__(NumGet(EncoderParameters,__(__*(A_Index-_))+__)__=___)__&&__(NumGet(EncoderParameters,__(__*(A_Index-_))+__)__=___)
				{
				____p__:=__(__*(A_Index-_))+&EncoderParameters
				____NumPut(Quality,__NumGet(NumPut(_,__NumPut(_,__p+_)+__)))
				____break
				}
			}______
	__}
	}

	if__!A_IsUnicode
	{
		nSize__:=__DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sOutput,__"int",__-_,__"uint",___,__"int",___)
		VarSetCapacity(wOutput,__nSize*_)
		DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sOutput,__"int",__-_,__"uint",__&wOutput,__"int",__nSize)
		VarSetCapacity(wOutput,__-_)
		if__!VarSetCapacity(wOutput)
			return__-_
		E__:=__DllCall("gdiplus\GdipSaveImageToFile",__"uint",__pBitmap,__"uint",__&wOutput,__"uint",__pCodec,__"uint",__p__?__p__:___)
	}
	else
		E__:=__DllCall("gdiplus\GdipSaveImageToFile",__"uint",__pBitmap,__"uint",__&sOutput,__"uint",__pCodec,__"uint",__p__?__p__:___)
	return__E__?__-___:___
}

;#####################################################################################

;__Function				Gdip_GetPixel
;__Description			Gets__the__ARGB__of__a__pixel__in__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap
;__x						x-coordinate__of__the__pixel
;__y						y-coordinate__of__the__pixel
;
;__return				Returns__the__ARGB__value__of__the__pixel

Gdip_GetPixel(pBitmap,__x,__y)
{
	DllCall("gdiplus\GdipBitmapGetPixel",__"uint",__pBitmap,__"int",__x,__"int",__y,__"uint*",__ARGB)
	return__ARGB
}

;#####################################################################################

;__Function				Gdip_SetPixel
;__Description			Sets__the__ARGB__of__a__pixel__in__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap
;__x						x-coordinate__of__the__pixel
;__y						y-coordinate__of__the__pixel
;
;__return				status__enumeration._____=__success

Gdip_SetPixel(pBitmap,__x,__y,__ARGB)
{
____return__DllCall("gdiplus\GdipBitmapSetPixel",__"uint",__pBitmap,__"int",__x,__"int",__y,__"int",__ARGB)
}

;#####################################################################################

;__Function				Gdip_GetImageWidth
;__Description			Gives__the__width__of__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap
;
;__return				Returns__the__width__in__pixels__of__the__supplied__bitmap

Gdip_GetImageWidth(pBitmap)
{
____DllCall("gdiplus\GdipGetImageWidth",__"uint",__pBitmap,__"uint*",__Width)
____return__Width
}

;#####################################################################################

;__Function				Gdip_GetImageHeight
;__Description			Gives__the__height__of__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap
;
;__return				Returns__the__height__in__pixels__of__the__supplied__bitmap

Gdip_GetImageHeight(pBitmap)
{
____DllCall("gdiplus\GdipGetImageHeight",__"uint",__pBitmap,__"uint*",__Height)
____return__Height
}

;#####################################################################################

;__Function				Gdip_GetDimensions
;__Description			Gives__the__width__and__height__of__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap
;__Width					ByRef__variable.__This__variable__will__be__set__to__the__width__of__the__bitmap
;__Height				ByRef__variable.__This__variable__will__be__set__to__the__height__of__the__bitmap
;
;__return				No__return__value
;						Gdip_GetDimensions(pBitmap,__ThisWidth,__ThisHeight)__will__set__ThisWidth__to__the__width__and__ThisHeight__to__the__height

Gdip_GetImageDimensions(pBitmap,__ByRef__Width,__ByRef__Height)
{
	DllCall("gdiplus\GdipGetImageWidth",__"uint",__pBitmap,__"uint*",__Width)
	DllCall("gdiplus\GdipGetImageHeight",__"uint",__pBitmap,__"uint*",__Height)
}

;#####################################################################################

Gdip_GetDimensions(pBitmap,__ByRef__Width,__ByRef__Height)
{
	Gdip_GetImageDimensions(pBitmap,__Width,__Height)
}

;#####################################################################################

Gdip_GetImagePixelFormat(pBitmap)
{
	DllCall("gdiplus\GdipGetImagePixelFormat",__"uint",__pBitmap,__"uint*",__Format)
	return__Format
}

;#####################################################################################

;__Function				Gdip_GetDpiX
;__Description			Gives__the__horizontal__dots__per__inch__of__the__graphics__of__a__bitmap
;
;__pBitmap				Pointer__to__a__bitmap
;__Width					ByRef__variable.__This__variable__will__be__set__to__the__width__of__the__bitmap
;__Height				ByRef__variable.__This__variable__will__be__set__to__the__height__of__the__bitmap
;
;__return				No__return__value
;						Gdip_GetDimensions(pBitmap,__ThisWidth,__ThisHeight)__will__set__ThisWidth__to__the__width__and__ThisHeight__to__the__height

Gdip_GetDpiX(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiX",__"uint",__pGraphics,__"float*",__dpix)
	return__Round(dpix)
}

;#####################################################################################

Gdip_GetDpiY(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiY",__"uint",__pGraphics,__"float*",__dpiy)
	return__Round(dpiy)
}

;#####################################################################################

Gdip_GetImageHorizontalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHorizontalResolution",__"uint",__pBitmap,__"float*",__dpix)
	return__Round(dpix)
}

;#####################################################################################

Gdip_GetImageVerticalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageVerticalResolution",__"uint",__pBitmap,__"float*",__dpiy)
	return__Round(dpiy)
}

;#####################################################################################

Gdip_BitmapSetResolution(pBitmap,__dpix,__dpiy)
{
	return__DllCall("gdiplus\GdipBitmapSetResolution",__"uint",__pBitmap,__"float",__dpix,__"float",__dpiy)
}

;#####################################################################################

Gdip_CreateBitmapFromFile(sFile,__IconNumber=_,__IconSize="")
{
	SplitPath,__sFile,,,__ext
	if__ext__in__exe,dll
	{
		Sizes__:=__IconSize__?__IconSize__:_______"|"_______"|"______"|"______"|"______"|"____
		VarSetCapacity(buf,____)
		Loop,__Parse,__Sizes,__|
		{
			DllCall("PrivateExtractIcons",__"str",__sFile,__"int",__IconNumber-_,__"int",__A_LoopField,__"int",__A_LoopField,__"uint*",__hIcon,__"uint*",___,__"uint",___,__"uint",___)
			if__!hIcon
				continue

			if__!DllCall("GetIconInfo",__"uint",__hIcon,__"uint",__&buf)
			{
				DestroyIcon(hIcon)
				continue
			}
			hbmColor__:=__NumGet(buf,____)
			hbmMask__:=__NumGet(buf,____)

			if__!(hbmColor__&&__DllCall("GetObject",__"uint",__hbmColor,__"int",____,__"uint",__&buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if__!hIcon
			return__-_

		Width__:=__NumGet(buf,___,__"int"),__Height__:=__NumGet(buf,___,__"int")
		hbm__:=__CreateDIBSection(Width,__-Height),__hdc__:=__CreateCompatibleDC(),__obm__:=__SelectObject(hdc,__hbm)

		if__!DllCall("DrawIconEx",__"uint",__hdc,__"int",___,__"int",___,__"uint",__hIcon,__"uint",__Width,__"uint",__Height,__"uint",___,__"uint",___,__"uint",___)
		{
			DestroyIcon(hIcon)
			return__-_
		}

		VarSetCapacity(dib,____)
		DllCall("GetObject",__"uint",__hbm,__"int",____,__"uint",__&dib)
		Stride__:=__NumGet(dib,____),__Bits__:=__NumGet(dib,____)

		DllCall("gdiplus\GdipCreateBitmapFromScan_",__"int",__Width,__"int",__Height,__"int",__Stride,__"int",___x_____A,__"uint",__Bits,__"uint*",__pBitmapOld)
		pBitmap__:=__Gdip_CreateBitmap(Width,__Height),__G__:=__Gdip_GraphicsFromImage(pBitmap)
		Gdip_DrawImage(G,__pBitmapOld,___,___,__Width,__Height,___,___,__Width,__Height)
		SelectObject(hdc,__obm),__DeleteObject(hbm),__DeleteDC(hdc)
		Gdip_DeleteGraphics(G),__Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if__!A_IsUnicode
		{
			VarSetCapacity(wFile,______)
			DllCall("kernel__\MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sFile,__"int",__-_,__"uint",__&wFile,__"int",_____)
			DllCall("gdiplus\GdipCreateBitmapFromFile",__"uint",__&wFile,__"uint*",__pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile",__"uint",__&sFile,__"uint*",__pBitmap)
	}
	return__pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromHBITMAP(hBitmap,__Palette=_)
{
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP",__"uint",__hBitmap,__"uint",__Palette,__"uint*",__pBitmap)
	return__pBitmap
}

;#####################################################################################

Gdip_CreateHBITMAPFromBitmap(pBitmap,__Background=_xffffffff)
{
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap",__"uint",__pBitmap,__"uint*",__hbm,__"int",__Background)
	return__hbm
}

;#####################################################################################

Gdip_CreateBitmapFromHICON(hIcon)
{
	DllCall("gdiplus\GdipCreateBitmapFromHICON",__"uint",__hIcon,__"uint*",__pBitmap)
	return__pBitmap
}

;#####################################################################################

Gdip_CreateHICONFromBitmap(pBitmap)
{
	DllCall("gdiplus\GdipCreateHICONFromBitmap",__"uint",__pBitmap,__"uint*",__hIcon)
	return__hIcon
}

;#####################################################################################

Gdip_CreateBitmap(Width,__Height,__Format=_x_____A)
{
____DllCall("gdiplus\GdipCreateBitmapFromScan_",__"int",__Width,__"int",__Height,__"int",___,__"int",__Format,__"uint",___,__"uint*",__pBitmap)
____Return__pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromClipboard()
{
	if__!DllCall("OpenClipboard",__"uint",___)
		return__-_
	if__!DllCall("IsClipboardFormatAvailable",__"uint",___)
		return__-_
	if__!hBitmap__:=__DllCall("GetClipboardData",__"uint",___)
		return__-_
	if__!pBitmap__:=__Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return__-_
	if__!DllCall("CloseClipboard")
		return__-_
	DeleteObject(hBitmap)
	return__pBitmap
}

;#####################################################################################

Gdip_SetBitmapToClipboard(pBitmap)
{
	hBitmap__:=__Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject",__"uint",__hBitmap,__"int",__VarSetCapacity(oi,____,___),__"uint",__&oi)
	hdib__:=__DllCall("GlobalAlloc",__"uint",___,__"uint",____+NumGet(oi,____))
	pdib__:=__DllCall("GlobalLock",__"uint",__hdib)
	DllCall("RtlMoveMemory",__"uint",__pdib,__"uint",__&oi+__,__"uint",____)
	DllCall("RtlMoveMemory",__"Uint",__pdib+__,__"Uint",__NumGet(oi,____),__"uint",__NumGet(oi,____))
	DllCall("GlobalUnlock",__"uint",__hdib)
	DllCall("DeleteObject",__"uint",__hBitmap)
	DllCall("OpenClipboard",__"uint",___)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData",__"uint",___,__"uint",__hdib)
	DllCall("CloseClipboard")
}

;#####################################################################################

Gdip_CloneBitmapArea(pBitmap,__x,__y,__w,__h,__Format=_x_____A)
{
	DllCall("gdiplus\GdipCloneBitmapArea",__"float",__x,__"float",__y,__"float",__w,__"float",__h
	,__"int",__Format,__"uint",__pBitmap,__"uint*",__pBitmapDest)
	return__pBitmapDest
}

;#####################################################################################
;__Create__resources
;#####################################################################################

Gdip_CreatePen(ARGB,__w)
{
____DllCall("gdiplus\GdipCreatePen_",__"int",__ARGB,__"float",__w,__"int",___,__"uint*",__pPen)
____return__pPen
}

;#####################################################################################

Gdip_CreatePenFromBrush(pBrush,__w)
{
	DllCall("gdiplus\GdipCreatePen_",__"uint",__pBrush,__"float",__w,__"int",___,__"uint*",__pPen)
	return__pPen
}

;#####################################################################################

Gdip_BrushCreateSolid(ARGB=_xff______)
{
	DllCall("gdiplus\GdipCreateSolidFill",__"int",__ARGB,__"uint*",__pBrush)
	return__pBrush
}

;#####################################################################################

;__HatchStyleHorizontal__=___
;__HatchStyleVertical__=___
;__HatchStyleForwardDiagonal__=___
;__HatchStyleBackwardDiagonal__=___
;__HatchStyleCross__=___
;__HatchStyleDiagonalCross__=___
;__HatchStyle__Percent__=___
;__HatchStyle__Percent__=___
;__HatchStyle__Percent__=___
;__HatchStyle__Percent__=___
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyle__Percent__=____
;__HatchStyleLightDownwardDiagonal__=____
;__HatchStyleLightUpwardDiagonal__=____
;__HatchStyleDarkDownwardDiagonal__=____
;__HatchStyleDarkUpwardDiagonal__=____
;__HatchStyleWideDownwardDiagonal__=____
;__HatchStyleWideUpwardDiagonal__=____
;__HatchStyleLightVertical__=____
;__HatchStyleLightHorizontal__=____
;__HatchStyleNarrowVertical__=____
;__HatchStyleNarrowHorizontal__=____
;__HatchStyleDarkVertical__=____
;__HatchStyleDarkHorizontal__=____
;__HatchStyleDashedDownwardDiagonal__=____
;__HatchStyleDashedUpwardDiagonal__=____
;__HatchStyleDashedHorizontal__=____
;__HatchStyleDashedVertical__=____
;__HatchStyleSmallConfetti__=____
;__HatchStyleLargeConfetti__=____
;__HatchStyleZigZag__=____
;__HatchStyleWave__=____
;__HatchStyleDiagonalBrick__=____
;__HatchStyleHorizontalBrick__=____
;__HatchStyleWeave__=____
;__HatchStylePlaid__=____
;__HatchStyleDivot__=____
;__HatchStyleDottedGrid__=____
;__HatchStyleDottedDiamond__=____
;__HatchStyleShingle__=____
;__HatchStyleTrellis__=____
;__HatchStyleSphere__=____
;__HatchStyleSmallGrid__=____
;__HatchStyleSmallCheckerBoard__=____
;__HatchStyleLargeCheckerBoard__=____
;__HatchStyleOutlinedDiamond__=____
;__HatchStyleSolidDiamond__=____
;__HatchStyleTotal__=____
Gdip_BrushCreateHatch(ARGBfront,__ARGBback,__HatchStyle=_)
{
	DllCall("gdiplus\GdipCreateHatchBrush",__"int",__HatchStyle,__"int",__ARGBfront,__"int",__ARGBback,__"uint*",__pBrush)
	return__pBrush
}

;#####################################################################################

Gdip_CreateTextureBrush(pBitmap,__WrapMode=_,__x=_,__y=_,__w="",__h="")
{
	if__!(w__&&__h)
		DllCall("gdiplus\GdipCreateTexture",__"uint",__pBitmap,__"int",__WrapMode,__"uint*",__pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture_",__"uint",__pBitmap,__"int",__WrapMode,__"float",__x,__"float",__y,__"float",__w,__"float",__h,__"uint*",__pBrush)
	return__pBrush
}

;#####################################################################################

;__WrapModeTile__=___
;__WrapModeTileFlipX__=___
;__WrapModeTileFlipY__=___
;__WrapModeTileFlipXY__=___
;__WrapModeClamp__=___
Gdip_CreateLineBrush(x_,__y_,__x_,__y_,__ARGB_,__ARGB_,__WrapMode=_)
{
	CreatePointF(PointF_,__x_,__y_),__CreatePointF(PointF_,__x_,__y_)
	DllCall("gdiplus\GdipCreateLineBrush",__"uint",__&PointF_,__"uint",__&PointF_,__"int",__ARGB_,__"int",__ARGB_,__"int",__WrapMode,__"uint*",__LGpBrush)
	return__LGpBrush
}

;#####################################################################################

;__LinearGradientModeHorizontal__=___
;__LinearGradientModeVertical__=___
;__LinearGradientModeForwardDiagonal__=___
;__LinearGradientModeBackwardDiagonal__=___
Gdip_CreateLineBrushFromRect(x,__y,__w,__h,__ARGB_,__ARGB_,__LinearGradientMode=_,__WrapMode=_)
{
	CreateRectF(RectF,__x,__y,__w,__h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect",__"uint",__&RectF,__"int",__ARGB_,__"int",__ARGB_,__"int",__LinearGradientMode,__"int",__WrapMode,__"uint*",__LGpBrush)
	return__LGpBrush
}

;#####################################################################################

Gdip_CloneBrush(pBrush)
{
	DllCall("gdiplus\GdipCloneBrush",__"uint",__pBrush,__"uint*",__pBrushClone)
	return__pBrushClone
}

;#####################################################################################
;__Delete__resources
;#####################################################################################

Gdip_DeletePen(pPen)
{
____return__DllCall("gdiplus\GdipDeletePen",__"uint",__pPen)
}

;#####################################################################################

Gdip_DeleteBrush(pBrush)
{
____return__DllCall("gdiplus\GdipDeleteBrush",__"uint",__pBrush)
}

;#####################################################################################

Gdip_DisposeImage(pBitmap)
{
____return__DllCall("gdiplus\GdipDisposeImage",__"uint",__pBitmap)
}

;#####################################################################################

Gdip_DeleteGraphics(pGraphics)
{
____return__DllCall("gdiplus\GdipDeleteGraphics",__"uint",__pGraphics)
}

;#####################################################################################

Gdip_DisposeImageAttributes(ImageAttr)
{
	return__DllCall("gdiplus\GdipDisposeImageAttributes",__"uint",__ImageAttr)
}

;#####################################################################################

Gdip_DeleteFont(hFont)
{
____return__DllCall("gdiplus\GdipDeleteFont",__"uint",__hFont)
}

;#####################################################################################

Gdip_DeleteStringFormat(hFormat)
{
____return__DllCall("gdiplus\GdipDeleteStringFormat",__"uint",__hFormat)
}

;#####################################################################################

Gdip_DeleteFontFamily(hFamily)
{
____return__DllCall("gdiplus\GdipDeleteFontFamily",__"uint",__hFamily)
}

;#####################################################################################

Gdip_DeleteMatrix(Matrix)
{
____return__DllCall("gdiplus\GdipDeleteMatrix",__"uint",__Matrix)
}

;#####################################################################################
;__Text__functions
;#####################################################################################

Gdip_TextToGraphics(pGraphics,__Text,__Options,__Font="Arial",__Width="",__Height="",__Measure=_)
{
	IWidth__:=__Width,__IHeight:=__Height
	
	RegExMatch(Options,__"i)X([\-\d\.]+)(p*)",__xpos)
	RegExMatch(Options,__"i)Y([\-\d\.]+)(p*)",__ypos)
	RegExMatch(Options,__"i)W([\-\d\.]+)(p*)",__Width)
	RegExMatch(Options,__"i)H([\-\d\.]+)(p*)",__Height)
	RegExMatch(Options,__"i)C(?!(entre|enter))([a-f\d]+)",__Colour)
	RegExMatch(Options,__"i)Top|Up|Bottom|Down|vCentre|vCenter",__vPos)
	RegExMatch(Options,__"i)NoWrap",__NoWrap)
	RegExMatch(Options,__"i)R(\d)",__Rendering)
	RegExMatch(Options,__"i)S(\d+)(p*)",__Size)

	if__!Gdip_DeleteBrush(Gdip_CloneBrush(Colour_))
		PassBrush__:=___,__pBrush__:=__Colour_
	
	if__!(IWidth__&&__IHeight)__&&__(xpos___||__ypos___||__Width___||__Height___||__Size_)
		return__-_

	Style__:=___,__Styles__:=__"Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	Loop,__Parse,__Styles,__|
	{
		if__RegExMatch(Options,__"\b"__A_loopField)
		Style__|=__(A_LoopField__!=__"StrikeOut")__?__(A_Index-_)__:___
	}
__
	Align__:=___,__Alignments__:=__"Near|Left|Centre|Center|Far|Right"
	Loop,__Parse,__Alignments,__|
	{
		if__RegExMatch(Options,__"\b"__A_loopField)
			Align__|=__A_Index//_._______;___|_|_|_|_|_
	}

	xpos__:=__(xpos___!=__"")__?__xpos___?__IWidth*(xpos_/___)__:__xpos___:___
	ypos__:=__(ypos___!=__"")__?__ypos___?__IHeight*(ypos_/___)__:__ypos___:___
	Width__:=__Width___?__Width___?__IWidth*(Width_/___)__:__Width___:__IWidth
	Height__:=__Height___?__Height___?__IHeight*(Height_/___)__:__Height___:__IHeight
	if__!PassBrush
		Colour__:=__"_x"__(Colour___?__Colour___:__"ff______")
	Rendering__:=__((Rendering___>=___)__&&__(Rendering___<=___))__?__Rendering___:___
	Size__:=__(Size___>___)__?__Size___?__IHeight*(Size_/___)__:__Size___:____

	hFamily__:=__Gdip_FontFamilyCreate(Font)
	hFont__:=__Gdip_FontCreate(hFamily,__Size,__Style)
	FormatStyle__:=__NoWrap__?___x______|___x______:___x____
	hFormat__:=__Gdip_StringFormatCreate(FormatStyle)
	pBrush__:=__PassBrush__?__pBrush__:__Gdip_BrushCreateSolid(Colour)
	if__!(hFamily__&&__hFont__&&__hFormat__&&__pBrush__&&__pGraphics)
		return__!pGraphics__?__-___:__!hFamily__?__-___:__!hFont__?__-___:__!hFormat__?__-___:__!pBrush__?__-___:___
____
	CreateRectF(RC,__xpos,__ypos,__Width,__Height)
	Gdip_SetStringFormatAlign(hFormat,__Align)
	Gdip_SetTextRenderingHint(pGraphics,__Rendering)
	ReturnRC__:=__Gdip_MeasureString(pGraphics,__Text,__hFont,__hFormat,__RC)

	if__vPos
	{
		StringSplit,__ReturnRC,__ReturnRC,__|
		
		if__(vPos__=__"vCentre")__||__(vPos__=__"vCenter")
			ypos__+=__(Height-ReturnRC_)//_
		else__if__(vPos__=__"Top")__||__(vPos__=__"Up")
			ypos__:=___
		else__if__(vPos__=__"Bottom")__||__(vPos__=__"Down")
			ypos__:=__Height-ReturnRC_
		
		CreateRectF(RC,__xpos,__ypos,__Width,__ReturnRC_)
		ReturnRC__:=__Gdip_MeasureString(pGraphics,__Text,__hFont,__hFormat,__RC)
	}

	if__!Measure
		E__:=__Gdip_DrawString(pGraphics,__Text,__hFont,__hFormat,__pBrush,__RC)

	if__!PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)____
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return__E__?__E__:__ReturnRC
}

;#####################################################################################

Gdip_DrawString(pGraphics,__sString,__hFont,__hFormat,__pBrush,__ByRef__RectF)
{
	if__!A_IsUnicode
	{
		nSize__:=__DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sString,__"int",__-_,__"uint",___,__"int",___)
		VarSetCapacity(wString,__nSize*_)
		DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sString,__"int",__-_,__"uint",__&wString,__"int",__nSize)
		return__DllCall("gdiplus\GdipDrawString",__"uint",__pGraphics
		,__"uint",__&wString,__"int",__-_,__"uint",__hFont,__"uint",__&RectF,__"uint",__hFormat,__"uint",__pBrush)
	}
	else
	{
		return__DllCall("gdiplus\GdipDrawString",__"uint",__pGraphics
		,__"uint",__&sString,__"int",__-_,__"uint",__hFont,__"uint",__&RectF,__"uint",__hFormat,__"uint",__pBrush)
	}	
}

;#####################################################################################

Gdip_MeasureString(pGraphics,__sString,__hFont,__hFormat,__ByRef__RectF)
{
	VarSetCapacity(RC,____)
	if__!A_IsUnicode
	{
		nSize__:=__DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sString,__"int",__-_,__"uint",___,__"int",___)
		VarSetCapacity(wString,__nSize*_)____
		DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&sString,__"int",__-_,__"uint",__&wString,__"int",__nSize)
		DllCall("gdiplus\GdipMeasureString",__"uint",__pGraphics
		,__"uint",__&wString,__"int",__-_,__"uint",__hFont,__"uint",__&RectF,__"uint",__hFormat,__"uint",__&RC,__"uint*",__Chars,__"uint*",__Lines)
	}
	else
	{
		DllCall("gdiplus\GdipMeasureString",__"uint",__pGraphics
		,__"uint",__&sString,__"int",__-_,__"uint",__hFont,__"uint",__&RectF,__"uint",__hFormat,__"uint",__&RC,__"uint*",__Chars,__"uint*",__Lines)
	}
	return__&RC__?__NumGet(RC,___,__"float")__"|"__NumGet(RC,___,__"float")__"|"__NumGet(RC,___,__"float")__"|"__NumGet(RC,____,__"float")__"|"__Chars__"|"__Lines__:___
}

;__Near__=___
;__Center__=___
;__Far__=___
Gdip_SetStringFormatAlign(hFormat,__Align)
{
____return__DllCall("gdiplus\GdipSetStringFormatAlign",__"uint",__hFormat,__"int",__Align)
}

;__StringFormatFlagsDirectionRightToLeft____=___x________
;__StringFormatFlagsDirectionVertical________=___x________
;__StringFormatFlagsNoFitBlackBox____________=___x________
;__StringFormatFlagsDisplayFormatControl____=___x________
;__StringFormatFlagsNoFontFallback__________=___x________
;__StringFormatFlagsMeasureTrailingSpaces____=___x________
;__StringFormatFlagsNoWrap__________________=___x________
;__StringFormatFlagsLineLimit________________=___x________
;__StringFormatFlagsNoClip__________________=___x__________
Gdip_StringFormatCreate(Format=_,__Lang=_)
{
____DllCall("gdiplus\GdipCreateStringFormat",__"int",__Format,__"int",__Lang,__"uint*",__hFormat)
____return__hFormat
}

;__Regular__=___
;__Bold__=___
;__Italic__=___
;__BoldItalic__=___
;__Underline__=___
;__Strikeout__=___
Gdip_FontCreate(hFamily,__Size,__Style=_)
{
____DllCall("gdiplus\GdipCreateFont",__"uint",__hFamily,__"float",__Size,__"int",__Style,__"int",___,__"uint*",__hFont)
____return__hFont
}

Gdip_FontFamilyCreate(Font)
{
	if__!A_IsUnicode
	{
		nSize__:=__DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&Font,__"int",__-_,__"uint",___,__"int",___)
		VarSetCapacity(wFont,__nSize*_)
		DllCall("MultiByteToWideChar",__"uint",___,__"uint",___,__"uint",__&Font,__"int",__-_,__"uint",__&wFont,__"int",__nSize)
		DllCall("gdiplus\GdipCreateFontFamilyFromName",__"uint",__&wFont,__"uint",___,__"uint*",__hFamily)
	}
	else
		DllCall("gdiplus\GdipCreateFontFamilyFromName",__"uint",__&Font,__"uint",___,__"uint*",__hFamily)
	return__hFamily
}

;#####################################################################################
;__Matrix__functions
;#####################################################################################

Gdip_CreateAffineMatrix(m__,__m__,__m__,__m__,__x,__y)
{
____DllCall("gdiplus\GdipCreateMatrix_",__"float",__m__,__"float",__m__,__"float",__m__,__"float",__m__,__"float",__x,__"float",__y,__"uint*",__Matrix)
____return__Matrix
}

Gdip_CreateMatrix()
{
____DllCall("gdiplus\GdipCreateMatrix",__"uint*",__Matrix)
____return__Matrix
}

;#####################################################################################
;__GraphicsPath__functions
;#####################################################################################

;__Alternate__=___
;__Winding__=___
Gdip_CreatePath(BrushMode=_)
{
	DllCall("gdiplus\GdipCreatePath",__"int",__BrushMode,__"uint*",__Path)
	return__Path
}

Gdip_AddPathEllipse(Path,__x,__y,__w,__h)
{
	return__DllCall("gdiplus\GdipAddPathEllipse",__"uint",__Path,__"float",__x,__"float",__y,__"float",__w,__"float",__h)
}

Gdip_AddPathPolygon(Path,__Points)
{
	StringSplit,__Points,__Points,__|
	VarSetCapacity(PointF,___*Points_)____
	Loop,__%Points_%
	{
		StringSplit,__Coord,__Points%A_Index%,__`,
		NumPut(Coord_,__PointF,___*(A_Index-_),__"float"),__NumPut(Coord_,__PointF,__(_*(A_Index-_))+_,__"float")
	}____

	return__DllCall("gdiplus\GdipAddPathPolygon",__"uint",__Path,__"uint",__&PointF,__"int",__Points_)
}

Gdip_DeletePath(Path)
{
	return__DllCall("gdiplus\GdipDeletePath",__"uint",__Path)
}

;#####################################################################################
;__Quality__functions
;#####################################################################################

;__SystemDefault__=___
;__SingleBitPerPixelGridFit__=___
;__SingleBitPerPixel__=___
;__AntiAliasGridFit__=___
;__AntiAlias__=___
Gdip_SetTextRenderingHint(pGraphics,__RenderingHint)
{
	return__DllCall("gdiplus\GdipSetTextRenderingHint",__"uint",__pGraphics,__"int",__RenderingHint)
}

;__Default__=___
;__LowQuality__=___
;__HighQuality__=___
;__Bilinear__=___
;__Bicubic__=___
;__NearestNeighbor__=___
;__HighQualityBilinear__=___
;__HighQualityBicubic__=___
Gdip_SetInterpolationMode(pGraphics,__InterpolationMode)
{
____return__DllCall("gdiplus\GdipSetInterpolationMode",__"uint",__pGraphics,__"int",__InterpolationMode)
}

;__Default__=___
;__HighSpeed__=___
;__HighQuality__=___
;__None__=___
;__AntiAlias__=___
Gdip_SetSmoothingMode(pGraphics,__SmoothingMode)
{
____return__DllCall("gdiplus\GdipSetSmoothingMode",__"uint",__pGraphics,__"int",__SmoothingMode)
}

;__CompositingModeSourceOver__=_____(blended)
;__CompositingModeSourceCopy__=_____(overwrite)
Gdip_SetCompositingMode(pGraphics,__CompositingMode=_)
{
____return__DllCall("gdiplus\GdipSetCompositingMode",__"uint",__pGraphics,__"int",__CompositingMode)
}

;#####################################################################################
;__Extra__functions
;#####################################################################################

Gdip_Startup()
{
	if__!DllCall("GetModuleHandle",__"str",__"gdiplus")
		DllCall("LoadLibrary",__"str",__"gdiplus")
	VarSetCapacity(si,____,___),__si__:=__Chr(_)
	DllCall("gdiplus\GdiplusStartup",__"uint*",__pToken,__"uint",__&si,__"uint",___)
	return__pToken
}

Gdip_Shutdown(pToken)
{
	DllCall("gdiplus\GdiplusShutdown",__"uint",__pToken)
	if__hModule__:=__DllCall("GetModuleHandle",__"str",__"gdiplus")
		DllCall("FreeLibrary",__"uint",__hModule)
	return___
}

;__Prepend__=___;__The__new__operation__is__applied__before__the__old__operation.
;__Append__=___;__The__new__operation__is__applied__after__the__old__operation.
Gdip_RotateWorldTransform(pGraphics,__Angle,__MatrixOrder=_)
{
	return__DllCall("gdiplus\GdipRotateWorldTransform",__"uint",__pGraphics,__"float",__Angle,__"int",__MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics,__x,__y,__MatrixOrder=_)
{
	return__DllCall("gdiplus\GdipScaleWorldTransform",__"uint",__pGraphics,__"float",__x,__"float",__y,__"int",__MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics,__x,__y,__MatrixOrder=_)
{
	return__DllCall("gdiplus\GdipTranslateWorldTransform",__"uint",__pGraphics,__"float",__x,__"float",__y,__"int",__MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return__DllCall("gdiplus\GdipResetWorldTransform",__"uint",__pGraphics)
}

Gdip_GetRotatedTranslation(Width,__Height,__Angle,__ByRef__xTranslation,__ByRef__yTranslation)
{
	pi__:=___._____,__TAngle__:=__Angle*(pi/___)	

	Bound__:=__(Angle__>=___)__?__Mod(Angle,_____)__:_____-Mod(-Angle,__-___)
	if__((Bound__>=___)__&&__(Bound__<=____))
		xTranslation__:=__Height*Sin(TAngle),__yTranslation__:=___
	else__if__((Bound__>____)__&&__(Bound__<=_____))
		xTranslation__:=__(Height*Sin(TAngle))-(Width*Cos(TAngle)),__yTranslation__:=__-Height*Cos(TAngle)
	else__if__((Bound__>_____)__&&__(Bound__<=_____))
		xTranslation__:=__-(Width*Cos(TAngle)),__yTranslation__:=__-(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else__if__((Bound__>_____)__&&__(Bound__<=_____))
		xTranslation__:=___,__yTranslation__:=__-Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width,__Height,__Angle,__ByRef__RWidth,__ByRef__RHeight)
{
	pi__:=___._____,__TAngle__:=__Angle*(pi/___)
	if__!(Width__&&__Height)
		return__-_
	RWidth__:=__Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight__:=__Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}

;__RotateNoneFlipNone____=___
;__Rotate__FlipNone______=___
;__Rotate___FlipNone____=___
;__Rotate___FlipNone____=___
;__RotateNoneFlipX______=___
;__Rotate__FlipX________=___
;__Rotate___FlipX________=___
;__Rotate___FlipX________=___
;__RotateNoneFlipY______=__Rotate___FlipX
;__Rotate__FlipY________=__Rotate___FlipX
;__Rotate___FlipY________=__RotateNoneFlipX
;__Rotate___FlipY________=__Rotate__FlipX
;__RotateNoneFlipXY______=__Rotate___FlipNone
;__Rotate__FlipXY________=__Rotate___FlipNone
;__Rotate___FlipXY______=__RotateNoneFlipNone
;__Rotate___FlipXY______=__Rotate__FlipNone__

Gdip_ImageRotateFlip(pBitmap,__RotateFlipType=_)
{
	return__DllCall("gdiplus\GdipImageRotateFlip",__"uint",__pBitmap,__"int",__RotateFlipType)
}

;__Replace__=___
;__Intersect__=___
;__Union__=___
;__Xor__=___
;__Exclude__=___
;__Complement__=___
Gdip_SetClipRect(pGraphics,__x,__y,__w,__h,__CombineMode=_)
{
____return__DllCall("gdiplus\GdipSetClipRect",__"uint",__pGraphics,__"float",__x,__"float",__y,__"float",__w,__"float",__h,__"int",__CombineMode)
}

Gdip_SetClipPath(pGraphics,__Path,__CombineMode=_)
{
____return__DllCall("gdiplus\GdipSetClipPath",__"uint",__pGraphics,__"uint",__Path,__"int",__CombineMode)
}

Gdip_ResetClip(pGraphics)
{
____return__DllCall("gdiplus\GdipResetClip",__"uint",__pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region__:=__Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip",__"uint"__pGraphics,__"uint*",__Region)
	return__Region
}

Gdip_SetClipRegion(pGraphics,__Region,__CombineMode=_)
{
	return__DllCall("gdiplus\GdipSetClipRegion",__"uint",__pGraphics,__"uint",__Region,__"int",__CombineMode)
}

Gdip_CreateRegion()
{
	DllCall("gdiplus\GdipCreateRegion",__"uint*",__Region)
	return__Region
}

Gdip_DeleteRegion(Region)
{
	return__DllCall("gdiplus\GdipDeleteRegion",__"uint",__Region)
}

;#####################################################################################
;__BitmapLockBits
;#####################################################################################

Gdip_LockBits(pBitmap,__x,__y,__w,__h,__ByRef__Stride,__ByRef__Scan_,__ByRef__BitmapData,__LockMode__=___,__PixelFormat__=___x_____a)
{____
	CreateRect(Rect,__x,__y,__w,__h)
	VarSetCapacity(BitmapData,____,___)
	E__:=__DllCall("Gdiplus\GdipBitmapLockBits",__"uint",__pBitmap,__"uint",__&Rect,__"uint",__LockMode,__"int",__PixelFormat,__"uint",__&BitmapData)
	Stride__:=__NumGet(BitmapData,___)
	Scan___:=__NumGet(BitmapData,____)
	return__E
}

;#####################################################################################

Gdip_UnlockBits(pBitmap,__ByRef__BitmapData)
{
	return__DllCall("Gdiplus\GdipBitmapUnlockBits",__"uint",__pBitmap,__"uint",__&BitmapData)
}

;#####################################################################################

Gdip_SetLockBitPixel(ARGB,__Scan_,__x,__y,__Stride)
{
	Numput(ARGB,__Scan_+_,__(x*_)+(y*Stride))
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan_,__x,__y,__Stride)
{
	return__NumGet(Scan_+_,__(x*_)+(y*Stride))
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap,__ByRef__pBitmapOut,__BlockSize)
{
	static__PixelateBitmap
	if__!PixelateBitmap
	{
		MCode_PixelateBitmap__:=__"__EC___B_____________B_____C__F_FE_B_C___C_B_C_______BF__BCA___C___C___C______FF_F_E_E_______B_____"
		.__"___F_FE___C______________C________________________CEB___D______FF___C_______C_____F_E_________BCE_FAFCE___C_____DA_______"
		.__"______C__BF__________________________F_E_A_______B_C___C_D_D___BD__BD___C____________D_CBB_FAFFE_BD__BD____________BD__BD"
		.__"___F____C___________C_BCF_BFE_DA____________B_C_____FB__C_B__C__FB______C_____B_C_____FB__C_B___C_____FB__C_____C______C_"
		.__"____EF____D__B_C_______C___C___C___C_____C______B__B_C_____B_C___C_B_C_____B_C______F_F__________B________F_F__________B_"
		.__"_______F_F__________B________F_F___________F__F_E_________D_B___BC__BC__D_____B_____C_D__B__FAFC__BD__BD____________BD__B"
		.__"D___C________C________EB___D_____BC__BFE_FB________B_C___________FB____________FB____________B_FB____________A__C_____EF_"
		.__"___D__B_____C_______C___C_____________C__BE_B_C_____B_C_____B_C___C_B_C_______B_C_______C_____F_C_FFEFFFF_B_C___C__D_____"
		.__"_____F____________C__BF________________________________________C_F_E________EB____D__________E_F_B_C______C__FAF_C___C_B_"
		.__"______FAFC__D______CA_D_C___BC__BC___C____________BC__BC____BFD_BFA_B_______________________B_______FB______FB___________"
		.__"_B_______________FB____A_FB_______________________C______C________CF_B_____C___BC________C_C___B_C_____B_______FAFCE__F_F"
		.__"__________B________F_F__________B________F_F__________B________F_F___________C________C__F__F_E_F_________C_______E_F_B_C"
		.__"______C__FAF_C___C_B_______FAFC__D______CA_D_C___BC__BC___C____________BC__BC____BFB_BFA_B_______________________FB______"
		.__"__B_____________FB________FB____________B_____________FB_______________C______C________CF_B_____C___BC________C_C___B_C__"
		.__"_C_B_____C_______C___________C_______F__F_FCFFFF_B________F_FE__________________C__F_E_________BF__FAFFE__D____C___C_____"
		.__"___________EB____D___C__BCA_________________________________________F_E_________BF__E___B_C_____FAFCE__C__FAF_C___C___C__"
		.__"___D_____BC__BC___C____________BC__BC____BFD__CA_________BFA___________B_______FB____A_FB____________B_______________FB__"
		.__"____FB____F__________________C______C________CF_B_______B_C___C_B_C___C__D____BC__________F_C_CFFFFFF_B________F_FF______"
		.__"___B________F_FF_________B________F_FF_________B________F_FF__________C___________C__F_E__________F__E___B_C_____FAFCE__C"
		.__"__FAF_C___C___C_____D_____BC__BC___C____________BC__BC____BFB__CA_________BFA_________D_____FB________B_____________FB___"
		.__"_____FB____________B_____________FB_______________C______C________CF_B_______B_C___C_B_C___C___BC__________C___D__B______"
		.__"______________C_______F___CFEFFFF__D___C__BCA_________________________________________F_E_A______EB___BFF__D__________F_E"
		.__"_D_______B_C_____FAFCE__C__FAF_C___C_B_______FAFC__D______CA_D_C___BC__BC___C____________BC__BC____________BC__BC__B_____"
		.__"__________DA____________B_______FB____A_________FB____________B_______FB____A_________FB_______________C______C________CF"
		.__"_B_______B_C___C___BC__________F_C_AFFFFFF_FAF_C_____B________F_F__________B________F_F__________B________F_F__________B_"
		.__"_______F_F___________C________C_________F_E_B_______B_C______FF_E___B_C_____FAFCE__C__FAF_C___C_B_______FAFC__D______CA_D"
		.__"_C___BC__BC___C____________BC__BC____BEB_________BEA_FB________B_____________FB________FB____________B_____________FB____"
		.__"___________C_____EF____D__B_________B_____C_________C___F_E_D__C__B__C___C_"
		VarSetCapacity(PixelateBitmap,__StrLen(MCode_PixelateBitmap)//_)
		Loop__%__StrLen(MCode_PixelateBitmap)//_		;%
			NumPut("_x"__SubStr(MCode_PixelateBitmap,__(_*A_Index)-_,___),__PixelateBitmap,__A_Index-_,__"char")
	}

	Gdip_GetImageDimensions(pBitmap,__Width,__Height)
	if__(Width__!=__Gdip_GetImageWidth(pBitmapOut)__||__Height__!=__Gdip_GetImageHeight(pBitmapOut))
		return__-_
	if__(BlockSize__>__Width__||__BlockSize__>__Height)
		return__-_

	E___:=__Gdip_LockBits(pBitmap,___,___,__Width,__Height,__Stride_,__Scan__,__BitmapData_)
	E___:=__Gdip_LockBits(pBitmapOut,___,___,__Width,__Height,__Stride_,__Scan__,__BitmapData_)
	if__(E___||__E_)
		return__-_

	E__:=__DllCall(&PixelateBitmap,__"uint",__Scan__,__"uint",__Scan__,__"int",__Width,__"int",__Height,__"int",__Stride_,__"int",__BlockSize)
	Gdip_UnlockBits(pBitmap,__BitmapData_),__Gdip_UnlockBits(pBitmapOut,__BitmapData_)
	return___
}

;#####################################################################################

Gdip_ToARGB(A,__R,__G,__B)
{
	return__(A__<<____)__|__(R__<<____)__|__(G__<<___)__|__B
}

;#####################################################################################

Gdip_FromARGB(ARGB,__ByRef__A,__ByRef__R,__ByRef__G,__ByRef__B)
{
	A__:=__(_xff________&__ARGB)__>>____
	R__:=__(_x__ff______&__ARGB)__>>____
	G__:=__(_x____ff____&__ARGB)__>>___
	B__:=___x______ff__&__ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return__(_xff________&__ARGB)__>>____
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return__(_x__ff______&__ARGB)__>>____
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return__(_x____ff____&__ARGB)__>>___
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return___x______ff__&__ARGB
}