EnvGet, OutputVar, LOCALAPPDATA

AudioDevice1 = "Aux Kabel"
AudioDevice2 = "Monitor"
AudioDevice3 = "Blue"

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

^!n::
Run, C:\_dev\FHEGetMarks\note.bat
return



;=====================
;Change Sound output
;=====================

f15 & 1::
Run, nircmd setdefaultsounddevice %AudioDevice1% 1
return

f15 & 2::
Run, nircmd setdefaultsounddevice %AudioDevice2% 1
return

f15 & 3::
Run, nircmd setdefaultsounddevice %AudioDevice3% 1
return


;=====================
;Change MAIN Volume
;=====================

f15 & WheelDown::
Send {Volume_Down}  
return

f15 & WheelUp::
Send {Volume_Up}  
return

f15 & MButton::
Send {Volume_Mute} 
return

;=====================
;Controll BROWSER 
;=====================
f13 & WheelDown::
	SoundBeep, 750, 100
run nircmd exec hide .\ChangeVol.bat %BrowseExe% -0.05
return

f13 & WheelUp::
	SoundBeep, 750, 100 
run nircmd exec hide .\ChangeVol.bat %BrowseExe% +0.05
return

f13 & MButton::
	SoundBeep, 750, 100 
run nircmd exec hide .\MuteVol.bat %BrowseExe% 2
return

f13 & LButton::
	Send {Browser_Back}
return

f13 & RButton::
	Send {Browser_Forward}
return

f13 & f17::
	Send {Ctrl Down}t{Ctrl Up}
return

f13 & f16::
	Send {Ctrl Down}T{Ctrl Up}
return

f13 & f14::
	Send {Ctrl Down}w{Ctrl Up}
return


;; Wheel Scroll Tabs for Chrome stuff Google Chrome, VS CODE

#IfWinActive ahk_class Chrome_WidgetWin_1 
 f16 & WheelDown:: 
 Send ^{PgUp} 
 return 
 f16 & WheelUp:: 
    Send ^{PgDn} 
Return 
#IfWinActive

;=====================
;Change DISCORD Volume
;=====================

f17 & WheelDown::
	SoundBeep, 550, 100 
run nircmd exec hide .\ChangeVol.bat Discord.exe -0.1
return

f17 & WheelUp::
	SoundBeep, 550, 100 
run nircmd exec hide .\ChangeVol.bat Discord.exe +0.1
return

f17 & MButton::
	SoundBeep, 550, 100 
run nircmd exec hide .\MuteVol.bat Discord.exe 2
return


;=====================
;Controll Spotify
;=====================


;Volume down on Spotify
f14 & WheelDown::
	Run,  %A_WorkingDir%\SpotiKey.exe 1
Return

;Mute unmute Spotify
f14 & MButton::
	Run,  %A_WorkingDir%\SpotiKey.exe 2
Return

;Volume up on Spotify
f14 & WheelUp::
	Run,  %A_WorkingDir%\SpotiKey.exe 3
Return

;Get Previous Song
f14 & LButton::
	Run,  %A_WorkingDir%\SpotiKey.exe 4
Return

;Pause
f14 & f17::
	Run, %A_WorkingDir%\SpotiKey.exe 5
Return

;Get Next Song
f14 & RButton::
	Run,  %A_WorkingDir%\SpotiKey.exe 6
Return

;hide/ hide Spotify
f14 & f16::
	Run,  %A_WorkingDir%\SpotiKey.exe 7
Return

;Like song
f14 & f13::
	Run,  %A_WorkingDir%\SpotiKey.exe 8
Return

;Get Lyrics
f14 & f15::
	Run,  %A_WorkingDir%\SpotiKey.exe 9
Return


;===========================================
;Simple Hotkeys to start Programs  using f15
;===========================================


f15 & a::
Run, sndvol
return

f15 & b::
Run, %BrowserPath% "https://github.com/YukiGasai/BetterDiscord" 
return

f15 & c::
Run, %BrowserPath%
return

