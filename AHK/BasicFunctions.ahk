EnvGet, OutputVar, LOCALAPPDATA

Browser = Chrome.lnk

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
Run, nircmd setdefaultsounddevice "Aux Kabel" 1
return

f15 & 2::
Run, nircmd setdefaultsounddevice "Monitor" 1
return

f15 & 3::
Run, nircmd setdefaultsounddevice "Blue" 1
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
run nircmd exec hide .\ChangeVol.bat Chrome.exe -0.05
return

f13 & WheelUp::
	SoundBeep, 750, 100 
run nircmd exec hide .\ChangeVol.bat Chrome.exe +0.05
return

f13 & MButton::
	SoundBeep, 750, 100 
run nircmd exec hide .\MuteVol.bat Chrome.exe 2
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
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 1
Return

;Mute unmute Spotify
f14 & MButton::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 2
Return

;Volume up on Spotify
f14 & WheelUp::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 3
Return

;Get Previous Song
f14 & LButton::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 4
Return

;Pause
f14 & f17::
	Run, %A_WorkingDir%\SpotiKey\SpotiKey.exe 5
Return

;Get Next Song
f14 & RButton::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 6
Return

;hide/ hide Spotify
f14 & f16::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 7
Return

;Like song
f14 & f13::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 8
Return

;Get Lyrics
f14 & f15::
	Run,  %A_WorkingDir%\SpotiKey\SpotiKey.exe 9
Return


;===========================================
;Simple Hotkeys to start Programs  using f15
;===========================================


f15 & a::
Run, sndvol
return

f15 & b::
Run, %A_WorkingDir%\Links\%Browser% "https://github.com/YukiGasai/BetterDiscord" " --new-tab "
return

f15 & c::
Run, %A_WorkingDir%\Links\%Browser%
return

f15 & d::
Run, %A_WorkingDir%\Links\Discord.lnk
return

f15 & e::
Run, explorer.exe
return

f15 & f::
Run, %A_WorkingDir%\Links\%Browser% "https://fhemail.fh-erfurt.de/?_task=mail&_mbox=INBOX" " --new-tab "
return

f15 & g::
Run, %A_WorkingDir%\Links\%Browser% "https://github.com/YukiGasai" " --new-tab "
return

f15 & h::
Run, %A_WorkingDir%\Links\GemischtesHack.vbs
return

f15 & i::
Run, %A_WorkingDir%\Links\IntelliJ.lnk
return

f15 & j::
Run, %A_WorkingDir%\Links\Juice.vbs
return

f15 & k::

return

f15 & l::
Run, %A_WorkingDir%\Links\LeagueClient.exe.lnk
return

f15 & m::
Run, %A_WorkingDir%\Links\%Browser% "https://moodle.fh-erfurt.de" " --new-tab "
return

f15 & n::
Run, %A_WorkingDir%\Links\%Browser% "https://www.netflix.com/" " --new-tab "
return

f15 & o::
Run, %A_WorkingDir%\Links\osu!.lnk
return

f15 & p::
Run, %A_WorkingDir%\Links\PNerv.bat
return

f15 & q::

return

f15 & r::
Run, %A_WorkingDir%\Links\%Browser% "https://www.reddit.com/" " --new-tab "
return

f15 & s::
Run, %A_WorkingDir%\Links\Steam.lnk
return

f15 & t::
Run, %A_WorkingDir%\Links\%Browser% "https://www.twitch.tv/" " --new-tab "
return

f15 & u::

return

f15 & v::
Run, %A_WorkingDir%\Links\Visual Studio Code.lnk
return

f15 & w::
Run, %A_WorkingDir%\Links\%Browser% "https://web.whatsapp.com" " --new-tab "
return

f15 & x::

return

f15 & y::
Run, %A_WorkingDir%\Links\%Browser% "https://www.youtube.com/?hl=de&gl=DE" " --new-tab"
return

f15 & z::

return



;============================================
; SPecial Hotkeys to do stuff       Using f14
;============================================


;Googled text der Nach drücken eingegeben wird 
;Bestätigen mit Enter 
;Abbrechen mit Escape

f13 & f14::

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
			Run, %A_WorkingDir%\Links\%Browser% "https://duckduckgo.com/?q="%SearchString%
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









