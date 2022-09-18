FileInstall, C:\test.bmp, test.bmp
Gui Font, s9, Segoe UI
Gui Add, Text, x70 y3 w240 h23 +0x200, 暗黑小工具
Gui Add, CheckBox, x10 y23 w71 h23, 单机模式
Gui Add, Text, x85 y23 w120 h23 +0x200, 单机模式自动下一把
Gui Add, CheckBox, x10 y43 w71 h23, 一键波波
Gui Add, Text, x85 y43 w120 h23 +0x200, 一键F2,F3,F4设置CTA
Gui Add, CheckBox, x10 y63 w71 h23, 快捷施法
Gui Add, Text, x85 y63 w120 h23 +0x200, 快捷键设置Q,W,E,R,T
gui, show, w210 h100, Window ; Leef_me likes bigger application windows
return

$Z::
ControlGet, isitchecked, Checked , , 单机模式, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{ 
Send {Z}
WaitForImage("Test.bmp")
;MouseMove 380, 335, , 测试坐标用
MouseClick Left, 760, 650, , , , 
Send {Enter}
Send {H}
MouseMove 760, 650
return
}
else
{
Send {z} 
return
}

$F1::
ControlGet, isitchecked, Checked , , 一键波波, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{
Send {F2}
MouseClick Right
sleep 300
Send {F3}
MouseClick Right
sleep 300
Send {F4}
MouseClick Right
sleep 300
Send {F5}
MouseClick Right
sleep 300
return
}
else
{
Send {F1}
return
}

$Q::
ControlGet, isitchecked, Checked , , 快捷施法, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{
Send {Q}
MouseClick Right
return
}
else
{
Send {q}
return
}
$W::
ControlGet, isitchecked, Checked , , 快捷施法, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{
Send {W}
MouseClick Right
return
}
else
{
Send {w}
return
}
$E::
ControlGet, isitchecked, Checked , , 快捷施法, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{
Send {E}
MouseClick Right
return
}
else
{
Send {e}
return
}
$R::
ControlGet, isitchecked, Checked , , 快捷施法, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{
Send {R}
MouseClick Right
return
}
else
{
Send {r}
return
}
$T::
ControlGet, isitchecked, Checked , , 快捷施法, Window
;tooltip, isitchecked ?--> %isitchecked%
If (isitchecked = 1)
{
Send {T}
MouseClick Right
return
}
else
{
Send {t}
return
}

WaitForImage(file)
{
	loop
	{
		ImageSearch, xPos, yPos, 260, 360, 3300, 1200,*50 %file%
		if (ErrorLevel = 0)
		{
			break
		}
	}
}

GuiClose:
GuiEscape:
ExitApp