#Requires AutoHotkey v2.0

; ---ONLY CHANGE THESE VALUES---
CLICK1_MIN := 50
CLICK1_MAX := 150
CLICK2_OFFSET := 350
; ---ONLY CHANGE THESE VALUES---

CLICK2_MIN := CLICK1_MIN + CLICK2_OFFSET
CLICK2_MAX := CLICK1_MAX + CLICK2_OFFSET
TIMER_INTERVAL := 50
RuneLite := WinExist("ahk_exe RuneLite.exe")

global toggle := false

RandClick(Min, Max) {
    Click
    Rand := Random(Min, Max)
    Sleep(Rand)
}

IsOnWindow(WinID) {
    MouseGetPos , , &MouseWinID
    return (MouseWinID = WinID)
}

MainLoop() {
    global toggle
    if !toggle
        return
    if (IsOnWindow(RuneLite))
        RandClick(Random(CLICK1_MIN, CLICK1_MAX), Random(CLICK2_MIN, CLICK2_MAX))
}

; SHIFT + S to toggle on/off

+s::{
    global toggle
    toggle := !toggle

    if toggle
        SetTimer(MainLoop, TIMER_INTERVAL)
    else
        SetTimer(MainLoop, false)
}

+2::Reload
+3::ExitApp