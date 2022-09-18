#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
F1::
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, C:\c.bmp
if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
else if (ErrorLevel = 1)
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
