EnvGet, OutputVar, LOCALAPPDATA

Browser = Vivaldi.lnk

^!t::
Run, %LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe -p Ubuntu -d "\\wsl$\Ubuntu\home\ad"
return

^!enter::
Run, %LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe -d "C:\Users\Richard"
return

^!n::
Run, C:\_dev\FHEGetMarks\note.bat
return


f15 & 1::
Run, nircmd setdefaultsounddevice "Aux Kabel" 1
return

f15 & 2::
Run, nircmd setdefaultsounddevice "Monitor" 1
return

f15 & 3::
Run, nircmd setdefaultsounddevice "Blue" 1
return

f15 & WheelDown::
Send {Volume_Down}  
return

f15 & WheelUp::
Send {Volume_Up}  
return

f15 & MButton::
Send {Volume_Mute} 
return

f14 & WheelDown::
	SoundBeep, 750, 100
run nircmd exec hide .\ChangeVol.bat Vivaldi.exe -0.05
return

f14 & WheelUp::
	SoundBeep, 750, 100 
run nircmd exec hide .\ChangeVol.bat Vivaldi.exe +0.05
return

f14 & MButton::
	SoundBeep, 750, 100 
run nircmd exec hide .\MuteVol.bat Vivaldi.exe 2
return


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
Run, %A_WorkingDir%\Links\%Browser% "https://www.instagram.com" " --new-tab "
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


;Googled text der Nach drücken eingegeben wird 
;Bestätigen mit Enter 
;Abbrechen mit Escape

f15 & f17::

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

f15 & Shift::
	oCB := ClipboardAll
	Send, ^c
	ClipWait,1
	
	StringLower, ClipBoard, ClipBoard
	
	Send, ^v     

	ClipBoard := oCB       
return


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
