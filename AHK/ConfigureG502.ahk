DetectHiddenText, On

Run, "Onboard Memory Manager.exe"

Sleep, 5000

Send, {Tab 17}
Sleep, 200
Send, {Space}
Sleep, 200

ControlGetText, OutputVar, Manager für integrierten Speicher
if ErrorLevel
    MsgBox, The target window doesn't exist or none of its controls has input focus.
else
    MsgBox, Control with focus = %OutputVar%