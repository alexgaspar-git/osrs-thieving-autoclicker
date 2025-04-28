#Requires AutoHotkey v2.0

; ---ONLY CHANGE THESE VALUES---
CLICK1_MIN := 150
CLICK1_MAX := 350
UPDATE_INTERVAL := 25
; ---ONLY CHANGE THESE VALUES---

CLICK2_MIN := CLICK1_MIN + 250
CLICK2_MAX := CLICK1_MAX + 250
TIMER_INTERVAL := 50
RuneLite := WinExist("ahk_exe RuneLite.exe")

global toggle := false
global count := 0
global ClickVal1
global ClickVal2

RefreshClickVal() {
    global ClickVal1 := Random(CLICK1_MIN, CLICK1_MAX)
    global ClickVal2 := Random(CLICK2_MIN, CLICK2_MAX)
}

ClickRandomly(Min, Max) {
    Click
    Rand := Random(Min, Max)
    Sleep(Rand)
}

IsOnWindow(WindowID) {
    MouseGetPos , , &MouseWinID
    return (MouseWinID = WindowID)
}

MainLoop() {
    global count
    if !toggle
        return
    if (count = UPDATE_INTERVAL) {
        RefreshClickVal()
        count := 0
    }
    if (IsOnWindow(RuneLite))
        ClickRandomly(ClickVal1, ClickVal2)
    count += 1
}

; SHIFT + S to toggle on/off

+s::{
    global toggle, count
    toggle := !toggle

    if toggle {
        count := 0
        RefreshClickVal()
        SetTimer(MainLoop, TIMER_INTERVAL)
    } else {
        SetTimer(MainLoop, false)
    }
}

+2::Reload
+3::ExitApp