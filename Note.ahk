;ahk笔记和代码库


;----------------------------关于coordmode------------------------------
/*
关于coordmode，前面的pixel用于取色找图，后面的window用于窗口内
CoordMode, ToolTip|Pixel|Mouse , Screen|Relative|Window
所以可以有两个coordmode
*/
CoordMode, Pixel, window
;用于规定取色找图在窗口内，不是在整个屏幕，如果要在整个屏幕需要把window改成
;Screen才行。
CoordMode, Mouse , Window
;用于规定鼠标移动在窗口内，不是在整个屏幕，如果要在整个屏幕需要把window改成
;Screen才行。
;------------------------------------------------------------------------

;----------------------------关于找图的func------------------------------
/*
这个用于在代码里多次用于找图，可以更加快捷的调用，找到就下一步，找不到就一直找。
*/
WaitForImage("C:\c.bmp")

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
;------------------------------------------------------------------------