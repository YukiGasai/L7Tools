EnvGet, OutputVar, LOCALAPPDATA

AudioDevice1 = "$$AudioDevice1$$"
AudioDevice2 = "$$AudioDevice2$$"
AudioDevice3 = "$$AudioDevice1$$"

BrowserPath =  % DefaultBrowser()
SplitPath, BrowserPath , BrowseExe

if(BrowseExe = "Launcher.exe"){
	BrowseExe = "opera.exe"
}


DefaultBrowser() {
	; Find the Registry key name for the default browser
	RegRead, BrowserKeyName, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice, Progid

	; Find the executable command associated with the above Registry key
	RegRead, BrowserFullCommand, HKEY_CLASSES_ROOT, %BrowserKeyName%\shell\open\command

	; The above RegRead will return the path and executable name of the brower contained within quotes and optional parameters
	; We only want the text contained inside the first set of quotes which is the path and executable
	; Find the ending quote position (we know the beginning quote is in position 0 so start searching at position 1)
	StringGetPos, pos, BrowserFullCommand, ",,1

	; Decrement the found position by one to work correctly with the StringMid function
	pos := --pos


	StringMid, BrowserPathandEXE, BrowserFullCommand, 2, %pos%
	
	Return BrowserPathandEXE
}

^!t::
Run, %LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe -p Ubuntu -d "\\wsl$\Ubuntu\home\ad"
return

^!enter::
Run, %LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe -d "C:\Users\Richard"
return

;=====================
;Change Sound output
;=====================

$$Key3$$ & 1::
Run, nircmd setdefaultsounddevice %AudioDevice1% 1
return

$$Key3$$ & 2::
Run, nircmd setdefaultsounddevice %AudioDevice2% 1
return

$$Key3$$ & 3::
Run, nircmd setdefaultsounddevice %AudioDevice3% 1
return


;=====================
;Change MAIN Volume
;=====================

$$Key3$$ & WheelDown::
Send {Volume_Down}  
return

$$Key3$$ & WheelUp::
Send {Volume_Up}  
return

$$Key3$$ & MButton::
Send {Volume_Mute} 
return

;=====================
;Controll BROWSER 
;=====================
$$Key1$$ & WheelDown::
	SoundBeep, 750, 100
run nircmd exec hide .\ChangeVol.bat %BrowseExe% -0.05
return

$$Key1$$ & WheelUp::
	SoundBeep, 750, 100 
run nircmd exec hide .\ChangeVol.bat %BrowseExe% +0.05
return

$$Key1$$ & MButton::
	SoundBeep, 750, 100 
run nircmd exec hide .\MuteVol.bat %BrowseExe% 2
return

$$Key1$$ & LButton::
	Send {Browser_Back}
return

$$Key1$$ & RButton::
	Send {Browser_Forward}
return

$$Key1$$ & $$Key5$$::
	Send {Ctrl Down}t{Ctrl Up}
return

$$Key1$$ & $$Key4$$::
	Send {Ctrl Down}T{Ctrl Up}
return

$$Key1$$ & $$Key2$$::
	Send {Ctrl Down}w{Ctrl Up}
return


;; Wheel Scroll Tabs for Chrome stuff Google Chrome, VS CODE

#IfWinActive ahk_class Chrome_WidgetWin_1 
 $$Key4$$ & WheelDown:: 
 Send ^{PgUp} 
 return 
 $$Key4$$ & WheelUp:: 
    Send ^{PgDn} 
Return 
#IfWinActive

;=====================
;Change DISCORD Volume
;=====================

$$Key5$$ & WheelDown::
	SoundBeep, 550, 100 
run nircmd exec hide .\ChangeVol.bat Discord.exe -0.1
return

$$Key5$$ & WheelUp::
	SoundBeep, 550, 100 
run nircmd exec hide .\ChangeVol.bat Discord.exe +0.1
return

$$Key5$$ & MButton::
	SoundBeep, 550, 100 
run nircmd exec hide .\MuteVol.bat Discord.exe 2
return


;=====================
;Controll Spotify
;=====================


;Volume down on Spotify
$$Key2$$ & WheelDown::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 1
Return

;Mute unmute Spotify
$$Key2$$ & MButton::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 2
Return

;Volume up on Spotify
$$Key2$$ & WheelUp::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 3
Return

;Get Previous Song
$$Key2$$ & LButton::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 4
Return

;Pause
$$Key2$$ & $$Key5$$::
	Run, %A_WorkingDir%\SpotiKey\SpotiKey.exe 5
Return

;Get Next Song
$$Key2$$ & RButton::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 6
Return

;hide/ hide Spotify
$$Key2$$ & $$Key4$$::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 7
Return

;Like song
$$Key2$$ & $$Key1$$::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 8
Return

;Get Lyrics
$$Key2$$ & $$Key3$$::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 9
Return


;===========================================
;Simple Hotkeys to start Programs  using $$Key3$$
;===========================================


$$KEYBOARDKEYS$$



;============================================
; SPecial Hotkeys to do stuff       Using $$Key2$$
;============================================

;;POP up On Screen Keyboard
$$Key5$$ & $$Key4$$::
{
 Run, osk.exe
 Return
}

$$Key4$$ & $$Key5$$::
{
 Run, osk.exe
 Return
}


;	
;Lower text when it its all caps
;
$$Key2$$ & Shift::
	oCB := ClipboardAll
	Send, ^c
	ClipWait,1
	
	Stringlower, ClipBoard, ClipBoard
	
	Send, ^v     

	ClipBoard := oCB       
return



;	
;Google selected text
;
$$Key2$$ & c::
{

 oCB := ClipboardAll

 Send, ^c
 Sleep 50
 Run, http://www.google.com/search?q=%clipboard%
 
 ClipBoard := oCB    
 Return
}



$$Key2$$ & v::
{
 SendRaw, ClipBoard

 Return
}