f15 & d::
Run, C:\Users\Richard\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk
return

f15 & e::
Run, explorer.exe
return

f15 & f::
Run, %BrowserPath% "https://fhemail.fh-erfurt.de/?_task=mail&_mbox=INBOX" 
return

f15 & g::
Run, %BrowserPath% "https://github.com/YukiGasai" 
return

f15 & h::
Run, C:\_dev\L7Tools\AHK\Links\GemischtesHack.vbs
return

f15 & i::
Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\JetBrains\IntelliJ IDEA Community Edition 2020.2.3.lnk
return

f15 & j::
Run, C:\_dev\L7Tools\AHK\Links\Juice.vbs
return

f15 & k::

return

f15 & l::
Run, C:\Users\Public\Desktop\VALORANT.lnk
return

f15 & m::
Run, %BrowserPath% "https://moodle.fh-erfurt.de" 

f15 & n::
Run, %BrowserPath% "https://www.netflix.com/"
return

f15 & o::
Run, ‪C:\Users\Richard\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\osu!.lnk
return

f15 & p::
Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Project64 2.3\Project64.lnk
return

f15 & q::

return

f15 & r::
Run, %BrowserPath% "https://www.reddit.com/" 
return

f15 & s::
Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Steam\Steam.lnk
return

f15 & t::
Run, %BrowserPath% "https://www.twitch.tv/" 
return

f15 & u::
Run, C:\Users\Richard\AppData\Roaming\Microsoft\Windows\Start Menu\Uplay.lnk
return

f15 & v::
Run, C:\Users\Richard\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk
return

f15 & w::
Run, %BrowserPath% "https://web.whatsapp.com" 
return

f15 & x::
Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\XAMPP\XAMPP Control Panel.lnk
return

f15 & y::
Run, %BrowserPath% "https://www.youtube.com/?hl=de&gl=DE" 
return

f15 & z::

return



;============================================
; SPecial Hotkeys to do stuff       Using f14
;============================================


;Googled text der Nach drücken eingegeben wird 
;Bestätigen mit Enter 
;Abbrechen mit Escape

f24 & f14::

	SoundBeep, 750, 750 
	Input , Search, M, {Enter}{Escape}{F13}{F14}{F15}{F16}{F17}
	
	If InStr(ErrorLevel, "EndKey:")
	{
		if(ErrorLevel != "EndKey:Enter")
		{
			SoundBeep, 550, 750 
			return
		}else{
			SearchString := uriEncode(Search)
			Run, %BrowserPath% "https://duckduckgo.com/?q="%SearchString%
		}
	}
	
	uriEncode(str)
	{
		b_Format := A_FormatInteger
		data := ""
		SetFormat,Integer,H
		Loop,Parse,str
			if ((Asc(A_LoopField)>0x7f) || (Asc(A_LoopField)<0x30) || (asc(A_LoopField)=0x3d))
				data .= "%" . ((StrLen(c:=SubStr(ASC(A_LoopField),3))<2) ? "0" . c : c)
			Else
				data .= A_LoopField
		SetFormat,Integer,%b_format%
		return data
	}
return


;	
;Lower text when it its all caps
;
f14 & Shift::
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
f14 & c::
{

 oCB := ClipboardAll

 Send, ^c
 Sleep 50
 Run, http://www.google.com/search?q=%clipboard%
 
 ClipBoard := oCB    
 Return
}



f14 & v::
{
 SendRaw, ClipBoard

 Return
}



f17 & f16::
{
Process, Exist, osk.exe ; check to see if osk is running
		{
		If errorLevel = 0
			Run, osk.exe
		else
			run,%comspec% /k wmic process where name="osk.exe" call terminate && exit
		}
return
}


f16 & f17::
{
Process, Exist, osk.exe ; check to see if osk is running
		{
		If errorLevel = 0
			Run, osk.exe
		else
			run,%comspec% /k wmic process where name="osk.exe" call terminate && exit
		}
return
}



