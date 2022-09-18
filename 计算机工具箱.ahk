#SingleInstance Force
#NoEnv
SetRegView 64
SetBatchLines -1
SendMode Input
#Persistent
;------------------------------------------------------------------------
;强制以ANSI版本管理员权限运行
runwith("admin","A")
if (A_IsUnicode=1 and A_PtrSize=8) ; 用于修正32位AHK读取不到"C:\Windows\System32"的问题
    DllCall("Wow64DisableWow64FsRedirection")
;------------------------------------------------------------------------
;读取软件版本
RegRead, dd_version, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\钉钉, DisplayVersion
RegRead, QQ_version, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{052CFB79-9D62-42E3-8A15-DE66C2C97C3E},DisplayVersion
;------------------------------------------------------------------------
Gui Font, s10
Gui, Add, GroupBox, x3 y2 w310 h100, 计算机信息
Gui Font, s9
;读取主板型号
command = wmic baseboard get product
board_product := cmdSilenceReturn(command)
pbArray := StrSplit(board_product,"`n")
varp := pbArray[2]
;读取cpu型号
command = wmic cpu get name
board_cpu := cmdSilenceReturn(command)
cpuArray := StrSplit(board_cpu,"`n")
varcpu := cpuarray[2]
;读取内存
command = wmic path Win32_ComputerSystem get TotalPhysicalMemory
board_mm := cmdSilenceReturn(command)
mmArray := StrSplit(board_mm,"`n")
varmm := mmarray[2] 
varmm := Round(Trim(varmm, "`t`r`n")/1024/1024/1024)
;读取内存品牌
command = wmic memorychip get manufacturer
board_mmb := cmdSilenceReturn(command)
board_mmb := StrReplace(board_mmb, A_Space, "")
board_mmb := StrReplace(board_mmb, "`r`n",",")
board_mmb := SubStr(board_mmb, 13, StrLen(board_mmb))
;读取显卡型号
vd_Count := 0
command = wmic path win32_VideoController get name
board_vd := cmdSilenceReturn(command)
vdArray := StrSplit(board_vd,"`n")
for i in vdArray
    vd_Count++
varvd1 := vdarray[2]
varvd1 := Trim(varvd1, "`t`r`n")
varvd2 := vdarray[3]
varvd2 := Trim(varvd2, "`t`r`n")
;读取显存大小
command = wmic path win32_VideoController get AdapterRAM
board_vdm := cmdSilenceReturn(command)
vdmArray := StrSplit(board_vdm,"`n")
varvdm1 := vdmarray[2]
varvdm1 := Round(Trim(varvdm1, "`t`r`n")/1024/1024/1024)
varvdm2 := vdmarray[3]
varvdm2 := Round(Trim(varvdm2, "`t`r`n")/1024/1024/1024)
;----------------------------------------------------
;读取IP
;command = ipconfig | findstr /i "ipv4"
;board_IP := cmdSilenceReturn(command)
;IPArray := StrSplit(board_IP,":")
;varIP := IParray[2]
;varIP := StrReplace(varIP, A_Space, "")
;---------------------------------------------------
;显示计算机信息
if (vd_Count <4)
{
    Gui Add, Text, x5 y22, 主板  ：%varp%`ncpu   ：%varcpu%`n内存  ：%varmm%G%board_mmb%`n显卡1 ：%varvd1% %varvdm1%G `n显卡2 ：无`n
}
else
{
    Gui Add, Text, x5 y22, 主板  ：%varp%`ncpu   ：%varcpu%`n内存  ：%varmm%G%board_mmb%`n显卡1 ：%varvd1% %varvdm1%G `n显卡2 ：%varvd2% %varvdm2%G`n
}
   


;------------------------------------------------------------------------
Gui Font, s8
Gui Add, Button, x10 y132 w65 h20, 钉钉
Gui Add, Button, x87 y132 w65 h20, PhotoShop
Gui Add, Button, x163 y132 w65 h20, 安装钉钉
Gui Add, Button, x240 y132 w65 h20, 安装钉钉
Gui Font, s10
Gui, Add, GroupBox, x3 y112 w310 h260 +Center, % " 安装软件 "
Gui Font, s9
Gui, Add, ListView, r20 w310 h150 gMyListView Grid NoSortHdr -Hdr NoSort -Multi, 项目|详细信息|最新版本
LV_ModifyCol(1, 62)
LV_ModifyCol(2, 164)
LV_ModifyCol(3, 80)
LV_Add("", "软件名称", "现有版本","最新版本")
LV_Add("", "钉钉版本", dd_version)
LV_Add("", "Q Q版本", QQ_version)
Gui, Add, StatusBar
Gui Show, x1000 y150 w316 h555, 装机工具
Return
MyListView:
    if (A_GuiEvent = "DoubleClick")
    {
        LV_GetText(RowText, A_EventInfo, 2) ; 从行的第一个字段中获取文本.
        ToolTip %RowText%
        Sleep, 3000
        ToolTip
    }
return

Button安装钉钉:
    SB_SetText("正在安装钉钉！")
    runwait 钉钉.exe /S     ;需要离线安装包
    SB_SetText("钉钉安装成功！")
    RegRead, dd_version, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\钉钉, DisplayVersion
    LV_Add("", "钉钉_新", dd_version)
return
GuiEscape:
GuiClose:
ExitApp
;强制改权限
RunWith(RunAsAdmin:="Default", ANSI_U32_U64:="Default")
{
    ; 格式化预期的模式
    switch, RunAsAdmin
    {
        case "Normal","Standard","No","0":RunAsAdmin:=0
        case "Admin","Yes","1":RunAsAdmin:=1
        case "Default":RunAsAdmin:=A_IsAdmin
        default:RunAsAdmin:=A_IsAdmin
    }
    switch, ANSI_U32_U64
    {
        case "A32","ANSI","A":ANSI_U32_U64:="AutoHotkeyA32.exe"
        case "U32","X32","32":ANSI_U32_U64:="AutoHotkeyU32.exe"
        case "U64","X64","64":ANSI_U32_U64:="AutoHotkeyU64.exe"
        case "Default":ANSI_U32_U64:="AutoHotkey.exe"
        default:ANSI_U32_U64:="AutoHotkey.exe"
    }
}
;后台静默运行cmd命令缓存文本取值
cmdSilenceReturn(command){
    CMDReturn:=""
    cmdFN:="RunAnyCtrlCMD"
    try{
        RunWait,% ComSpec " /C " command " > ""%Temp%\" cmdFN ".log""",, Hide
        FileRead, CMDReturn, %A_Temp%\%cmdFN%.log
        FileDelete,%A_Temp%\%cmdFN%.log
    }catch{}
    return CMDReturn
}