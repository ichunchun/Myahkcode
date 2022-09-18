
#IfWinActive, ahk_class Diablo II

$f1::
    {
        ;1440x900分辨率用1400,860；1270x800用 1300,700
        ;退出
        Send {esc}
        MouseClick Left, 734, 432,1 
        WaitForImage("C:\c.bmp")
        ;开始
        MouseClick Left, 593, 483,1
        MouseClick Left, 665, 443,1 
    }
Return

$F2::
    {
        Send {F2}
        MouseClick Right
    }
return

$F3::
    {
        Send {F3}
        MouseClick Right
    }
return

$F4::
    {
        Send {F4}
        MouseClick Right
    }
return

$F5::
    {
        Send {F5}
        MouseClick Right
    }
return

$q::
    {
        Send {q}
        MouseClick Right
    }
return

$w::
    {
        Send {w}
        MouseClick Right
    }
return

$e::
    {
        Send {e}
        MouseClick Right
    }
return

$r::
    {
        Send {r}
        MouseClick Right
    }
return

$t::
    {
        Send {t}
        MouseClick Right
    }
return
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
#IfWinActive
